#!/usr/bin/env bash
PREFIX=${HOME}/.local
LOCAL_SRC=${PREFIX}/src
PYTHON_VERSION="3.7.3"

BASE_URL="https://www.python.org/ftp/python/${PYTHON_VERSION}"
BASE_NAME="Python-${PYTHON_VERSION}"
ARCHIVE_NAME="${BASE_NAME}.tgz"
SIG_NAME="${BASE_NAME}.tgz.asc"

TARBALL_SRC="${BASE_URL}/${ARCHIVE_NAME}"
SIG_SRC="${BASE_URL}/${SIG_NAME}"

echo ""
echo "PREFIX:         ${PREFIX}"
echo "LOCAL_SRC:      ${LOCAL_SRC}"
echo "PYTHON_VERSION: ${PYTHON_VERSION}"
echo ""
echo "BASE_URL:       ${BASE_URL}"
echo "ARCHIVE_NAME:   ${ARCHIVE_NAME}"
echo "SIG_NAME:       ${SIG_NAME}"
echo ""
echo "TARBALL_SRC:    ${TARBALL_SRC}"
echo "SIG_SRC:        ${SIG_SRC}"
echo ""


# OS Package requirements
sudo apt update
sudo apt install \
    build-essential \
    libreadline-dev \
    libssl-dev \
    libbz2-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libffi-dev \
    liblzma-dev \
    zlib1g-dev \
    tk-dev \

# Download and verify tarball
cd ${LOCAL_SRC}
echo "Changed to ${LOCAL_SRC}, PWD is ${PWD}"

if [[ ! -f ${ARCHIVE_NAME} ]]; then
  curl -O ${TARBALL_SRC}
else
    echo "File ${ARCHIVE_NAME} already exists."
fi
if [[ ! -f ${SIG_NAME} ]]; then
  curl -O ${SIG_SRC}
else
    echo "File ${SIG_NAME} already exists."
fi

echo ""
gpg --verify ${SIG_NAME}

# Extract and compile tarball
echo ""
tar xzf ${ARCHIVE_NAME}
echo "Finished extracting ${ARCHIVE_NAME}"

cd ${BASE_NAME}
echo "Changed to ${BASE_NAME}, PWD is ${PWD}"

./configure --prefix ~/.local/ --enable-optimizations
make
make altinstall

echo ""
echo "DONE"
echo ""

