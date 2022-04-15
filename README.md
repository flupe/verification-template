# Template for Practical Verification of Functional Libraries

## Dependencies

This template relies on a custom fork of both [agda2hs] and [Agda].
To build them from source, do the following:

```
git clone https://github.com/flupe/agda2hs-project
cd agda2hs-project
cabal install Agda
cabal install agda2hs
```

Building Agda may take a while.

In order to use the Haskell prelude of `agda2hs` from your Agda code, you also
need to tell Agda where to locate the library.

Clone Jesper's fork of agda2hs:

```
git clone -b erasure-annotations https://github.com/jespercockx/agda2hs
```

Inside the file `~/.agda/libraries`, add the following line:

```
/your/path/to/agda2hs/agda2hs.agda-lib
```

You're all set!

## Development

You should be good to go. Open any file in the `src/` directory inside emacs and
you should be able to use the Haskell prelude in your code without any issue.

Running `make` at the root of the project will:
- compile `Everything.agda` using `agda2hs`.
  Don't forget to import your agda files in `Everything.agda` to have them
  compile to Haskell automatically.
- compile the Haskell library generated from the Agda files in `lib/`.
- comile the demo Haskell executable in `demo/`

[Agda]:    https://github.com/agda/Agda
[agda2hs]: https://github.com/agda/agda2hs

