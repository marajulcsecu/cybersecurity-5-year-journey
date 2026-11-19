#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="lab1a-suid-caps"

if ! docker ps --format '{{.Names}}' | grep -qx "${CONTAINER_NAME}"; then
  echo "[FAIL] Container '${CONTAINER_NAME}' is not running. Start it with ./run_lab.sh first."
  exit 1
fi

echo "=== Lab 1A Hardening Verification Audit (${CONTAINER_NAME}) ==="

PASS=0
FAIL=0

check_pass() { echo "  [PASS] $1"; PASS=$((PASS + 1)); }
check_fail() { echo "  [FAIL] $1"; FAIL=$((FAIL + 1)); }

# 1. Check /usr/local/bin/audit-find has no SUID/SGID bit (or was removed)
if docker exec -u root "${CONTAINER_NAME}" bash -c 'test ! -e /usr/local/bin/audit-find || { test ! -u /usr/local/bin/audit-find && test ! -g /usr/local/bin/audit-find; }'; then
  check_pass "/usr/local/bin/audit-find has no SUID/SGID bit (or removed)"
else
  check_fail "/usr/local/bin/audit-find still has SUID/SGID privileges!"
fi

# 2. Check /usr/local/bin/py-diag has no file capabilities (or was removed)
CAPS_PY="$(docker exec -u root "${CONTAINER_NAME}" bash -c 'if [ -e /usr/local/bin/py-diag ]; then getcap /usr/local/bin/py-diag; fi')"
if [ -z "${CAPS_PY}" ]; then
  check_pass "/usr/local/bin/py-diag has no Linux file capabilities (or removed)"
else
  check_fail "/usr/local/bin/py-diag still has capabilities: ${CAPS_PY}"
fi

# 3. Check /usr/local/bin/backup-tar has no file capabilities (or was removed)
CAPS_TAR="$(docker exec -u root "${CONTAINER_NAME}" bash -c 'if [ -e /usr/local/bin/backup-tar ]; then getcap /usr/local/bin/backup-tar; fi')"
if [ -z "${CAPS_TAR}" ]; then
  check_pass "/usr/local/bin/backup-tar has no Linux file capabilities (or removed)"
else
  check_fail "/usr/local/bin/backup-tar still has capabilities: ${CAPS_TAR}"
fi

# 4. Behavioral exploit re-test as low-priv user 'student'
if docker exec -u student "${CONTAINER_NAME}" bash -c '
  if [ -e /usr/local/bin/audit-find ]; then
    OUT=$(/usr/local/bin/audit-find /etc/hostname -exec /bin/sh -p -c "id -u" \; -quit 2>/dev/null || true)
    [ "$OUT" != "0" ]
  fi
'; then
  check_pass "Behavioral test: student cannot gain EUID=0 via audit-find"
else
  check_fail "Behavioral test: student STILL gains EUID=0 via audit-find!"
fi

if docker exec -u student "${CONTAINER_NAME}" bash -c '
  if [ -e /usr/local/bin/py-diag ]; then
    ! /usr/local/bin/py-diag -c "import os; os.setuid(0)" 2>/dev/null
  fi
'; then
  check_pass "Behavioral test: student cannot call os.setuid(0) via py-diag"
else
  check_fail "Behavioral test: student STILL escalates via py-diag!"
fi

if docker exec -u student "${CONTAINER_NAME}" bash -c '
  if [ -e /usr/local/bin/backup-tar ]; then
    ! /usr/local/bin/backup-tar -cf - /root/flags/flag3_cap_dac.txt 2>/dev/null | grep -q "FLAG{"
  fi
'; then
  check_pass "Behavioral test: student cannot bypass DAC read checks via backup-tar"
else
  check_fail "Behavioral test: student STILL reads /root flags via backup-tar!"
fi

echo "------------------------------------------------"
echo "Summary: ${PASS} passed, ${FAIL} failed"

if [ "${FAIL}" -gt 0 ]; then
  exit 1
fi
echo "[+] Lab 1A successfully hardened!"
