APP      := modulusPrime
TESTAPP  := runTests
BINDIR   := bin
SRCDIR   := src
TESTDIR  := test
BUILDDIR := build

CXX      := g++
LINKER   := g++
CXXFLAGS := -Wall -std=c++11 -g
LDFLAGS  := -lgtest -lpthread
INCLUDES := -I ./include

SRCFILES := $(wildcard $(SRCDIR)/*.cpp)
OBJFILES := $(patsubst $(SRCDIR)/%.cpp, $(BUILDDIR)/%.o, $(SRCFILES))
DEPFILES := $(patsubst $(SRCDIR)/%.cpp, $(BUILDDIR)/%.d, $(SRCFILES))

TESTFILES := $(wildcard $(TESTDIR)/*.cpp)

all: app test

app: $(BINDIR)/$(APP)

test: $(BINDIR)/$(TESTAPP)

$(BINDIR)/$(APP): $(OBJFILES)
	$(LINKER) $(CXXFLAGS) $^ -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

$(BUILDDIR)/%.d: $(SRCDIR)/%.cpp
	$(CXX) $(INCLUDES) -MM $< > $@

$(BINDIR)/$(TESTAPP):
	$(CXX) $(CXXFLAGS) $(INCLUDES) src/scheduler.cpp $(TESTFILES) -o $@ $(LDFLAGS)

install:
	bin/install

clean:
	rm -rf $(BINDIR)/$(APP)* $(BINDIR)/$(TESTAPP)* $(BUILDDIR)/*

-include $(DEPFILES)

.PHONY: clean

