#!/usr/bin/env bash

set -e
export HSD_NETWORK=regtest

hsd \
--memory=true \
--network=regtest \
--plugins=handover \
--daemon

sleep 2

hsd-rpc generatetoaddress 100 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc sendopen shrtr >/dev/null
hsd-rpc generatetoaddress 10 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc sendbid shrtr 1 1 >/dev/null
hsd-rpc generatetoaddress 10 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc sendreveal >/dev/null
hsd-rpc generatetoaddress 10 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc sendupdate shrtr '{"records":[{"type":"NS", "ns":"0x36fc69f0983E536D1787cC83f481581f22CCA2A1._eth."}]}' >/dev/null
hsd-rpc generatetoaddress 10 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc getnameresource shrtr

echo "WITH UNBOUND:"
dig @127.0.0.1 -p 25350 certified.shrtr
dig @127.0.0.1 -p 25350 fuckingfucker.eth

hsd-rpc stop

hsd \
--memory=true \
--network=regtest \
--plugins=handover \
--rs-no-unbound \
--daemon

sleep 2

hsd-rpc generatetoaddress 100 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc sendopen shrtr >/dev/null
hsd-rpc generatetoaddress 10 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc sendbid shrtr 1 1 >/dev/null
hsd-rpc generatetoaddress 10 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc sendreveal >/dev/null
hsd-rpc generatetoaddress 10 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc sendupdate shrtr '{"records":[{"type":"NS", "ns":"0x36fc69f0983E536D1787cC83f481581f22CCA2A1._eth."}]}' >/dev/null
hsd-rpc generatetoaddress 10 $(hsw-rpc getnewaddress) >/dev/null
hsw-rpc getnameresource shrtr

echo "--"
echo "NO UNBOUND:"
dig @127.0.0.1 -p 25350 certified.shrtr
dig @127.0.0.1 -p 25350 fuckingfucker.eth

hsd-rpc stop
