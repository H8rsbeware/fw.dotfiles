#!/usr/bin/env bash

case "$(mullvad status 2>/dev/null | head -n1)" in
    Connected*)
        mullvad disconnect
        ;;
    *)
        mullvad connect
        ;;
esac
