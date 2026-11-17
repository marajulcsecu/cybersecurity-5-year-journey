FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install minimal capability tooling and Python runtime (no bloat)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcap2-bin \
    python3-minimal \
    && rm -rf /var/lib/apt/lists/*

# Create low-privilege student account (UID 1000 or next available)
RUN useradd -m -s /bin/bash student

# Create root-only flags (0600) to prove each escalation / DAC-bypass vector independently
RUN mkdir -p /root/flags && chmod 700 /root/flags \
    && echo "FLAG{lab1a_1_suid_euid_root_achieved}" > /root/flags/flag1_suid.txt \
    && echo "FLAG{lab1a_2_cap_setuid_root_achieved}" > /root/flags/flag2_cap_setuid.txt \
    && echo "FLAG{lab1a_3_cap_dac_override_bypass}" > /root/flags/flag3_cap_dac.txt \
    && chmod 600 /root/flags/*.txt

# --- INTENTIONAL MISCONFIGURATIONS (FOR LAB 1A PRACTICE ONLY) ---
# 1. Misconfigured SUID binary (copy of find with 4755 root SUID)
RUN cp /usr/bin/find /usr/local/bin/audit-find \
    && chown root:root /usr/local/bin/audit-find \
    && chmod 4755 /usr/local/bin/audit-find

# 2. Misconfigured binary capability: cap_setuid+ep on Python binary (no SUID bit!)
RUN PY_REAL="$(readlink -f /usr/bin/python3)" \
    && cp "$PY_REAL" /usr/local/bin/py-diag \
    && chown root:root /usr/local/bin/py-diag \
    && chmod 0755 /usr/local/bin/py-diag \
    && setcap cap_setuid+ep /usr/local/bin/py-diag

# 3. Misconfigured capability: cap_dac_override+ep on tar (bypasses DAC read/write checks; in Docker default CapBnd!)
RUN cp /usr/bin/tar /usr/local/bin/backup-tar \
    && chown root:root /usr/local/bin/backup-tar \
    && chmod 0755 /usr/local/bin/backup-tar \
    && setcap cap_dac_override+ep /usr/local/bin/backup-tar

WORKDIR /home/student
USER student

CMD ["/bin/bash"]
