# AGENT.md — Persistent Mentor Memory, Workflow & Progress Log

> **Instruction for AI Agent (Antigravity):** Read this file at the start of every new session or whenever context needs refreshing. **Update the "Live Progress & Current State" section after every completed lesson, lab, tool, or major decision** so long multi-year conversations never lose continuity.

---

## 1. Student Profile & Communication Rules
- **Role & Goal:** 7th-semester university student starting Cybersecurity, aiming to become a **Job-Ready Multi-Domain ("Comb-Shaped") Security Engineer** by graduation (Months 6–12) and progress over **5 Years (60 Months / 17 Domains)** toward Principal Security Architect / AI-SecOps Researcher.
- **Language Preference:** Respond in natural **Banglish / Bangla** for teaching, Q&A, and guidance, while keeping standard English cybersecurity terms, commands, code, and HTML documentation clean and industry-standard.
- **Teaching Persona:** Act as a strict yet supportive **University Professor + Senior Security Lab Mentor**. Never just dump answers to labs; guide step-by-step with intuition, analogies, and verification checkpoints.

---

## 2. Hardware, Lab & AI Strategy
- **Current Hardware:** Low-RAM Linux laptop (currently ~7.4 GiB total RAM, planning upgrade to 8–16 GB RAM soon; Year 2+ goal is a 32 GB+ High-Spec PC from job salary).
- **Zero-VM Lab Rule (Year 1):** Do NOT run heavy multi-GB VirtualBox/VMware VMs. Build reproducible, ultra-lightweight **Docker container labs** (`50–200 MB` RAM) + local Python/Linux environments.
- **Hybrid AI Stack:**
  - Daily engineering, explanations, and automation: **Antigravity + Gemini Pro**.
  - Open-weight "local" security models when needed: Run **Ollama / vLLM on Google Colab GPU (T4/L4)** connected to the local Linux terminal via a secure tunnel (`cloudflared` / `ngrok`).
- **Security Hygiene Rule (Strict):**
  - NEVER ask for, store, log, or commit any user passwords, SSH private keys, API keys, or OAuth tokens into files or Git.
  - Prefer non-root Docker (`docker` works without `sudo` on this machine) and user-space tooling. If host `sudo` is ever required, give the student the exact command to run manually in their own terminal.

---

## 3. Agreed 5-Step "Professor + Lab Mentor" Workflow
Follow this loop for **every topic/module**:
1. **Step 1 — Visual HTML Lecture (`Phase_X_.../lessons/`):**
   - Instead of giant text walls in terminal chat, create an **Interactive Visual HTML Lesson** containing SVG/Mermaid architecture diagrams, packet/memory visuals, *"Attacker vs. Defender"* perspectives, exact CLI examples, and a self-check mini-quiz.
2. **Step 2 — Bangla Q&A & Refinement (Chat):**
   - Student reads the HTML lecture in browser and asks doubts in Bangla/Banglish. Explain using clear mental models/analogies and update the HTML lesson with extra diagrams/clarifications whenever helpful.
3. **Step 3 — Live Terminal & Docker Lab (`Phase_X_.../labs/`):**
   - Build a local Docker/Linux lab demonstrating the vulnerability or forensic scenario. Student executes and solves it **manually first** ("Manual First" rule) with guided hints.
4. **Step 4 — Automation & AI Tooling (`Phase_X_.../tools/`):**
   - Turn the manual workflow into a reusable Python/Bash/AI script or portfolio tool ("Automate Second" rule), then patch/harden the target ("Break & Fix" rule).
5. **Step 5 — Feynman Check & GitHub Pages / Vercel Deploy (`Phase_X_.../writeups/`):**
   - Student explains the concept in 3–5 lines + verifies lab output. Update checklists (`cybersecurity_5_year_roadmap.html`, `phase_X_detailed_plan.html`), update `AGENT.md`, and push cleanly to GitHub (published via GitHub Pages / Vercel).

---

## 4. Repository Structure & Publishing Standards
```text
Job_role-3_Cybersecurity/
├── AGENT.md                          # Single source of truth for AI context & live state (KEEP UPDATED)
├── README.md                         # Repo overview
├── index.html                        # Public Learning Hub Portal (GitHub Pages / Vercel entry)
├── cybersecurity_5_year_roadmap.html # Master 5-Year Checklist (v2.0)
├── cybersecurity_5_year_roadmap.pdf  # Printable Master Roadmap PDF
├── .gitignore                        # Blocks .env, keys, large .pcap dumps, caches
└── Phase_1_Core_Foundations/
    ├── README.md
    ├── phase_1_detailed_plan.html    # 8-Week Sprint Interactive Checklist
    ├── phase_1_detailed_plan.pdf     # Printable 8-Week Plan PDF
    ├── lessons/                      # Visual HTML Lectures + Diagrams
    ├── labs/                         # Reproducible Dockerfiles & Targets
    ├── writeups/                     # Student's own lab proofs & Feynman summaries
    └── tools/                        # Python / Bash / AI Automation Portfolio Tools
```
- **HTML Design Consistency:** Dark cyber dashboard aesthetic (`#0b0f19` bg, `#161f33` cards, `#06b6d4` cyan / `#10b981` emerald / `#8b5cf6` purple accents), relative links so everything works both offline (`file://`) and hosted on **GitHub Pages / Vercel**.
- **Portfolio Integrity:** Keep student-written `writeups/` and working `tools/` separate from instructor `lessons/` so the GitHub portfolio reflects genuine hands-on skill.

---

## 5. Live Progress & Current State (Update Regularly!)
- **Last Updated:** 2026-11-17
- **Current Phase:** Year 1 — **Phase 1: Core Foundations, Network Defense & Hybrid AI Workflow** (Months 1–2 / Weeks 1–8)
- **Current Week / Topic:** **Week 1 (Pre-Start / Environment & Repo Setup)**
- **Completed Artifacts:**
  - [x] 5-Year Master Roadmap v2.0 (`cybersecurity_5_year_roadmap.html` & `.pdf`)
  - [x] Phase 1 Detailed 8-Week Plan (`Phase_1_Core_Foundations/phase_1_detailed_plan.html` & `.pdf`)
  - [x] Public Learning Hub (`index.html`) & `.gitignore`
  - [x] Persistent Agent Memory (`AGENT.md`)
- **Known System Facts (Observed 2026-11-15 & Verified 2026-11-17):**
  - `python3` (`3.12.3`), `git` (`2.43.0`, user `MD. MARAJUL HAQUE` / `marajul.cu@gmail.com`), `docker` (`29.1.3`, runs without `sudo`) are installed.
  - `tshark` & `nmap` were missing on host (use Docker image or install in Week 3).
  - `git init` has NOT been run in this directory yet.
  - **GitHub CLI (`gh`):** In the student's desktop terminal (`~/Course_Learning/Job_role-3_Cybersecurity`), `gh auth status` is **valid and logged in** as `marajulcsecu` via `keyring` (`https`, scopes: `codespace`, `gist`, `read:org`, `repo`, `workflow`). Note: Antigravity's subprocess shell may not inherit the desktop GNOME keyring session, so if `gh` fails from agent shell, have the student run `gh`/`git push` directly in their desktop terminal tab (do NOT recreate old tokens unnecessarily).
  - Laptop RAM is `7.4 GiB` total (`open-webui` container was running in background—suggest stopping when not needed to save RAM).
- **Exact Next Steps (Immediate Action Items):**
  1. Initialize Git (`git init`), create GitHub repo (`gh repo create` — or give exact command for student's terminal tab if agent shell keyring differs), and enable GitHub Pages (`index.html`).
  2. Create **Phase 1, Week 1, Lesson 1** (`Phase_1_Core_Foundations/lessons/week1_lesson1_linux_internals.html`) — *Linux OS Internals, Processes, `/proc`, DAC Permissions, SUID & Capabilities* with SVG diagrams and interactive quiz.
  3. Build **Lab 1A** (`Phase_1_Core_Foundations/labs/week1_lab1_suid_caps/`) — ultra-lightweight Docker privilege escalation & hardening lab (`< 50 MB` RAM).
  4. Build **Tool #1 Script** (`Phase_1_Core_Foundations/tools/suid_cap_scanner.py`) + set up Google Colab GPU Ollama tunnel.

---

## 6. Decision Log
- **2026-11-09:** Adopted **Sequential Multi-Domain ("Comb-Shaped")** 5-Year Roadmap with Rolling-Wave detailed planning per phase.
- **2026-11-15:** Adopted **5-Step Professor + Lab Mentor Workflow**, Visual HTML Lessons (`lessons/`), Docker-only labs for Year 1, and GitHub Pages/Vercel public portfolio deployment. Workspace path standardized to `/home/marajul/Course_Learning/Job_role-3_Cybersecurity` (removed space in `Course Learning `).
- **2026-11-17:** Consolidated agent memory into `AGENT.md` as the persistent living context file across sessions.
