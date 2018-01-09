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

mining_pool=$1
mining_account=$2
mining_aesni=$3

use_defaults=false

[ -z "$mining_pool" ] && use_defaults=true
[ -z "$mining_account" ] && use_defaults=true
[ -z "$mining_aesni" ] && use_defaults=true

if [ "$use_defaults" == "true" ]
then
  mining_pool='stratum+tcp://xmr.pool.minergate.com:45560'
  mining_account='xanderj23@gmail.com'
  mining_aesni='disabled'
fi

out=$(mktemp)

set -e

outputFiles="/opt/mining-container/logs"

logFile="$outputFiles/mining-container-$(date +%s).txt"

echo "pool: $mining_pool account: $mining_account aes-ni:$mining_aesni" &>> $logFile

if [ "$mining_aesni" == "enabled" ]
then
  echo "building with AES NI enabled" &>> $logFile
  cd /opt/mining-container/cpuminer-multi && ./autogen.sh && CFLAGS="-march=native" ./configure && make
else
  echo "building with AES NI disabled" &>> $logFile
  cd /opt/mining-container/cpuminer-multi && ./autogen.sh && CFLAGS="-march=native" ./configure --disable-aes-ni && make
fi

echo "Starting mining..." &>> $logFile

/opt/mining-container/cpuminer-multi/minerd -a cryptonight -o $mining_pool -u $mining_account -p x &>> $logFile

