######
#
# Note that
# certain installations require the following changes:
#
# atscc -> patscc
# atsopt -> patsopt
# ATSHOME -> PATSHOME
#
######
#
#
######
#
ATSHOME=$(shell dirname $(shell dirname $(shell readlink -f $(shell which patscc))))
ATSCC=patscc
ATSOPT=patsopt
#
ATSCCFLAGS=-O2 -DATS_MEMALLOC_LIBC -I"../libs/" -I"$(ATSHOME)/lib/ats2-postiats-0.3.13/contrib/atscntrb/"
ATSLIBS=
# ATSCCFLAGS=-O2
#
# '-flto' enables link-time optimization such as inlining lib functions
#
# ATSCCFLAGS=-O2 -flto
#
#
ATS_DATS=
ATS_SATS=
######
#

ATS_OBJS= $(ATS_SATS:.sats=_sats.o) $(ATS_DATS:.dats=_dats.o)

.PHONY: all clean

all: tests

cleanall::
#
######
#
# Please uncomment the following three lines and replace the name [foo]
# with the name of the file you want to compile
#


coin_change: $(ATS_OBJS)
	$(ATSCC) $(ATSCCFLAGS) -o $@ $(ATS_OBJS) DATS/main.dats $(ATSLIBS)

cleanall:: ; $(RMF) test*
#
######
#
# You may find these rules useful
#
%_sats.o: %.sats ; $(ATSCC) $(ATSCCFLAGS) -c -o $@ $<
%_dats.o: %.dats ; $(ATSCC) $(ATSCCFLAGS) -c -o $@ $<
#
######
#
RMF=rm -f
#
######
#
clean:: ; $(RMF) test*
clean:: ; $(RMF) coin_change
clean:: ; $(RMF) *~
clean:: ; find -name '*_?ats.o' -exec $(RMF) {} \;
clean:: ; find -name '*_?ats.c' -exec $(RMF) {} \;
#
cleanall:: clean

TESTS= \
	test1 \
	test2 \
	test3

tests: $(TESTS)

test1: $(ATS_OBJS)
	$(ATSCC) $(ATSCCFLAGS) -o $@ $(ATS_OBJS) TEST/$@.dats $(ATSLIBS)

test2: $(ATS_OBJS)
	$(ATSCC) $(ATSCCFLAGS) -o $@ $(ATS_OBJS) TEST/$@.dats $(ATSLIBS)

test3: $(ATS_OBJS)
	$(ATSCC) $(ATSCCFLAGS) -o $@ $(ATS_OBJS) TEST/$@.dats $(ATSLIBS)

bench: tests
	for I in $(shell seq 0 4); do \
		for T in $(TESTS); do \
			time ./$$T; \
		done; \
	done
#
###### end of [Makefile] ######

