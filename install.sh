#!/bin/bash

# ============================================================================
# Web Structure Generator - Installer
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

INSTALL_PATH="/usr/local/bin/webinit"
SCRIPT_NAME="webinit"

echo -e "\n${BOLD}${CYAN}Web Structure Generator - Installer${NC}\n"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}✖${NC} This script must be run as root (use sudo)."
    echo -e "  Usage: ${CYAN}sudo ./install.sh${NC}"
    exit 1
fi

# Check OS compatibility
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" != "debian" && "$ID" != "ubuntu" && "$ID_LIKE" != *"debian"* && "$ID_LIKE" != *"ubuntu"* ]]; then
        echo -e "${RED}✖${NC} This tool is designed for Debian/Ubuntu systems."
        echo -e "  Detected: ${ID} ${VERSION_ID}"
        exit 1
    fi
    echo -e "${GREEN}✔${NC} System detected: ${ID} ${VERSION_ID}"
else
    echo -e "${RED}✖${NC} Cannot detect OS. This tool requires Debian or Ubuntu."
    exit 1
fi

# Check if webinit script exists in current directory
if [ ! -f "./${SCRIPT_NAME}" ]; then
    echo -e "${RED}✖${NC} '${SCRIPT_NAME}' not found in current directory."
    echo "  Please run this installer from the web-structure-generator directory."
    exit 1
fi

# Install
echo -e "${GREEN}✔${NC} Installing ${SCRIPT_NAME} to ${INSTALL_PATH}..."
cp "./${SCRIPT_NAME}" "${INSTALL_PATH}"
chmod 755 "${INSTALL_PATH}"

# Verify installation
if command -v webinit &> /dev/null; then
    echo -e "${GREEN}✔${NC} Installation successful!"
    echo -e "\n  Run ${CYAN}webinit help${NC} to get started.\n"
else
    echo -e "${RED}✖${NC} Installation may have failed. Check if ${INSTALL_PATH} exists."
    exit 1
fi

exit 0
