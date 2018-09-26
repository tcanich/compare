FC=gfortran
LDFLAGS=-L/usr/local/lib/gcc6 -R/usr/local/lib/gcc6
FCFLAGS=-I$(LIB) -Wall -Wextra -pedantic -std=f2008 -fPIC
DEBUGFLAGS=-ggdb -fbacktrace -ffpe-trap=zero,overflow,underflow
SRC= src
TESTS= $(SRC)/test
LIB= $(SRC)/lib
NAME=cmp_mod

$(NAME): $(LIB)

$(LIB): 
		$(MAKE) -C $@ $(MAKECMDGOALS)

all: $(NAME) 

test: 
		$(MAKE) -C $(TESTS) $(MAKECMDGOALS)
		bin/$(NAME)test

clean:
		$(MAKE) -C $(LIB) $(MAKECMDGOALS)
		$(MAKE) -C $(TESTS) $(MAKECMDGOALS)
		$(RM) *.o *.mod bin lib

.PHONY: $(LIB)

