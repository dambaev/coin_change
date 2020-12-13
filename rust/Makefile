
.PHONY: all clean

all: tests

cleanall::
cleanall:: ; $(RMF) test?

RMF=rm -f

clean:: ; $(RMF) test?
clean:: ; $(RMF) *~

cleanall:: clean

TESTS= \
	test2
#	test1 \
#	test2 \

tests: $(TESTS)

test1:
	rustc -O $@.rs -o $@

test2:
	rustc -O $@.rs -o $@

test3:
	rustc -O $@.rs -o $@

bench: tests
	for T in $(TESTS); do \
		time for I in $(shell seq 1 100 ); do \
			./$$T > /dev/null; \
		done; \
	done

