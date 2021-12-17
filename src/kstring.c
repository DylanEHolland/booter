#include <kstring.h>
#include <logger.h>

size_t strlen(const char* str) 
{
	size_t len = 0;
	while (str[len])
		len++;
	return len;
}
 


/**
 * C++ version 0.4 char* style "itoa":
 * Written by Lukás Chmela
 * Released under GPLv3.
 */
char* itoa(int value, char* result, int base) {
    // check that the base if valid
    if (base < 2 || base > 36) { *result = '\0'; return result; }

    char* ptr = result, *ptr1 = result, tmp_char;
    int tmp_value;

    do {
        tmp_value = value;
        value /= base;
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
    } while ( value );

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
    *ptr-- = '\0';
    while(ptr1 < ptr) {
        tmp_char = *ptr;
        *ptr--= *ptr1;
        *ptr1++ = tmp_char;
    }

    return result;
}

char * kstring_implode(char * str1, char * str2) {
	int total = strlen(str1) + strlen(str2) + 1;
	char buffer[total];
	char * output;

	int n = 0;
	for(int i = 0; i < strlen(str1); i++) {
		char character = str1[i];
		buffer[n] = character;
		n++;
	}

	for(int i = 0; i < strlen(str2); i++) {
		char character = str2[i];
		buffer[n] = character;
		n++;
	}
	
	buffer[n] = '\0';
	output = &buffer;
	terminal_writestring(output);
	return buffer;
}

