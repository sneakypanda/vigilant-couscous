#!/usr/bin/env bash
#pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
UPDATE_LIST=$(pip list --outdated --format=freeze | grep -v '^\-e')
echo "Updating pip"
pip install --upgrade pip

for PKG_SPEC in ${UPDATE_LIST}; do
    PKG_NAME=$(echo ${PKG_SPEC} | awk -F== '{print $1}')
    echo "Updating ${PKG_NAME}"
    pip install --upgrade ${PKG_NAME}
done

