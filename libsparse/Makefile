CC ?= gcc
AR ?= ar

CFLAGS += -Iinclude

BUILD_DIR ?= .

SOURCES := \
		backed_block.c \
		output_file.c \
		sparse.c \
		sparse_crc32.c \
		sparse_err.c \
		sparse_read.c

OBJ := $(patsubst %.c,$(BUILD_DIR)/%.o,$(SOURCES))

$(BUILD_DIR)/%.o: %.c
		@mkdir -p $(BUILD_DIR)
		$(CC) $(CFLAGS) -c -o $@ $<

libsparse.a: $(OBJ)
		$(AR) rcs $(BUILD_DIR)/libsparse.a $^

clean:
		rm -f $(OBJ) $(BUILD_DIR)/libsparse.a
		rm -rf $(BUILD_DIR)/*.o
