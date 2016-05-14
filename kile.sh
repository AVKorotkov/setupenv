#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

aptitude install kile kile-doc -yq
aspell aspell-en aspell-fr aspell-ru -yq
hunspell hunspell-en-us hunspell-fr hunspell-fr-classical hunspell-ru hunspell-tools -yq
aptitude install ispell -yq
