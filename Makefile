build:
	i686-elf-as src/boot.s -o objs/boot.o;
	@-for f in $(wildcard src/*.c); do \
		OBJ_NAME=objs/`echo $$f | cut -d . -f 1 | cut -d / -f 2`.o && \
		i686-elf-gcc -c $$f -o $$OBJ_NAME -I./lib -std=gnu99 -ffreestanding -O2 -Wall -Wextra; \
	done;
	@-i686-elf-gcc -T src/linker.ld -o objs/prekernel.bin -ffreestanding -O2 -nostdlib objs/*.o -lgcc;

run:
	`mdfind qemu-system-x86_64 | head -n 1` -kernel objs/prekernel.bin;

clean:
	rm objs/*.o;
	rm objs/*.bin;