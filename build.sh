#!/usr/bin/env bash

cabal build --ghc-option="-opta-march=armv7-a"
cp `cabal list-bin hnode` .
docker build -t pim:80/hnode .
