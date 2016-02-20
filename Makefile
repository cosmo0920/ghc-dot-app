STACK_VER=0.1.10.0
STACK_URL=https://github.com/commercialhaskell/stack/releases/download/v$(STACK_VER)/stack-$(STACK_VER)-osx-x86_64.tar.gz
STACK_DL=./dist/download/stack-$(STACK_VER).tar.gz
STACK_BIN=./dist/unpack/stack-$(STACK_VER)-osx-x86_64/stack
STACK=$(shell which stack || echo $(STACK_BIN))

all: ghc

GHC.app: ghc
	(cd GHC; xcodebuild)

ghc: $(STACK)
	$(STACK) build
	$(STACK) exec main

$(STACK_BIN):
	mkdir -p ./dist/download ./dist/unpack
	curl -s -L -o $(STACK_DL) $(STACK_URL)
	tar -xf $(STACK_DL) -C ./dist/unpack

clean:
	rm -rf dist GHC/build

.PHONY: all clean ghc GHC.app
