#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Lab 0A — Part 2: Vulnerable Vault (3 Intentional Integer & Encoding Flaws)
 *
 * Study each function carefully, spot the broken invariant, exploit all 3
 * manually from the CLI, then copy this file to `part2_patched_vault.c`,
 * fix all 3 root causes, and verify with `./verify_lab0a.sh`.
 */

static int cmd_buy(const char *arg) {
    const uint32_t balance = 500u;
    const uint32_t item_price = 1000u;

    char *end = NULL;
    unsigned long parsed = strtoul(arg, &end, 10);
    if (end == arg || *end != '\0' || parsed == 0 || parsed > UINT32_MAX) {
        printf("[DENIED] Provide a valid positive uint32 item count.\n");
        return 1;
    }

    uint32_t count = (uint32_t)parsed;

    /* BUG 1: Unchecked 32-bit unsigned multiplication wraps modulo 2^32! */
    uint32_t total_cost = count * item_price;

    if (total_cost > balance) {
        printf("[DENIED] Buying %u item(s) costs %u credits, but balance is only %u.\n",
               count, total_cost, balance);
        return 1;
    }

    printf("[PURCHASE OK] Bought %u item(s) for computed cost %u credits (balance=%u)!\n",
           count, total_cost, balance);
    printf("FLAG{lab0a_1_uint32_wraparound_bypass}\n");
    return 0;
}

static int cmd_copy(const char *arg) {
    char *end = NULL;
    long parsed = strtol(arg, &end, 10);
    if (end == arg || *end != '\0' || parsed < INT32_MIN || parsed > INT32_MAX) {
        printf("[DENIED] Provide a valid 32-bit signed integer length.\n");
        return 1;
    }

    int32_t len = (int32_t)parsed;

    /* BUG 2: Only checks upper bound; forgets negative signed values! */
    if (len > 64) {
        printf("[DENIED] Length %d exceeds maximum allowed 64 bytes.\n", len);
        return 1;
    }

    /* Simulates passing signed `len` into an unsigned `size_t` sink like memcpy() */
    size_t unsigned_len = (size_t)len;
    printf("[COPY] Passed signed len=%d -> unsigned size_t=%zu bytes.\n", len, unsigned_len);

    if (unsigned_len > 64) {
        printf("[EXPLOITED] Negative length bypassed upper check and promoted to massive unsigned size!\n");
        printf("FLAG{lab0a_2_signed_to_unsigned_promotion}\n");
        return 0;
    }

    printf("[OK] Safely copied %zu bytes.\n", unsigned_len);
    return 0;
}

static int hex_to_bytes(const char *hex, uint8_t *out, size_t max_out, size_t *out_len) {
    size_t hlen = strlen(hex);
    if (hlen == 0 || (hlen % 2) != 0 || (hlen / 2) >= max_out) {
        return -1;
    }
    for (size_t i = 0; i < hlen / 2; i++) {
        char pair[3] = {hex[2 * i], hex[2 * i + 1], '\0'};
        if (!isxdigit((unsigned char)pair[0]) || !isxdigit((unsigned char)pair[1])) {
            return -1;
        }
        out[i] = (uint8_t)strtoul(pair, NULL, 16);
    }
    out[hlen / 2] = '\0';
    *out_len = hlen / 2;
    return 0;
}

static int cmd_open(const char *hex_arg) {
    uint8_t raw[128];
    size_t raw_len = 0;

    if (hex_to_bytes(hex_arg, raw, sizeof(raw), &raw_len) != 0) {
        printf("[DENIED] Provide a valid even-length hex string (e.g., 68656c6c6f2e747874 for hello.txt).\n");
        return 1;
    }

    /* Layer 1 (Length-aware validator): checks last 4 bytes of raw buffer == ".txt" */
    if (raw_len < 4 || memcmp(raw + raw_len - 4, ".txt", 4) != 0) {
        printf("[DENIED] Validator rejected file: must end with '.txt'.\n");
        return 1;
    }

    /* BUG 3: Layer 2 (C string sink) stops at the first 0x00 NUL byte! */
    const char *c_filename = (const char *)raw;
    if (strcmp(c_filename, "secret.key") == 0) {
        printf("[EXPLOITED] Validator approved %zu-byte buffer ending in '.txt', but C sink opened '%s'!\n",
               raw_len, c_filename);
        printf("FLAG{lab0a_3_null_byte_parser_differential}\n");
        return 0;
    }

    printf("[OK] Opened benign text file: '%s' (%zu raw bytes)\n", c_filename, raw_len);
    return 0;
}

static void usage(const char *prog) {
    printf("Stage 0 / Lab 0A — Part 2: Vulnerable Vault\n");
    printf("Usage:\n");
    printf("  %s buy  <uint32_count>     (item_price=1000, balance=500)\n", prog);
    printf("  %s copy <int32_len>        (max allowed length=64)\n", prog);
    printf("  %s open <hex_filename>     (must end in '.txt'; target C sink='secret.key')\n", prog);
}

int main(int argc, char **argv) {
    if (argc != 3) {
        usage(argv[0]);
        return 1;
    }
    if (strcmp(argv[1], "buy") == 0) return cmd_buy(argv[2]);
    if (strcmp(argv[1], "copy") == 0) return cmd_copy(argv[2]);
    if (strcmp(argv[1], "open") == 0) return cmd_open(argv[2]);

    usage(argv[0]);
    return 1;
}
