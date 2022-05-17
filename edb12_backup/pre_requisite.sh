#!/usr/bin/env bash

# environment
set -Eeuo pipefail

# Install Pre-requisites

echo "==============================================================="
echo "STAGE: Package Installation Started"
echo "==============================================================="

yum clean all
yum repolist
yum install git ansible-core -y

echo "==============================================================="
echo "STAGE: Package Installation Completed"
echo "==============================================================="
