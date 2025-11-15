COLIB = ../../core

AR = ar rcs
BUILD_DIR ?= .

SOURCES := callbacks.c check_context.c freecon.c init.c label.c label_file.c label_android_property.c
OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SOURCES))

all: libselinux.a

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(BUILD_DIR)
	gcc -DHOST -I../include -I$(COLIB)/include -c -o $@ $<

# Make libselinux.a depend on the actual object files
libselinux.a: $(OBJS)
	$(AR) $(BUILD_DIR)/libselinux.a $(OBJS)

clean:
	rm -f $(OBJS)
	rm -f $(BUILD_DIR)/libselinux.a
	rm -rf $(BUILD_DIR)/*.o

.PHONY: all clean
