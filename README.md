```
+ cabal run --with-ghc=ghc-9.6
Resolving dependencies...
Running in GHC 9.6.6
============================================================
run, called at 12:23

============================================================
run, called at 18:9
outer, called at 12:27

============================================================
run, called at 15:9
inner, called at 18:13
outer, called at 12:27

+ cabal run --with-ghc=ghc-9.8
Resolving dependencies...
Running in GHC 9.8.2
============================================================
run, called at 12:23

============================================================
run, called at 18:9
run, called at 12:23

============================================================
run, called at 15:9
run, called at 18:9
run, called at 12:23
```

If `RequireCallStack` is replaced with `HasCallStack`, the traces become the
same on both versions of GHC.
