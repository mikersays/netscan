#!/bin/bash

# File to store log (default value)
LOG_FILE="network_log.txt"

# Interval for continuous scanning (default value)
INTERVAL=60

# Display mode flag
DISPLAY_ONLY=0

# Help message
function show_help {
    echo "Usage: $0 [OPTIONS]"
    echo "Scan the local network for connected devices."
    echo ""
    echo "Options:"
    echo "  -l, --log [FILENAME]     Specify a custom log file (default: $LOG_FILE)"
    echo "  -i, --interval [SECONDS] Specify scan interval for continuous mode (default: $INTERVAL seconds)"
    echo "  -d, --display            Display the scan results without logging to file"
    echo "  -h, --help               Display this help message and exit"
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -l|--log) LOG_FILE="$2"; shift ;;
        -i|--interval) INTERVAL="$2"; shift ;;
        -d|--display) DISPLAY_ONLY=1 ;;
        -h|--help) show_help; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; show_help; exit 1 ;;
    esac
    shift
done

while true; do
    # Get the current date and time
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    # Print the timestamp
    output="$timestamp - Connected Devices:"
    if [[ $DISPLAY_ONLY -eq 1 ]]; then
        echo "$output"
    else
        echo "$output" >> $LOG_FILE
    fi

    # Use arp-scan to find devices on the network
    sudo arp-scan -l | grep -E '([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}' | while read -r line ; do
        # Extract IP and MAC from the line
        ip=$(echo $line | awk '{print $1}')
        mac=$(echo $line | awk '{print $2}')
        vendor=$(manuf -s $mac)
        output="IP: $ip, MAC: $mac, Vendor: $vendor"
        
        if [[ $DISPLAY_ONLY -eq 1 ]]; then
            echo "$output"
        else
            echo "$output" >> $LOG_FILE
        fi
    done

    # Add a newline for separation
    if [[ $DISPLAY_ONLY -eq 0 ]]; then
        echo "" >> $LOG_FILE
    fi

    # If display mode is active, exit the loop
    if [[ $DISPLAY_ONLY -eq 1 ]]; then
        break
    fi

    # Sleep for the specified interval
    sleep $INTERVAL
done
