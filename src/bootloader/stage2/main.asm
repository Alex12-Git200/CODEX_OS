bits 16

section _ENTRY class=CODE

extern _cstart_
global entry

entry:
    cli
    ; setup stack
    mov ax, ds
    mov ss, ax
    mov sp, 0
    mov bp, sp
    sti

    ; expect boot drive in dl, send it as argument to cstart function
    xor dh, dh
    push dx
    call _cstart_

    ; --- NEW CODE STARTS HERE ---
    ; After cstart_ finishes, we now load and jump to the kernel.

    ; IMPORTANT: You will need to implement a function
    ; or inline assembly here to load the kernel.
    ; This typically involves:
    ; 1. Calculating the sector(s) where kernel.bin resides on the floppy.
    ;    (This is often done during the build process and embedded or known).
    ; 2. Using BIOS INT 13h to read those sectors into a specific memory address.

    ; Example (Pseudocode for kernel loading):
    ; mov ax, KERNEL_LOAD_SEGMENT ; e.g., 0x1000 (for 0x10000 physical)
    ; mov es, ax
    ; mov bx, KERNEL_LOAD_OFFSET  ; e.g., 0x0000
    ; call ReadSectorsIntoESBX, KERNEL_START_SECTOR, KERNEL_SECTOR_COUNT, BOOT_DRIVE

    ; Once the kernel is loaded, jump to its entry point.
    ; The kernel often expects to be loaded at a specific physical address
    ; and its own entry point will be relative to that load address.
    ; For a simple 16-bit kernel, you might jump directly.
    ; For a 32-bit kernel, you'd switch to protected mode first.

    ; Example (Assuming a simple 16-bit jump to kernel loaded at 0x1000:0x0000):
    ; mov ax, 0x1000
    ; mov ds, ax
    ; mov es, ax
    ; mov fs, ax
    ; mov gs, ax
    ; mov ss, ax
    ; mov sp, KERNEL_STACK_TOP ; Set up a new stack for the kernel

    jmp 0x1000:0x0000           ; Jump to the kernel's entry point (adjust as needed)

    ; --- END NEW CODE ---

    ; If for some reason the kernel fails to load or jump, then halt.
    ; This HLT should ideally never be reached in a successful boot.
    cli
    hlt