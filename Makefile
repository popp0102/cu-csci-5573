NAME     := modulusPrime
APP1     := $(NAME)-1
APP2     := $(NAME)-2
APP3     := $(NAME)-3
APP4     := $(NAME)-4
APP1RR   := $(NAME)-1RR
TESTAPP  := runTests

DEMO     := demo
DEMO1    := $(DEMO)-1
DEMO2    := $(DEMO)-2
DEMO3    := $(DEMO)-3

BINDIR   := bin
SRCDIR   := src
PRGMDIR  := src/programs
TESTDIR  := test

CXX      := g++
CXXFLAGS := -Wall -std=c++11 -g
LDFLAGS  := -lgtest -lpthread -lboost_system
INCLUDES := -I ./include/os -I include/lib

MAIN1     := $(PRGMDIR)/main-1.cpp
MAIN2     := $(PRGMDIR)/main-2.cpp
MAIN3     := $(PRGMDIR)/main-3.cpp
MAIN4     := $(PRGMDIR)/main-4.cpp
MAIN1RR   := $(PRGMDIR)/main-1Rerun.cpp

DEMOSRC1  := $(PRGMDIR)/demo-1.cpp
DEMOSRC2  := $(PRGMDIR)/demo-2.cpp
DEMOSRC3  := $(PRGMDIR)/demo-3.cpp

SRCFILES  := $(shell find $(SRCDIR) -type f -name '*.cpp' -not -path "$(PRGMDIR)/*")
TESTFILES := $(shell find $(TESTDIR) -type f -name '*cpp')

all: clean app1 app2 app3 app4 app1RR test demo1 demo2 demo3

app1: $(BINDIR)/$(APP1)
app2: $(BINDIR)/$(APP2)
app3: $(BINDIR)/$(APP3)
app4: $(BINDIR)/$(APP4)
app1RR: $(BINDIR)/$(APP1RR)
test: $(BINDIR)/$(TESTAPP)
demo1: $(BINDIR)/$(DEMO1)
demo2: $(BINDIR)/$(DEMO2)
demo3: $(BINDIR)/$(DEMO3)

$(BINDIR)/$(DEMO1):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(DEMOSRC1) -o $@ $(LDFLAGS)

$(BINDIR)/$(DEMO2):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(DEMOSRC2) -o $@ $(LDFLAGS)

$(BINDIR)/$(DEMO3):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(DEMOSRC3) -o $@ $(LDFLAGS)

$(BINDIR)/$(APP1):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(MAIN1) -o $@ $(LDFLAGS)

$(BINDIR)/$(APP2):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(MAIN2) -o $@ $(LDFLAGS)

$(BINDIR)/$(APP3):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(MAIN3) -o $@ $(LDFLAGS)

$(BINDIR)/$(APP4):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(MAIN4) -o $@ $(LDFLAGS)

$(BINDIR)/$(APP1RR):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(MAIN1RR) -o $@ $(LDFLAGS)

$(BINDIR)/$(TESTAPP):
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRCFILES) $(TESTFILES) -o $@ $(LDFLAGS)

install:
	bin/install

clean:
	rm -rf $(BINDIR)/$(DEMO)* $(BINDIR)/$(NAME)* $(BINDIR)/$(TESTAPP)* *.txt

.PHONY: install clean
