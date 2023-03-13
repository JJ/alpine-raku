#!/bin/sh

zef install --deps-only .
racoco -l --cache-dir /home/raku/racoco-cache
