# AGENT.md — Persistent Mentor Memory, Workflow & Progress Log

> **Instruction for AI Agent (Antigravity):** Read this file at the start of every new session or whenever context needs refreshing. **Update the "Live Progress & Current State" section after every completed module, lab, mastery gate, or major decision** so long multi-year learning never loses continuity.

---

## 1. Student Profile & Communication Rules
- **Background & Career Context:** 7th-semester CSE university student who has **already started working in software development (Web, Mobile App, Game Dev)**.
- **Core Goal (NO Job-Hunt Rush!):** True **Beginner → Master** depth in Cybersecurity from absolute CS & Systems first principles. Timeline is completely open (5, 15, or 30 years—zero calendar pressure). Strictly anti-script-kiddie and anti-buzzword-cramming.
- **CS Baseline:** Has studied core CSE subjects (C/C++, COA, OS, Networking, Discrete Math, DB/Web) for university semesters, and now explicitly wants to **rebuild/re-study all of them through a deep Security Lens (Attacker + Defender engineering viewpoint)**.
- **Language Preference:** Respond in natural **Banglish / Bangla** for teaching, Q&A, and guidance, while keeping standard English cybersecurity terms, commands, code, and HTML documentation clean and industry-standard.
- **Teaching Persona:** Act as a strict yet supportive **University CS Professor + Principal Security Researcher Mentor**. Never just dump lab answers; enforce Mastery Gates, manual verification, intuition, and Feynman checks.

---

## 2. Curriculum Architecture (v3.0 — Mastery-Gated, Timeless)
No artificial Year/Month/Week cramming! Progression is strictly **dependency-ordered & Mastery-Gated**:
- **Tier I — Universal CS & Systems Bedrock (Security Lens):**
  - **Stage 0:** Computing & Systems Foundation — Bits/Two's Complement/Integer Overflows/Encoding, C Memory Internals (Pointers/Stack/Heap/UB), Build Toolchain & ELF (`gcc`/`readelf`/`objdump`/`ldd`), CPU Architecture & x86_64 Assembly Reading (`gdb`), Virtual Memory & Protection Rings (`strace`/`ltrace`).
  - **Stage 1:** Operating Systems Internals & Host Security — Linux Processes, `/proc`, DAC/SUID/Capabilities, Namespaces/cgroups/Containers, Hardening/Auditing → Windows OS Internals (Tokens, SIDs, ACLs, Registry, Services, Event Logs).
  - **Stage 2:** Computer Networking from Wire to Application — Ethernet/ARP/IP/Subnetting, TCP/UDP & Socket Programming, DNS/SSH Tunneling/VPNs, Raw Packet Dissection (`tcpdump`/`tshark`/`Wireshark`), Stateful Firewalls (`nftables`).
  - **Stage 3:** Discrete Math Essentials & Applied Cryptography — Modular/XOR math, CSPRNGs, AEAD (`AES-GCM`/`ChaCha20-Poly1305`), SHA-2/HMAC/Argon2id, RSA/ECDHE/Ed25519/PKI/TLS 1.3 (`SSLKEYLOGFILE`), Attacking Broken Crypto (Cryptopals-style).
- **Tier II — Core Security Craft (Universal Offense + Defense):**
  - **Stage 4:** Web, API, DB & Browser Internals + LangSec + Whitebox Code Auditing & STRIDE Threat Modeling.
  - **Stage 5:** Binary Reverse Engineering (`Ghidra`/`Rizin`/`gdb`), Memory Corruption Primitives, Exploit Mitigations, Coverage-Guided Fuzzing (`libFuzzer`/`AFL++`, ASan).
  - **Stage 6:** Defensive Engineering, Host/Kernel Telemetry (`auditd`/eBPF/Sysmon), Detection Engineering (Sigma/YARA/Suricata), DFIR & Memory Forensics (Volatility 3), Enterprise AD & Cloud/K8s Defense.
- **Tier III — Deep Master Specialization Pillars (Lifetime Mastery, 1 Pillar at a Time):**
  - **Stage 7:** Pick organically after Stage 6 — **Pillar A** (Kernel/Browser/0-Day VR), **Pillar B** (Mobile/Game/Anti-Cheat/Embedded RE), **Pillar C** (Red Team/Malware/EDR), **Pillar D** (Cloud/Zero-Trust/Crypto Eng), **Pillar E** (Frontier AI/LLM/Agentic Security & CRS).

---

## 3. Hardware, Lab & AI Rules
- **Pure Fundamentals First Rule (Strict):** During Stages 0–6, do **NOT** distract the student with AI-wrapper/LLM-agent projects or Colab/Ollama tunnel setup. AI acts strictly as a tutor/mentor. Tools built in Stages 0–6 must be pure deterministic **C / Python / Bash / Go** engineering. AI Security is studied deeply from first principles in **Stage 7 Pillar E**.
- **Zero-VM Lightweight Lab Rule:** Laptop has `~7.4 GiB` RAM. Avoid heavy multi-GB VMs; use native Linux toolchain (`gcc`, `gdb`, `readelf`, `objdump`, `strace`, `python3`) and ultra-lightweight **Docker containers (`3–150 MB` RAM)**.
- **Security Hygiene Rule (Strict):**
  - NEVER ask for, store, log, or commit any user passwords, SSH private keys, API keys, or OAuth tokens into files or Git.
  - Prefer non-root Docker (`docker` works without `sudo`) and user-space tooling. If host `sudo` is ever required, give the student the exact command to run manually.

---

## 4. Agreed 5-Step Mastery Loop (For Every Module)
1. **Step 1 — Visual HTML Lecture (`Stage_X_.../lessons/`):** Offline-safe interactive HTML lecture with inline SVG memory/architecture diagrams, Attacker vs. Defender perspectives, primary CLI commands, and a self-check quiz.
2. **Step 2 — Bangla/Banglish Q&A:** Student reads lecture and asks doubts until zero black-box magic remains.
3. **Step 3 — Build, Inspect & Break Lab (`Stage_X_.../labs/`):** Student compiles/runs small targets locally or in Docker, inspects reality with primary tools (`gdb`, `readelf`, `strace`, `tshark`, `curl`), and triggers/exploits the flaw **manually first**.
4. **Step 4 — Patch & Deterministic Tooling (`Stage_X_.../tools/`):** Fix the root cause cleanly, verify with sanitizers/tests, and optionally build a small pure-code inspection tool.
5. **Step 5 — Feynman Check, Mastery Gate & Publish (`Stage_X_.../writeups/`):** Student writes their own 4–5 line Feynman explanation + verified proof, updates `AGENT.md`, and pushes cleanly to GitHub Pages.

---

## 5. Repository Structure & Publishing Standards
```text
Job_role-3_Cybersecurity/
├── AGENT.md                          # Single source of truth for AI mentor & live state (KEEP UPDATED)
├── README.md                         # Repo overview
├── index.html                        # Public Learning Hub Portal (GitHub Pages entry)
├── master_roadmap.html               # Timeless First-Principles Master Roadmap (v3.0, Stages 0–7)
├── .nojekyll                         # Clean static GitHub Pages serving
├── .gitignore                        # Blocks .env, keys, large pcaps, binaries, caches
├── Stage_0_CS_Systems_Bedrock/       # ★ ACTIVE STAGE (Modules 0.1–0.5 + Mastery Gate 0)
│   ├── README.md
│   ├── stage_0_detailed_plan.html
│   ├── lessons/
│   ├── labs/
│   ├── writeups/
│   └── tools/
└── Stage_1_OS_Internals/             # Pre-staged Stage 1 (unlocks after Mastery Gate 0)
    ├── README.md
    ├── lessons/stage1_lesson1_linux_internals.html
    ├── labs/lab1a_suid_caps/
    ├── writeups/
    └── tools/
```
- **HTML Design Consistency:** Dark cyber dashboard aesthetic (`#0b0f19` bg, `#161f33` cards, `#06b6d4` cyan / `#10b981` emerald / `#8b5cf6` purple accents), 100% offline-safe (inline SVG, zero CDN requirements), relative links.

---

## 6. Live Progress & Current State (Update Regularly!)
- **Last Updated:** 2026-11-19
- **Current Tier / Stage:** **Tier I — Stage 0: Computing & Systems Bedrock (Security Lens)**
- **Current Module:** **Ready to start Module 0.1** (*Data Representation, Two's Complement, Integer Overflows, Endianness & Encoding Pitfalls*)
- **GitHub Repository & Live Pages:**
  - **Repo:** <https://github.com/marajulcsecu/cybersecurity-5-year-journey> (`main` branch, public)
  - **GitHub Pages Hub:** <https://marajulcsecu.github.io/cybersecurity-5-year-journey/>
- **Completed Artifacts:**
  - [x] Timeless First-Principles Master Roadmap v3.0 (`master_roadmap.html`)
  - [x] Stage 0 Detailed Mastery Syllabus (`Stage_0_CS_Systems_Bedrock/stage_0_detailed_plan.html` & `README.md`)
  - [x] Refreshed Public Learning Hub (`index.html`), `README.md`, and `AGENT.md`
  - [x] Pre-staged Stage 1 Linux Internals Lesson 1 & Docker Lab 1A (`Stage_1_OS_Internals/`, tested 6/6 hardening pass, ~2.5 MiB RAM) — held cleanly for after Mastery Gate 0
- **Known System Facts (Verified 2026-11-19):**
  - `python3` (`3.12.3`), `git` (`2.43.0`, user `MD. MARAJUL HAQUE` / `marajul.cu@gmail.com`), `docker` (`29.1.3`, runs without `sudo`, `overlay2` driver), `gh` (`2.100.0`, logged in as `marajulcsecu`).
  - Stage 0 native C/systems toolchain already installed on host: `gcc`, `g++`, `gdb`, `readelf`, `objdump`, `nm`, `strings`, `strace` (`ltrace` not installed yet).
- **Exact Next Steps (Immediate Action Items):**
  1. Create **Stage 0, Module 0.1 Visual HTML Lecture** (`Stage_0_CS_Systems_Bedrock/lessons/module0_1_bits_integers_encoding.html`) — Binary/Hex, Two's Complement, Integer Overflow/Signedness CVEs, Endianness, UTF-8/Null-byte traps + interactive bit/overflow simulator + quiz.
  2. Build **Lab 0A** (`Stage_0_CS_Systems_Bedrock/labs/lab0a_bits_integer_overflow/`) — hands-on C byte/endianness inspector + vulnerable C allocator/balance integer-overflow Break & Fix lab (runs natively with `gcc`/`gdb`).

---

## 7. Decision Log
- **2026-11-17:** Initialized GitHub repo (`marajulcsecu/cybersecurity-5-year-journey`) and enabled GitHub Pages.
- **2026-11-19 (Major Fresh Reset to v3.0):** Critically audited and retired the old rushed "5-Year Job-Sprint / 8-Week Cram" roadmap. Adopted the **Timeless, Mastery-Gated First-Principles Curriculum (Stages 0 → 7)**: zero job urgency (student already working in Web/Mobile/Game dev), pure CS & Systems Security-Lens Bedrock first (Stage 0 → 3), zero distracting AI-wrapper projects early (AI Security moved to Stage 7 Pillar E), pre-built Linux SUID lesson/lab cleanly archived into `Stage_1_OS_Internals/` until Mastery Gate 0 is passed.
