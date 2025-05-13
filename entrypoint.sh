#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Ensure output is not buffered
export PERL_UNICODE=SD
export PERLIO=:utf8

echo -e "${BLUE}Starting Oracle data operations...${NC}"

# Check if we're in the container
if [ ! -f "/.dockerenv" ]; then
    echo -e "${RED}This script must be run inside the Docker container${NC}"
    exit 1
fi

# Check if Perl is installed
if ! command -v perl &> /dev/null; then
    echo -e "${RED}Perl is not installed${NC}"
    exit 1
fi

# Check if DBI is installed
if ! perl -e "use DBI;" &> /dev/null; then
    echo -e "${RED}DBI module is not installed${NC}"
    exit 1
fi

# Check if DBD::Oracle is installed
if ! perl -e "use DBD::Oracle;" &> /dev/null; then
    echo -e "${RED}DBD::Oracle module is not installed${NC}"
    exit 1
fi

# Run the Perl script with unbuffered output
echo -e "${BLUE}Running Perl script...${NC}"
perl -U run.pl

echo -e "${GREEN}Done${NC}"

