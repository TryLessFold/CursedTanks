CC = gcc
CPPC = g++

CPPCFLAGS = -g
CPPCFLAGS += -c
CPPCFLAGS += -I include
CPPCFLAGS += -pipe

CCFLAGS = $(CPPCFLAGS)
CCFLAGS += -std=c99

PHONY_N = base clean create obj_lib create_in_lib objects

#.c sources Cursed_Tanks
LIBRARY_C_S := $(wildcard lib/src/*.c)

#.cpp sources Cursed_Tanks
LIBRARY_CPP_S := $(wildcard lib/src/*.cpp)

SFML_LIBRARIES = sfml-graphics
SFML_LIBRARIES += sfml-window
SFML_LIBRARIES += sfml-system
SFML_LIBRARIES := $(addprefix -l, $(SFML_LIBRARIES))

.PHONY: $(PHONY_N)

all: base

base: Cursed_Tanks.o
	$(CPPC) obj/Cursed_Tanks.o -o bin/CursedTanks -g $(SFML_LIBRARIES) -L./lib -lcursedtanks

Cursed_Tanks.o: sources/Cursed_Tanks.cpp
	$(CC) sources/Cursed_Tanks.cpp -o obj/Cursed_Tanks.o $(CPPCFLAGS)

assem_lib: objects
	ar -rc lib/libcursedtanks.a $(wildcard ./*.o)

objects:
	$(CC) $(LIBRARY_C_S) $(CCFLAGS)
	$(CPPC) $(LIBRARY_CPP_S) $(CPPCFLAGS)

clean_lib:
	rm lib/*.a

create:
	mkdir -p obj
	mkdir -p bin
clean:
	rm -rdf bin
	rm -rdf obj
	rm *.o
