#include <kstring.h>
 
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif
 
/* This tutorial will only work for the 32-bit ix86 targets. */
#if !defined(__i386__)
#error "Only 32bit is supported at this time"
#endif
 
void kernel_main(void) 
{
	output_initialize();
	terminal_writestring("Entered C from assembly...");

	char * str = kstring_implode("t", "a");
	terminal_writestring(str);

}