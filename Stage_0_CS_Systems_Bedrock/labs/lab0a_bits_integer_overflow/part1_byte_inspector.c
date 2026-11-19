#include <arpa/inet.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static void print_bits(uint8_t b) {
    for (int i = 7; i >= 0; i--) {
        putchar((b & (1u << i)) ? '1' : '0');
        if (i == 4) putchar(' ');
    }
}

static void dump_bytes(const char *label, const void *ptr, size_t n) {
    const uint8_t *bytes = (const uint8_t *)ptr;
    printf("\n=== %s (size=%zu bytes, start=%p) ===\n", label, n, ptr);
    for (size_t i = 0; i < n; i++) {
        printf("  addr=%p  byte[%zu] = 0x%02X  (", (const void *)(bytes + i), i, bytes[i]);
        print_bits(bytes[i]);
        printf(")\n");
    }
}

int main(void) {
    uint32_t magic = 0x12345678u;
    int8_t signed_neg1 = -1;
    uint8_t unsigned_255 = 255u;
    int32_t neg5 = -5;
    uint16_t https_host = 443u;
    uint16_t https_net = htons(https_host);
    char embedded_nul[] = {'A', '\0', 'B', '\0'};

    printf("Stage 0 / Lab 0A — Part 1: Raw Memory Byte Inspector\n");
    printf("Observe Little-Endian order, Two's Complement, and NUL termination in real RAM.\n");

    dump_bytes("uint32_t magic = 0x12345678 (Host Little-Endian)", &magic, sizeof(magic));
    dump_bytes("int8_t signed_neg1 = -1", &signed_neg1, sizeof(signed_neg1));
    dump_bytes("uint8_t unsigned_255 = 255", &unsigned_255, sizeof(unsigned_255));
    dump_bytes("int32_t neg5 = -5 (Two's Complement + Little-Endian)", &neg5, sizeof(neg5));
    dump_bytes("uint16_t https_host = 443 (0x01BB in Host Order)", &https_host, sizeof(https_host));
    dump_bytes("uint16_t https_net  = htons(443) (Network Big-Endian)", &https_net, sizeof(https_net));
    dump_bytes("char embedded_nul[] = {'A', '\\0', 'B', '\\0'}", embedded_nul, sizeof(embedded_nul));

    printf("\nNotice: sizeof(embedded_nul) = %zu bytes, but strlen(embedded_nul) = %zu!\n",
           sizeof(embedded_nul), strlen(embedded_nul));
    return 0;
}
