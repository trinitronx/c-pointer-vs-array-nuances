# C Pointer vs Array Nuances

This repository contains a small C program that demonstrates the nuances between
pointers and arrays in C.  It was inspired in response to
[an experiment proposed in a comment][1] on Huw Collingbourne's YouTube Video:
["The ONE Thing Most C Programmers Get Wrong!"][2]

## Contents

- `ptr-vs-array.c`: The main C source file containing the example code.
- `.vscode/`: Directory containing VS Code configuration files for building and
  debugging.  Useful only if you use VSCode (optional).

## Program Description

The `ptr-vs-array.c` file contains a simple C program that illustrates the
differences between character arrays, character pointers, and as proposed by the
YouTube comment, a fixed-length uninitialized integer array. It demonstrates
memory addresses, string initialization, and setting an array's value at runtime with `scanf()`.

Key points demonstrated in the code:

### Arrays are slightly different than pointers

- Fixed-length Arrays have a length known at compile-time.
  - As such, they can be "_statically_" included into the resulting binary.
  - Therefore, the value of an array is constant ("_immutable_"), and cannot be
    changed later.
  - The space allocated for a fixed-length array (with "_initializer_"
    statement), `arr1[] = ...initializer...` is known by the compiler by
    inspecting the declaration.
  - The address of the initial array space in memory is what the expression
    `&arr1`, and `arr1` evaluate to.
  - When no initializer is given, the initial value of the array is undefined
    (as in "_undefined behavior_", and could be garbage values leftover in RAM).
    - Regardless, the expressions `&arr1` and `arr1` still evaluate to an
      address allocated for the contents of the known fixed-length array size.
- Pointers are variables allocated on the stack, which store an address of
    something else.
  - The space allocated for the pointer itself is enough to store just an
    address of something. (Typically, this is on the stack)
  - The address stored inside a pointer variable is it's value, which can be
    modified ("_mutated_") later.
  - For an example `char *` pointer, `str2`, the expressions `&str2` and `str2`
    evaluate to different addresses.
    - The expression `&str2` evaluates to the address of the pointer variable
      itself.
    - The expression `str2` evaluates to the address of the first character in
      the string.

## Building the Program

The project includes a VS Code task for building the program. You can build it
by:

- Opening the project in VS Code.
- Use one of the following:
  - VSCode Tasks: (pick one)
    - Pressing <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd> (or
      <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd> on macOS) to run the build
      task.
    - Open the Command Palette (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> or
      <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on macOS).
  - GNU `make`:
    - To build all (including assembly + object files for inspection):

          make
      - This will build:
        - `ptr-vs-array`: A normal optimized (`-O2`) binary executable with debugging information.
        - `ptr-vs-array-asm-test`: An unoptimized  (`-O0`) binary executable without debugging information (easier to inspect & disassemble).
        - `ptr-vs-array.o`: The object file used when linking the normal binary executable.
        - `ptr-vs-array.s`: An assembler listing, created during compilation of `ptr-vs-array-asm-test`.  Look at this to see what assembly code your `$(CC)` compiler is generating.
          - The assembler (`as -a[sub-option...]`) sub-options used are:
            - `d`: omit debugging directives
            - `h`: include high-level source
            - `l`: include assembly
            - `n`: omit forms processing
    - To build just the normal binary executable:

          make ptr-vs-array

    - To inspect the test binary with `objdump` & `hexdump`:

          make inspect

Alternatively, you can build it manually using GCC:

```bash
gcc -std=c11 -g -o ptr-vs-array ptr-vs-array.c
```

## Debugging

The project is set up for debugging with both GDB and LLDB. You can start
debugging by:

1. Setting breakpoints in the code.
2. Pressing F5 or selecting "Run and Debug" from the VS Code sidebar.
3. Choosing either "`Debug ptr-vs-array with gdb`" or
  "`Debug ptr-vs-array with LLDB`" from the debug configuration dropdown.

## Cleaning the Project

To clean the build artifacts, you can use the provided VS Code task:

1. Open the Command Palette (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> or
   <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> on macOS).
2. Type "Tasks: Run Task" and select it.
3. Choose "ptr-vs-array: Clean" from the task list.

This will remove the compiled binary and any generated compilation database JSON.

## Requirements

- GCC compiler
- GDB or LLDB debugger
- GNU Make
  - optional, for using the provided `Makefile` rules.
- VS Code
  - optional, for using the provided tasks and launch configurations
  - If using this, ensure you install the Python `intercept-build` tool from the
    [`scan-build` project][3], usually shipped with `clang`
    - Arch Linux

          sudo pacman -Sy clang

    - Debian/Ubuntu Linux (install desired version matching Clang/LLVM)

           sudo apt-get install clang-tools-16 # Debian bookworm
           # Or latest on Ubuntu 24.04 LTS "Noble Numbat"
           sudo apt-get install clang-tools-18

    - Python Pip

          pip install scan-build

## License

GPL-3.0 license (See [`LICENSE`](./LICENSE) file)

[1]: https://www.youtube.com/watch?v=H18yIPSsgLg&lc=UgxFTJf8jcpo7mHG65B4AaABAg
[2]: https://youtu.be/H18yIPSsgLg?si=wRy2cPnoyDBJSEJn
[3]: https://github.com/rizsotto/scan-build?tab=readme-ov-file#scan-build
