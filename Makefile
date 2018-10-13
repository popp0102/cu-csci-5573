APP      := modulusPrime
TESTAPP  := runTests
BINDIR   := bin
SRCDIR   := src

CXX      := g++
LINKER   := g++
CXXFLAGS := -Wall -std=c++11 -g
LD_FLAGS := -lgtest -lpthread
INCLUDES := -I ./include

SRCFILES := $(wildcard $(SRCDIR)/*.cpp)
OBJFILES := $(SRCFILES:.cpp=.o)
DEPFILES := $(SRCFILES:.cpp=.d)

$(APP): $(OBJFILES)
	$(LINKER) $^ -o $(BINDIR)/$(APP)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

%.d: %.cpp
	$(CXX) $(INCLUDES) -MM $< > $@

tests:
	$(CXX) $(CXXFLAGS) $(INCLUDES) src/scheduler.cpp test/main.cpp test/scheduler_test.cpp -o $(BINDIR)/$(TESTAPP) $(LD_FLAGS)

install:
	bin/install

clean:
	rm -rf $(BINDIR)/$(APP)* $(BINDIR)/$(TESTAPP)* $(SRCDIR)/*.o $(SRCDIR)/*.d

-include $(DEPFILES)

.PHONY: clean

