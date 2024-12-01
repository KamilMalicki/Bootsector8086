BOOT_FILE = boot.bin
SOURCE_FILE = boot.asm

all: build

build: $(BOOT_FILE)

$(BOOT_FILE): $(SOURCE_FILE)
	nasm -f bin $(SOURCE_FILE) -o $(BOOT_FILE)

run: $(BOOT_FILE)
	qemu-system-i386 -drive file=$(BOOT_FILE),format=raw --nographic

clean:
	rm -f $(BOOT_FILE)

