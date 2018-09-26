FC=gfortran
LDFLAGS=-L/usr/local/lib/gcc6 -R/usr/local/lib/gcc6
FCFLAGS=-I$(LIB) -Wall -Wextra -pedantic -std=f2008 -fPIC
DEBUGFLAGS=-ggdb -fbacktrace -ffpe-trap=zero,overflow,underflow
SRC= src
TESTS= $(SRC)/test
LIB= $(SRC)/lib
NAME=cmp_mod
DEST= .
BIN= $(DEST)/bin

$(NAME): $(LIB)

$(LIB): $(DEST)
		$(MAKE) -C $@ $(MAKECMDGOALS)

$(DEST):
		mkdir $(DEST)/lib
		mkdir $(DEST)/bin

all: $(NAME) 

test: $(DEST)
		$(MAKE) -C $(TESTS) $(MAKECMDGOALS)
		$(DEST)/bin/test

clean:
		$(MAKE) -C $(LIB) $(MAKECMDGOALS)
		$(MAKE) -C $(TESTS) $(MAKECMDGOALS)
		$(RM) *.o *.mod $(BIN)/$(NAME) $(BIN)/$(NAME)test

.PHONY: $(LIB)

