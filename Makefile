# Source dir
SRC_DIR = src
# Binaries dir
BIN_DIR = bin

# Configure building environtment
LINK_FILES = 
LIBS = -larmadillo
INCLUDES = -Iinclude

# Search for all the header files
BPT_HEADER_DIRS = include include/tsc include/tsc/bpt include/tsc/bpt/models include/tsc/bpt/models/concepts include/tsc/bpt/policies include/tsc/data include/tsc/data/matrix include/tsc/image include/tsc/io include/tsc/io/data_saver include/tsc/log include/tsc/policies include/tsc/util include/tsc/util/filtering include/tsc/util/types
BPT_HEADERS := $(foreach DIR, $(BPT_HEADER_DIRS), $(wildcard $(DIR)/*.h))
BPT_HEADERS += $(foreach DIR, $(BPT_HEADER_DIRS), $(wildcard $(DIR)/*.hpp))

BPT_SOURCE_DIRS = src
BPT_SOURCES := $(foreach DIR, $(BPT_SOURCE_DIRS), $(wildcard $(BPT_DIR)/$(DIR)/*.cpp))

CPPFLAGS += $(INCLUDES) $(LIBS)
CXXFLAGS += -march=native -O3 -pipe -Wall -Wextra -Wpointer-arith -Wcast-qual -Wno-unknown-pragmas -fopenmp -DSAVE_BPT_MODELS

# Add additional targets here
TARGETS = TEBPT

BIN_FILES = $(foreach TARGET, $(TARGETS), $(BIN_DIR)/$(TARGET))

all : $(BIN_FILES)

clean :
	rm -f $(BIN_FILES)

# Default target construction
$(BIN_DIR)/%: $(SRC_DIR)/%.cpp $(BPT_HEADERS) $(BPT_SOURCES)
	@echo " ****** Creating" $@ with $<
	$(CXX) $(CXXFLAGS) -o $@ $< $(CPPFLAGS) $(LINK_FILES)

