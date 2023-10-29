TARGET_EXEC ?= application.elf

TRIPLE := riscv-none-elf
AS := $(TRIPLE)-gcc
CC := $(TRIPLE)-gcc
CXX := $(TRIPLE)-g++
DUMP := $(TRIPLE)-objdump
SIZE := $(TRIPLE)-size
OPENOCD := ./vendor/bin/openocd

BUILD_DIR ?= ./build
SRC_DIRS ?= ./src ./vendor/Core ./vendor/Debug ./vendor/Peripheral ./vendor/Startup ./vendor/User

SRCS := $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c -or -name *.S)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

FLAGS ?= -march=rv32imac_zicsr -mabi=ilp32 -msmall-data-limit=8 -mno-save-restore -Os -fmessage-length=0 -ffunction-sections -fdata-sections -Wunused -Wuninitialized  -g -DDEBUG=DEBUG_UART1
ASFLAGS ?= $(FLAGS) -x assembler $(INC_FLAGS) -MMD -MP
CFLAGS ?=  $(FLAGS) $(INC_FLAGS) -std=gnu11 -MMD -MP
CPPFLAGS ?=  $(FLAGS) $(INC_FLAGS) -std=gnu11 -MMD -MP
LDFLAGS ?= $(FLAGS) -T ./vendor/Ld/Link.ld -nostartfiles -Xlinker --gc-sections -Wl,-Map,"$(BUILD_DIR)/$(TARGET_EXEC:.elf=.map)" --specs=nano.specs --specs=nosys.specs

all: $(BUILD_DIR)/$(TARGET_EXEC) $(BUILD_DIR)/$(TARGET_EXEC:.elf=.lst)
	$(SIZE) $<

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	@echo "LINK $@"
	@$(CC) $(LDFLAGS) -o $@ $(OBJS)

%.lst: %.elf
	@echo "DISASM $@"
	@$(DUMP) -DS $< > $@ 

# assembly
$(BUILD_DIR)/%.S.o: %.S
	@echo "AS $<"
	@$(MKDIR_P) $(dir $@)
	@$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c
	@echo "CC $<"
	@$(MKDIR_P) $(dir $@)
	@$(CC) $(CFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp
	@echo "CXX $<"
	@$(MKDIR_P) $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@


flash: $(BUILD_DIR)/$(TARGET_EXEC)
	$(OPENOCD) -f vendor/wch-riscv.cfg -c 'init; halt; flash write_image erase $<; reg pc 0; resume; exit;'

.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p
