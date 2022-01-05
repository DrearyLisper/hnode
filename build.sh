#!/usr/bin/env bash -x

cabal build
cp `cabal list-bin hnode` .
docker build -t pim:80/hnode .
