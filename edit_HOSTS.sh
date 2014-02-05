#!/usr/bin/env bash
#
# edit_HOST.sh - An host file editor;
#
# Usage:
#
#     # Edit the default host file
#      ./edit_HOST.sh
#
#     # Edit an specific environment file (localhost -l; development -d; homologation -h; production -p)
#      ./edit_HOST.sh -l 
source $(dirname $0)/commands.sh

FILE="Hosts";
FILE_PATH="/private/etc/";

# Parse user options
#
while getopts "ldhp" opt; do
  case $opt in

    # Set localhost's host file
    l)
        echo "-choosed LOCAL!" >&2
        FILE="hosts.lch";
      ;;

    # Set development's host file
    d)
        echo "-choosed DEVELOPMENT!" >&2
        FILE="hosts.dev";
      ;;

    \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
    :)
    echo "Option -$OPTARG requires an argument." >&2
    exit 1
    ;;
  esac
done

DEFAULT_IDE="sublime";

ROUTER=$(networksetup -getinfo Ethernet | grep '^Router:' | awk '{print $2}')

echo $ROUTER;

case $ROUTER in
  "172.20.92.1")  FILE_PATH="~/Dropbox/JOBS/RBS/Hosts/";
          echo "CONFIGURING RBS";
          ;;
esac

run_cmd "$DEFAULT_IDE $FILE_PATH$FILE"