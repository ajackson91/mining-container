#!/bin/bash

onExit() {
  rm -rf ${out}
}

error() {
  echo "ERROR: $1" >> $logFile
  cat ${out} >> $logFile
  echo "END ERROR" >> $logFile
}

trap error ERR
trap onExit EXIT

out=$(mktemp)

set -e

outputFiles="/opt/mining-container/logs"

logFile="$outputFiles/log.txt"

/opt/mining-container/cpuminer-multi/minerd -a cryptonight -o stratum+tcp://xdn.pool.minergate.com:45620 -u xanderj23@gmail.com -p x &>> $logFile

