# Phase 1: Core Foundations, Network Defense & Hybrid AI Workflow (Months 1–2 / Weeks 1–8)

- **Interactive 8-Week Checklist Dashboard:** [`phase_1_detailed_plan.html`](./phase_1_detailed_plan.html)
- **Printable 8-Week PDF Plan:** [`phase_1_detailed_plan.pdf`](./phase_1_detailed_plan.pdf)

## Active Lessons, Labs, Writeups & Tools
- **Week 1 — Lesson 1 (Interactive Visual HTML):** [`lessons/week1_lesson1_linux_internals.html`](./lessons/week1_lesson1_linux_internals.html)
- **Week 1 — Lab 1A (Docker SUID & Capabilities PrivEsc + Hardening):** [`labs/week1_lab1_suid_caps/`](./labs/week1_lab1_suid_caps/README.md)
- **Student Writeups & Feynman Checks:** [`writeups/`](./writeups/README.md)
- **Security Automation & AI Tools:** [`tools/`](./tools/README.md)

## 4 Two-Week Sprints Overview
1. **Sprint 1 (Weeks 1–2): Linux OS Internals, Hardening & Hybrid AI Setup**
   - Week 1: Docker Engine setup, Google Colab GPU Ollama Tunnel, Linux Processes/Permissions/SUID/Capabilities, OverTheWire Bandit 0→15, `suid_cap_scanner.py`.
   - Week 2: PAM/Shadow, SSH Hardening, Container Namespaces/cgroups, `auditd`/`auth.log` analysis, OverTheWire Bandit 16→25, `linux_hardening_auditor.py`.
2. **Sprint 2 (Weeks 3–4): TCP/IP Packet Mechanics, TLS 1.3 & Linux Firewalls**
   - Week 3: Layer 2–4 packet dissection (`tcpdump`, `Wireshark`, `tshark`), ARP, TCP handshakes/scans, DNS internals, Python `scapy` & `pcap_triage_extractor.py`.
   - Week 4: HTTP/1.1–3, TLS 1.3 handshakes, `SSLKEYLOGFILE` decryption, Stateful Firewalls (`ufw` / `nftables`), automated firewall & TLS auditor scripts.
3. **Sprint 3 (Weeks 5–6): Applied Cryptography & Attacking Broken Crypto**
   - Week 5: `AES-GCM`, `RSA`/`Ed25519`, `SHA-256`/`HMAC`, Password Hashing (`Argon2id`/`bcrypt`), building `crypto_vault_cli.py`.
   - Week 6: Attacking ECB, CBC bit-flipping, Nonce/IV reuse, insecure PRNGs, and JWT flaws (`alg: none`, weak HMAC, key confusion), building `crypto_jwt_auditor.py`.
4. **Sprint 4 (Weeks 7–8): Threat Modeling (STRIDE), CVSS v4.0 & Capstone Portfolio Tool #1**
   - Week 7: STRIDE Threat Modeling, Data Flow Diagrams, CWE/CVSS v4.0 scoring, MITRE ATT&CK basics, and building the core deterministic parser of `ai-secops-pcap-log-analyzer`.
   - Week 8: Integrating LLM Incident Reporting (Gemini API / Colab Ollama), solving the Phase 1 Multi-Artifact Breach Lab, and publishing Portfolio Tool #1 to GitHub.
