#!/usr/bin/env bash
set -ex

cabal run --with-ghc=ghc-9.6
cabal run --with-ghc=ghc-9.8
