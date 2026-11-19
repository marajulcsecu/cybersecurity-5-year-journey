CC = gcc
CFLAGS = -g -O0 -Wall -Wextra

.PHONY: all clean

all: part1_byte_inspector part2_vuln_vault

part1_byte_inspector: part1_byte_inspector.c
	$(CC) $(CFLAGS) -o $@ $<

part2_vuln_vault: part2_vuln_vault.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f part1_byte_inspector part2_vuln_vault part2_patched_vault *.o
