//This code based on https://www.codeproject.com/Articles/1225196/Create-Your-Own-Kernel-In-C
//License: Code Project Open License (CPOL)

#ifndef _KERNEL_H_
#define _KERNEL_H_

#define VGA_ADDRESS 0xB8000

#define WHITE_COLOR 15

typedef unsigned short UINT16;

UINT16* TERMINAL_BUFFER;

#endif
