FC=gfortran
FCFLAGS= -I. -Wall -Wextra -pedantic -std=f2008 -ggdb -fbacktrace -ffpe-trap=zero,overflow,underflow -fPIC
FILES= compare.f90
LD=ld
LDARGS=-G
LDFLAGS=-L$(TOP)/$(BUILD) -R$(TOP)/$(BUILD)
MAJV=0
MINV=1
PROG=compare
BUILD=build
TOP=../../

all: include lib

include:
		$(FC) $(FCFLAGS) -c $(TOP)/src/lib/$(FILES) -o $(PROG).o

lib:
		$(LD) $(LDARGS) $(PROG).o -o $(TOP)/lib/lib$(PROG).so.$(MAJV).$(MINV)

clean:
#       rm $(BUILD)/*.mod $(BUILD)/lib$(PROG)*
		rm *.mod *.o 

distclean: clean
		rm $(PROG)test lib$(PROG).so.$(MAJV).$(MINV)

