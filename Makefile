.PHONY: default

default: full_build

clean:
	@echo == Cleaning Haskell code directory ==
	@rmdir /s /q lib ||:
	@rm -r lib/ ||:
	@echo == Cleaning Success ==

build:
	@echo == Compiling Agda code ==
	agda2hs -olib -i. Everything.agda
	@echo == Compiling Haskell code ==
	cabal build all

full_build: clean build 