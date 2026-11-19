# Stage 0: Computing & Systems Bedrock (Security Lens)

- **Interactive Mastery Syllabus:** [`stage_0_detailed_plan.html`](./stage_0_detailed_plan.html)
- **Master Roadmap:** [`../master_roadmap.html`](../master_roadmap.html)

## Modules (Self-Paced, Mastery-Gated)
1. **Module 0.1 ★ (Active):** Data Representation, Two's Complement, Integer Overflows & Encoding Pitfalls
   - Visual HTML Lecture: [`lessons/module0_1_bits_integers_encoding.html`](./lessons/module0_1_bits_integers_encoding.html)
   - Native C + `gdb` Lab 0A: [`labs/lab0a_bits_integer_overflow/README.md`](./labs/lab0a_bits_integer_overflow/README.md)
2. **Module 0.2:** C Programming & Memory Internals (Pointers, Stack, Heap & Undefined Behavior)
3. **Module 0.3:** Build Toolchain, Compilers, Linkers & ELF Binary Anatomy (`readelf`, `objdump`, `ldd`, `nm`)
4. **Module 0.4:** CPU Architecture, x86_64 Assembly Reading & `gdb` Debugging Craft
5. **Module 0.5:** Virtual Memory, Hardware Protection Rings (`Ring 3` vs `Ring 0`) & System Calls (`strace`/`ltrace`)
6. **Mastery Gate 0:** Diagnose & patch 3 real C memory/integer bugs in `gdb` + whiteboard process memory & stack-frame trace.

## Directory Layout
- `lessons/` — Interactive Visual HTML Lectures
- `labs/` — Reproducible C / Docker / `gdb` Labs
- `writeups/` — Student's own lab proofs & Feynman summaries
- `tools/` — Pure C / Python / Bash systems inspection tools
