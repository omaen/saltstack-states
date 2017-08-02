#!/bin/bash

LIB=$(python3 -c 'import fwgen, os; print(os.path.dirname(fwgen.__file__))')

ln -sf "${LIB}/sbin/restore-fw" "/etc/network/if-pre-up.d/restore-fw"
