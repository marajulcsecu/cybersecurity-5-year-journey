#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="${SCRIPT_DIR}/part2_patched_vault.c"
BIN="${SCRIPT_DIR}/part2_patched_vault"

if [ ! -f "${SRC}" ]; then
  echo "[FAIL] Missing ${SRC}"
  echo "       Copy part2_vuln_vault.c -> part2_patched_vault.c, patch all 3 bugs, then re-run!"
  exit 1
fi

echo "=== Lab 0A Hardening & Sanitizer Verification ==="
echo "[*] Compiling part2_patched_vault.c with -Wall -Wextra -Werror -fsanitize=address,undefined ..."
gcc -g -O1 -Wall -Wextra -Werror -fsanitize=address,undefined -o "${BIN}" "${SRC}"
echo "  [PASS] Clean compile with strict warnings + ASan/UBSan"

PASS=1
FAIL=0

check_pass() { echo "  [PASS] $1"; PASS=$((PASS + 1)); }
check_fail() { echo "  [FAIL] $1"; FAIL=$((FAIL + 1)); }

# 1. Exploit 1: uint32 wrap-around (8589935 * 1000 mod 2^32 = 408 <= 500)
OUT1="$("${BIN}" buy 8589935 2>&1 || true)"
if echo "${OUT1}" | grep -q "FLAG{" || "${BIN}" buy 8589935 >/dev/null 2>&1; then
  check_fail "Exploit 1 (buy 8589935 wrap-around) STILL SUCCEEDS!"
else
  check_pass "Blocked Exploit 1A: buy 8589935 (uint32 wrap-around)"
fi

OUT1B="$("${BIN}" buy 12884902 2>&1 || true)"
if echo "${OUT1B}" | grep -q "FLAG{" || "${BIN}" buy 12884902 >/dev/null 2>&1; then
  check_fail "Exploit 1B (buy 12884902 wrap-around) STILL SUCCEEDS!"
else
  check_pass "Blocked Exploit 1B: buy 12884902 (uint32 wrap-around)"
fi

# 2. Exploit 2: Negative signed length promotion (-5 and INT32_MIN)
OUT2A="$("${BIN}" copy -5 2>&1 || true)"
if echo "${OUT2A}" | grep -q "FLAG{" || "${BIN}" copy -5 >/dev/null 2>&1; then
  check_fail "Exploit 2A (copy -5 signedness bypass) STILL SUCCEEDS!"
else
  check_pass "Blocked Exploit 2A: copy -5 (negative signed length)"
fi

OUT2B="$("${BIN}" copy -2147483648 2>&1 || true)"
if echo "${OUT2B}" | grep -q "FLAG{" || "${BIN}" copy -2147483648 >/dev/null 2>&1; then
  check_fail "Exploit 2B (copy INT32_MIN signedness bypass) STILL SUCCEEDS!"
else
  check_pass "Blocked Exploit 2B: copy -2147483648 (INT32_MIN)"
fi

# 3. Exploit 3: NUL-byte truncation ("secret.key\x00.txt")
OUT3="$("${BIN}" open 7365637265742e6b6579002e747874 2>&1 || true)"
if echo "${OUT3}" | grep -q "FLAG{" || "${BIN}" open 7365637265742e6b6579002e747874 >/dev/null 2>&1; then
  check_fail "Exploit 3 (NUL-byte truncation secret.key\\x00.txt) STILL SUCCEEDS!"
else
  check_pass "Blocked Exploit 3: embedded NUL byte (secret.key\\x00.txt)"
fi

# 4. Regression checks: legitimate benign operations MUST still work!
if "${BIN}" copy 32 >/dev/null 2>&1; then
  check_pass "Regression OK: benign 'copy 32' still succeeds"
else
  check_fail "Regression broken: benign 'copy 32' was wrongly rejected!"
fi

if "${BIN}" open 68656c6c6f2e747874 >/dev/null 2>&1; then
  check_pass "Regression OK: benign 'open hello.txt' still succeeds"
else
  check_fail "Regression broken: benign 'open hello.txt' was wrongly rejected!"
fi

if ! "${BIN}" buy 1 >/dev/null 2>&1; then
  check_pass "Regression OK: unaffordable 'buy 1' (1000 > 500) still denied"
else
  check_fail "Regression broken: 'buy 1' should be denied when balance=500!"
fi

echo "------------------------------------------------"
echo "Summary: ${PASS} passed, ${FAIL} failed"
if [ "${FAIL}" -gt 0 ]; then
  exit 1
fi
echo "[+] Lab 0A patched cleanly with zero warnings & zero sanitizer errors!"
