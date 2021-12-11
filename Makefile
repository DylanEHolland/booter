build:
	i686-elf-as src/boot.s -o objs/boot.o;
	
	i686-elf-gcc -c src/kstring.c -o objs/kstring.o -I./lib -std=gnu99 -ffreestanding -O2 -Wall -Wextra;
	i686-elf-gcc -c src/kernel.c -o objs/kernel.o -I./lib -std=gnu99 -ffreestanding -O2 -Wall -Wextra;

	i686-elf-gcc -T src/linker.ld -o objs/prekernel.bin -ffreestanding -O2 -nostdlib objs/*.o -lgcc;

run:
	`mdfind qemu-system-x86_64 | head -n 1` -kernel objs/prekernel.bin;

clean:
	rm objs/*.o;
	rm objs/*.bin;