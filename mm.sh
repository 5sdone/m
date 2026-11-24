#!/bin/sh
# 999ISSUE Recovery Launcher - Phase 1 (read-only inspection)
# No payment requests, no software installation, no system modification.
set -eu
umask 077

printf '\n========================================\n'
printf '       999ISSUE - RECOVERY TEST\n'
printf '========================================\n\n'

platform=$(uname -s 2>/dev/null || printf 'unknown')
if [ "$platform" != "Darwin" ]; then
    printf 'Unsupported operating system: %s\n' "$platform"
    printf 'This test must be run in macOS Recovery.\n'
    exit 1
fi

printf 'Operating system: macOS (Darwin)\n'
printf 'Recovery verification: not yet implemented\n'

serial=''
if command -v ioreg >/dev/null 2>&1; then
    serial=$(ioreg -rd1 -c IOPlatformExpertDevice 2>/dev/null | awk -F '"' '/IOPlatformSerialNumber/ { print $4; exit }' || true)
    if [ -z "$serial" ]; then
        serial=$(ioreg -l 2>/dev/null | awk -F '"' '/IOPlatformSerialNumber/ { print $4; exit }' || true)
    fi
fi

if [ -z "$serial" ]; then
    printf 'Serial: NOT AVAILABLE (check Recovery environment / ioreg)\n'
else
    printf 'Serial: %s\n' "$serial"
fi

printf '\nPayment integration: NOT CONNECTED\n'
printf 'Payment QR: NOT AVAILABLE IN THIS TEST\n'
printf 'Installer: NOT CALLED\n'
printf '\nPHASE 1 COMPLETE - NO CHANGES MADE\n'
