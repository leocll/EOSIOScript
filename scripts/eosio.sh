#!/bin/bash

usage() {
    cat 1>&2 << EOF
EOSIO script

USAGE:
    bash ${BASH_SOURCE[0]} [ACTIONS] [OPTIONS]

ACTIONS:
    start		            Enable verbose output
	restart					
    stop                    Disable confirmation prompt.
	clean					
    i, install              Prints help information

OPTIONS:
    -m, --mode <all|node|wallet>              Choose a default host triple
EOF
}