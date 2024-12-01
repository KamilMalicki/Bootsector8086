# Definicja zmiennych
BOOT_FILE = boot.bin            # Plik wynikowy, który będzie zawierał zbudowany obraz rozruchowy
SOURCE_FILE = boot.asm          # Plik źródłowy w asemblerze, który będziemy kompilować

# Cel domyślny - "all" uruchamia proces budowania
all: build

# Cel "build" zależy od $(BOOT_FILE)
# Kompiluje plik źródłowy $(SOURCE_FILE) do obrazu rozruchowego $(BOOT_FILE)
build: $(BOOT_FILE)

# Reguła budowania $(BOOT_FILE) z pliku źródłowego $(SOURCE_FILE)
# Używa kompilatora NASM (Netwide Assembler), by skompilować plik do formatu binarnego
# Flaga -f bin wskazuje, że output ma być w formacie binarnym, a -o określa nazwę pliku wyjściowego
$(BOOT_FILE): $(SOURCE_FILE)
	nasm -f bin $(SOURCE_FILE) -o $(BOOT_FILE)

# Cel "run" uruchamia emulator QEMU, aby uruchomić obraz rozruchowy $(BOOT_FILE)
run: $(BOOT_FILE)
	qemu-system-i386 -drive file=$(BOOT_FILE),format=raw --nographic

# Cel "clean" usuwa plik wynikowy $(BOOT_FILE), aby wyczyścić środowisko
clean:
	rm -f $(BOOT_FILE)
