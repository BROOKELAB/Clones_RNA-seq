#!/bin/bash

module load R/4.0.3-IGB-gcc-8.2.0

set -x
set -e

R --file="./count_matrix.R"
