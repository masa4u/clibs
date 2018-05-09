OS	= $(shell uname)
CC	= g++
AR	= ar rucs
INCLUDE	= -I../include
DEFINES	= -D$(OS) -DCOLOR -D_REENTRANT -DTEST_CODE=0 #-DDEBUG_MODE
DEFINES += -DAUTHOR="\"Kyunghwan Kim\"" -DEMAIL="\"kyunghwan.kim@dwsec.com\""

OPTION	= -Wall -g

CFLAGS	= $(OPTION) $(INCLUDE) $(DEFINES)
LDFLAGS	= -shared -fPIC

CFILES	= $(wildcard *.cpp)
OFILES	= $(notdir $(patsubst %.cpp,%.o,$(CFILES)))
DFILES	= $(OFILES:.o=.d)
LIBNAME = liblbfgsb

all: $(LIBNAME).a
	@rm -f $(DFILES)

$(LIBNAME).a: $(OFILES)
	$(AR) $@ $(OFILES)

$(LIBNAME).so: $(OFILES)
	$(CC) -o $@ $(OFILES) $(LDFLAGS)

$(OFILES): %.o:
	$(CC) $(CFLAGS) -c $<

tag:
	@ctags *.cpp include/*.h

clean:
	rm -f core $(OFILES) $(TARGET) $(DFILES) *~ $(LIBNAME).*

install:
	mv $(LIBNAME).a ~/lib
#	mv $(LIBNAME).a ../lib

-include $(DFILES)

%.d: %.cpp
	@set -e; rm -f $@; \
	$(CC) -M $(CFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@; \
	[ -s $@ ] || rm -f $@

setup:

-include setup
