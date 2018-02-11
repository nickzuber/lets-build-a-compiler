OCB_FLAGS = -use-ocamlfind -pkg core,batteries,ounit -tags thread
OCB =       ocamlbuild $(OCB_FLAGS)

MODULES = src \
					src/transformers \
					utils

INCLUDE_MODULES = $(foreach dir, $(MODULES), -I $(dir))

all: build try
test: build-test run-test

try:
	./main.native

build:
	$(OCB) $(INCLUDE_MODULES) src/main.native

run-test:
	./test_main.native

build-test:
	$(OCB) $(INCLUDE_MODULES) tests/test_main.native

build-with-runtime:
	cc -c runtime/basics.c -o basics.o
	cc basics.o assembly.s -o program

clean:
	$(OCB) -clean
	rm *.o
	rm ./program

.PHONY: all run build build-test test try clean
