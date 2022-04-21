.PHONY: default build

default: build

build:
	@echo == Compiling Agda code ==
	agda2hs -olib -i. Everything.agda
	@echo == Compiling Haskell code ==
	cabal build all --allow-newer=base
