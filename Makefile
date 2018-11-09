CC=gcc
CFlags=-m32 -std=gnu99 -ffreestanding -O2 -Wall -Wextra
LFlags=-m32 -Wl,--build-id=none -ffreestanding -O2 -nostdlib -lgcc

all:MyOS.iso

bin:
	mkdir bin

bin/MyOS.bin:kernel.c boot.s bin
	$(CC) $(CFlags) -c boot.s -o bin/boot.o
	$(CC) $(CFlags) -c kernel.c -o bin/kernel.o
	$(CC) $(LFlags) -T linker.ld bin/kernel.o bin/boot.o -o bin/MyOS.bin

bin/iso:bin/MyOS.bin grub.cfg
	mkdir -p bin/iso/boot/grub
	cp bin/MyOS.bin bin/iso/boot/MyOS.bin
	cp grub.cfg bin/iso/boot/grub/grub.cfg
	grub-mkrescue -o MyOS.iso bin/iso

MyOS.iso:bin/iso

run:
	qemu-system-x86_64 -cdrom MyOS.iso

clean:
	rm -r -f bin
	rm -f MyOS.iso

# Building using docker

docker-image:
	docker build -t eg-sample-kernel:latest .

docker-build:
	docker run -v $$PWD:/kernel --rm -it eg-sample-kernel:latest

in-docker-all:MyOS.iso
	chmod -R 777 bin
	chmod 777 MyOS.iso