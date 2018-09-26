FC=gfortran
FCFLAGS= -I. -Wall -Wextra -pedantic -std=f2008 -ggdb -fbacktrace -ffpe-trap=zero,overflow,underflow -fPIC
FILES= mod_testing.f90 $(TOP)/src/lib/cmp_mod.f90 test.f90
LD=ld
LDARGS=-G
LDFLAGS=-L$(TOP)/lib -R$(TOP)/lib
MAJV=0
MINV=1
TEST=test.f90
PROG=cmp_mod
BUILD=build
TOP=../../

all: test

test: 
		$(FC) $(FCFLAGS) $(LDFLAGS) -o $(TOP)/bin/$(PROG)test $(FILES)

clean:
#       rm $(BUILD)/*.mod $(BUILD)/lib$(PROG)*
		rm *.mod *.o lib$(PROG).so.$(MAJV).$(MINV)

distclean: clean
		rm $(PROG)test lib$(PROG).so.$(MAJV).$(MINV)

