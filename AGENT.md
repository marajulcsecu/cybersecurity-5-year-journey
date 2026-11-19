# AGENT.md — Persistent Mentor Memory, Workflow & Progress Log

> **Instruction for AI Agent (Antigravity):** Read this file at the start of every new session or whenever context needs refreshing. **Update the "Live Progress & Current State" section after every completed module, lab, mastery gate, or major decision** so long multi-year learning never loses continuity.

---

## 1. Student Profile & Communication Rules
- **Background & Career Context:** 7th-semester CSE university student who has **already started working in software development (Web, Mobile App, Game Dev)**.
- **Core Goal (NO Job-Hunt Rush!):** True **Beginner → Master** depth in Cybersecurity from absolute CS & Systems first principles. Timeline is completely open (5, 15, or 30 years—zero calendar pressure). Strictly anti-script-kiddie and anti-buzzword-cramming.
- **CS Baseline:** Has studied core CSE subjects (C/C++, COA, OS, Networking, Discrete Math, DB/Web) for university semesters, and now explicitly wants to **rebuild/re-study all of them through a deep Security Lens (Attacker + Defender engineering viewpoint)**.
- **Language Preference:**
  - In chat: Respond in natural **Banglish / Bangla** for teaching, Q&A, and guidance.
  - **Dual-Language Visual HTML Lectures (Strict Rule):** For every module's Step 1 Visual HTML Lecture, always create **BOTH** a deeply detailed, step-by-step **English Edition (`*.html`)** AND a full, natural **Pure বাংলা (Bengali script, NOT Banglish) Edition (`*_bn.html`)** linked via a 1-click topbar toggle (`বাংলা সংস্করণ →` / `English Version →`), while keeping standard English C/security terms (`uint32_t`, `Two's Complement`, `Little-Endian`, `malloc()`, `gdb`) inside `<code>` tags.
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
├── master_roadmap.html               # Timeless First-Principles Master Roadmap (v3.1, Stages 0–7)
├── .nojekyll                         # Clean static GitHub Pages serving
├── .gitignore                        # Blocks .env, keys, large pcaps, binaries, caches
└── Stage_0_CS_Systems_Bedrock/       # ★ ACTIVE STAGE (Modules 0.1–0.5 + Mastery Gate 0)
    ├── README.md
    ├── stage_0_detailed_plan.html
    ├── lessons/module0_1_bits_integers_encoding.html
    ├── labs/lab0a_bits_integer_overflow/
    ├── writeups/
    └── tools/
```
- **HTML Design Consistency (v3.1 Editorial Precision Standard):**
  - Clean Obsidian Carbon dark mode (`#09090b` bg, `#111114` elevated, `#141418` cards, `#26262e` hairline borders, `#10b981` crisp emerald primary CTA, `#38bdf8` sky links) + persisted **Light / Dark theme toggle** (`marajul_cyber_theme` in `localStorage`).
  - **NEVER make large hero headers `position: sticky`!** Use only a **52px single-row slim sticky topbar** (breadcrumbs + compact inline progress + theme toggle) so ≥92% of the viewport stays open for reading.
  - Always sanitize dynamic JS strings with `escapeHtml()` before inserting into `innerHTML` (so `/proc/<PID>/maps`, `<pid>`, etc. render literally).
  - 100% offline-safe (inline SVG, zero CDN requirements), relative links, Print-to-PDF ready.

---

## 6. Live Progress & Current State (Update Regularly!)
- **Last Updated:** 2026-11-19
- **Current Tier / Stage:** **Tier I — Stage 0: Computing & Systems Bedrock (Security Lens)**
- **Current Module:** **Module 0.1 & Lab 0A Active (Steps 1–4 of 5-Step Loop)** — *Data Representation, Two's Complement, Integer Overflows, Endianness & Encoding Pitfalls*
- **GitHub Repository & Live Pages:**
  - **Repo:** <https://github.com/marajulcsecu/cybersecurity-5-year-journey> (`main` branch, public)
  - **GitHub Pages Hub:** <https://marajulcsecu.github.io/cybersecurity-5-year-journey/>
- **Completed Artifacts:**
  - [x] Timeless First-Principles Master Roadmap v3.1 (`master_roadmap.html`, Obsidian/Light UI, Workflow Playbook)
  - [x] Stage 0 Detailed Mastery Syllabus (`Stage_0_CS_Systems_Bedrock/stage_0_detailed_plan.html` & `README.md`)
  - [x] Refreshed Public Learning Hub (`index.html`), `README.md`, and `AGENT.md` (cleanly removed premature `Stage_1_OS_Internals/` to enforce strict 1-stage-at-a-time discipline)
  - [x] **Stage 0, Module 0.1 Dual-Language Visual HTML Lectures (Deep-Dive Expanded)**:
    - English Edition: `Stage_0_CS_Systems_Bedrock/lessons/module0_1_bits_integers_encoding.html`
    - Pure বাংলা Edition: `Stage_0_CS_Systems_Bedrock/lessons/module0_1_bits_integers_encoding_bn.html`
  - [x] **Stage 0, Lab 0A** (`Stage_0_CS_Systems_Bedrock/labs/lab0a_bits_integer_overflow/`) — Native C + `gdb` lab (`part1_byte_inspector.c`, `part2_vuln_vault.c` with 3 real flaws, `Makefile`, `verify_lab0a.sh` tested 9/9 pass under `-Wall -Wextra -Werror -fsanitize=address,undefined`, collapsible hints `README.md`)
- **Known System Facts (Verified 2026-11-19):**
  - `python3` (`3.12.3`), `git` (`2.43.0`, user `MD. MARAJUL HAQUE` / `marajul.cu@gmail.com`), `docker` (`29.1.3`, runs without `sudo`, `overlay2` driver), `gh` (`2.100.0`, logged in as `marajulcsecu`).
  - Stage 0 native C/systems toolchain already installed on host: `gcc`, `g++`, `gdb`, `readelf`, `objdump`, `nm`, `strings`, `strace` (`ltrace` optional).
- **Exact Next Steps (Immediate Action Items):**
  1. **Steps 1–4 (Student Action):** Study Module 0.1 HTML lecture + pass the 6-question quiz, ask any Bangla/Banglish Q&A, run `make` in `lab0a_bits_integer_overflow/`, inspect memory in `gdb`, capture all 3 flags manually, patch `part2_patched_vault.c`, and pass `./verify_lab0a.sh`.
  2. **Step 5 (Feynman & Publish):** Student explains Module 0.1 concepts in 4–5 lines + saves proof in `Stage_0_CS_Systems_Bedrock/writeups/lab0a_writeup.md`.
  3. **Next Module:** Launch **Module 0.2** (*C Programming & Memory Internals: Pointers, Structs/Padding, Stack vs Heap, OOB, UAF & ASan*) + **Lab 0B**.

---

## 7. Decision Log
- **2026-11-17:** Initialized GitHub repo (`marajulcsecu/cybersecurity-5-year-journey`) and enabled GitHub Pages.
- **2026-11-19 (Major Fresh Reset to v3.0):** Critically audited and retired the old rushed "5-Year Job-Sprint / 8-Week Cram" roadmap. Adopted the **Timeless, Mastery-Gated First-Principles Curriculum (Stages 0 → 7)**: zero job urgency (student already working in Web/Mobile/Game dev), pure CS & Systems Security-Lens Bedrock first (Stage 0 → 3), zero distracting AI-wrapper projects early (AI Security moved to Stage 7 Pillar E), pre-built Linux SUID lesson/lab cleanly archived into `Stage_1_OS_Internals/` until Mastery Gate 0 is passed.
- **2026-11-19 (v3.1 UI/UX Overhaul & Audit Fixes):** Replaced giant sticky headers with a 52px slim sticky topbar across all HTML pages, upgraded from generic dark navy to Editorial Obsidian Carbon + Light/Dark theme toggle, added prominent **Workflow & Return-After-A-Break Playbook** to `index.html` and `master_roadmap.html`, fixed unescaped `<pid>`/`<PID>` HTML injection bugs (`/proc/<pid>/ns`, `/proc/<PID>/maps`) via `escapeHtml()`, added Export/Import/Reset parity to Stage 0, and added OS Concurrency/TOCTOU to Stage 1.
