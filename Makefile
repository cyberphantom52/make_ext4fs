CC ?= gcc
CFLAGS += -Iinclude -Ilibsparse/include -Ilibselinux/include

ifeq ($(STATIC),1)
  ZLIB := -Wl,-Bstatic -lz -Wl,-Bdynamic
else
  ZLIB := -lz
endif

BUILD_DIR := _build

# Create build directory structure
$(shell mkdir -p $(BUILD_DIR))

SOURCES := \
    allocate.c \
    canned_fs_config.c \
    contents.c \
    crc16.c \
    ext4fixup.c \
    ext4_sb.c \
    ext4_utils.c \
    extent.c \
    indirect.c \
    make_ext4fs_main.c \
    make_ext4fs.c \
    sha1.c \
    uuid.c \
    wipe.c

OBJ := $(patsubst %.c,$(BUILD_DIR)/%.o,$(SOURCES))

all: $(BUILD_DIR)/make_ext4fs

$(BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/make_ext4fs: $(OBJ) $(BUILD_DIR)/libsparse.a $(BUILD_DIR)/libselinux.a
	$(CC) $(LDFLAGS) -o $@ $^ $(ZLIB)

$(BUILD_DIR)/libsparse.a:
	$(MAKE) -C libsparse/ BUILD_DIR=../_build libsparse.a

$(BUILD_DIR)/libselinux.a:
	$(MAKE) -C libselinux/src/ BUILD_DIR=../../_build libselinux.a

clean:
	$(MAKE) -C libsparse/ clean
	$(MAKE) -C libselinux/src/ clean
	rm -rf $(BUILD_DIR)

.PHONY: all clean
