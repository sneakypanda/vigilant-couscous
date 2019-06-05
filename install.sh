#!/usr/bin/env bash
TARGET_BIN_DIR="${HOME}/.local/bin"
SCRIPTS=*.sh
echo "* Script installation target directory: ${TARGET_BIN_DIR}"

for SCRIPT in ${SCRIPTS}
do
    if [[ ${SCRIPT} != "install.sh" ]]; then
        TARGET="${TARGET_BIN_DIR}/vc_${SCRIPT}"
        echo "> Installing ${SCRIPT} to ${TARGET}"
        install --backup ${SCRIPT} ${TARGET}
    fi
done
