#!/usr/bin/env bash

status="$(mullvad status 2>/dev/null)"
first_line="$(head -n1 <<< "$status")"

case "$first_line" in
    Connected*)
        relay="$(awk '/Relay:/ { print $2; exit }' <<< "$status")"

        printf '{"text":"","class":"connected","tooltip":"Mullvad connected\\n%s"}\n' \
            "${relay:-Connected}"
        ;;

    Connecting*|Reconnecting*)
        printf '{"text":"","class":"connecting","tooltip":"Mullvad connecting..."}\n'
        ;;

    Blocked*)
        printf '{"text":"","class":"blocked","tooltip":"Mullvad blocking internet"}\n'
        ;;

    *)
        printf '{"text":"","class":"disconnected","tooltip":"Mullvad disconnected"}\n'
        ;;
esac
