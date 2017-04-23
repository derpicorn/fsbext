NAME := fsbext
SRCFILES := ./src/fsbext.c
OBJECTS := $(notdir ${SRCFILES:.c=.o})

prefix := /usr/local
exec_prefix := ${prefix}
bindir := ${exec_prefix}/bin

CFLAGS += -I./src 
CFLAGS += -Wno-format 
CFLAGS +=  
CFLAGS += -O

LD := $(CC)
LDFLAGS := -lcomdlg32

# workaround for liberal use of uint8_t pointers where char pointers
# are expected and vise-versa.
#
# It's hoped that -funsigned-char will correct for any mismatch and
# -Wpointer-sign will quelch the ~= 200 warnings but it erks me a little.
CFLAGS += -funsigned-char -Wno-pointer-sign

all:	$(NAME)

install: $(NAME)
	cp $(NAME) $(bindir)

%.o: ./src/%.c
	$(CC) -c -o $@ $< $(CFLAGS)

$(NAME): $(OBJECTS)
	$(LD) -o $@ $^ $(LDFLAGS) 

.PHONY: clean 
clean:
	rm -f $(NAME) $(OBJECTS)
