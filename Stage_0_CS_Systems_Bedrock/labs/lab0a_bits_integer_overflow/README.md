# Lab 0A: Raw Byte Inspection + Integer Overflow & NUL-Byte Break & Fix

**Goal:** Experience how fixed-width bits, Two's Complement, Little-Endian byte order, and NUL-byte termination behave in real compiled C binaries—and learn to exploit and patch all 3 classic bug classes manually.

---

## 1. Build Lab 0A (Native Linux `gcc` + `gdb`)

```bash
cd Stage_0_CS_Systems_Bedrock/labs/lab0a_bits_integer_overflow
make
```

---

## 2. Part 1 — Observe Reality in RAM & `gdb`

Run the byte inspector:
```bash
./part1_byte_inspector
```

Now verify `magic = 0x12345678` and `neg5 = -5` directly in `gdb`:
```bash
gdb -q ./part1_byte_inspector
(gdb) break main
(gdb) run
(gdb) next 6
(gdb) x/4xb &magic
(gdb) x/4xb &neg5
(gdb) print/x neg5
(gdb) quit
```
Notice how `x/4xb &magic` prints `0x78 0x56 0x34 0x12` (Little-Endian!), while `htons(443)` reverses `0x01BB` into Big-Endian Network Byte Order (`0x01 0xBB`).

---

## 3. Part 2 — Break `part2_vuln_vault` Manually (3 Flags)

Read [`part2_vuln_vault.c`](./part2_vuln_vault.c) and capture all 3 flags using manual CLI inputs:

1. **Challenge 1 (`buy <count>`):** Each item costs `1000` credits, and your balance is only `500`. Find a positive `uint32_t` count that wraps `count * 1000` modulo $2^{32}$ to `<= 500`!
2. **Challenge 2 (`copy <len>`):** Maximum allowed length is `64`. Bypass the upper-bound check so the unsigned `size_t` sink receives a huge value!
3. **Challenge 3 (`open <hex_filename>`):** The validator insists the raw byte buffer ends with `.txt`, yet the C sink checks `strcmp(c_filename, "secret.key") == 0`. Craft the exact hex string!

---

## 4. Progressive Hints (Open Only If Stuck!)

<details>
<summary>Hint 1 — Challenge 1 (uint32 wrap-around math)</summary>

In 32-bit unsigned arithmetic, $2^{32} = 4294967296$.
Check $2 \times 2^{32} = 8589934592$:
Divide by `1000` and round up: `8589935 * 1000 = 8589935000`.
Modulo $2^{32}$: `8589935000 - 8589934592 = 408 <= 500`!
Try `./part2_vuln_vault buy 8589935`.
</details>

<details>
<summary>Hint 2 — Challenge 2 (Signed-to-Unsigned promotion)</summary>

Because `len` is a signed `int32_t`, any negative number like `-5` makes `len > 64` evaluate to `false`—then casting `(size_t)-5` turns it into `18446744073709551611`!
Try `./part2_vuln_vault copy -5`.
</details>

<details>
<summary>Hint 3 — Challenge 3 (Hex encoding with embedded 0x00)</summary>

Encode `secret.key` + `00` + `.txt` in hex (or run `python3 -c 'print(b"secret.key\x00.txt".hex())'`).
</details>

---

## 5. Part 3 — Fix & Verify (Break & Fix Rule)

Copy the vulnerable source to `part2_patched_vault.c` and fix all 3 root causes cleanly:
```bash
cp part2_vuln_vault.c part2_patched_vault.c
```
- **Fix 1 (`cmd_buy`):** Use `__builtin_mul_overflow(count, item_price, &total_cost)` (or check `count > UINT32_MAX / item_price`) BEFORE comparing against `balance`.
- **Fix 2 (`cmd_copy`):** Explicitly reject `len < 0` before casting to `size_t`.
- **Fix 3 (`cmd_open`):** Reject any input containing an embedded NUL byte (`memchr(raw, '\0', raw_len) != NULL`) before trusting the C string layer.

Run the automated verifier (compiles with `-Wall -Wextra -Werror -fsanitize=address,undefined` and checks all exploits + regressions):
```bash
./verify_lab0a.sh
```

When finished, save your 4–5 line Feynman explanation and command proofs in `Stage_0_CS_Systems_Bedrock/writeups/lab0a_writeup.md`.
