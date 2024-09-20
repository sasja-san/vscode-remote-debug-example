#!/bin/bash

# Exit immediately if some variables are unset
set -o nounset
# Enable verbose tracing for debug purposes
set -o xtrace
WS_FOLDER="$1"
BIN_NAME="$2"
REMOTE_USER="$3"
REMOTE_HOST="$4"
REMOTE_ARCH="$5"
GDB_PORT="$6"

# Set target path
REMOTE_PATH="/home/${REMOTE_USER}/bin/debug"

# Set binary path to upload
BIN_PATH="${WS_FOLDER}/target/${REMOTE_ARCH}/debug/${BIN_NAME}"
# Kill previous debug sessions
ssh "${REMOTE_USER}@${REMOTE_HOST}" "killall gdbserver ${BIN_NAME}"
# Secure copy to the target device
scp "${BIN_PATH}" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"
# Start remote debug session
ssh -f "${REMOTE_USER}@${REMOTE_HOST}" "sh -c 'cd ${REMOTE_PATH}; nohup gdbserver :${GDB_PORT} ./${BIN_NAME} > ./console.log 2>&1 &'"
