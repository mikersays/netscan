# Network Device Scanner

This script scans the local network for connected devices, logs their IP and MAC addresses, and looks up the manufacturer using the `manuf` tool from the Wireshark package.

## Features

- Scans the local network for connected devices.
- Logs device IP, MAC address, and manufacturer.
- Supports continuous scanning with specified intervals.
- Option to display results without logging.
- Customizable log file location.

## Prerequisites

- `arp-scan`: For scanning the local network.
- `manuf`: For MAC address to manufacturer lookup. This tool is part of the Wireshark package.

## Usage

```
./network_scanner.sh [OPTIONS]
```

## Options

- `-l, --log [FILENAME]`: Specify a custom log file (default: network_log.txt)
- `-i, --interval [SECONDS]`: Specify scan interval for continuous mode (default: 60 seconds)
- `-d, --display`: Display the scan results without logging to file
- `-h, --help`: Display the help message and exit

## Installation

1. Ensure you have `arp-scan` and `manuf` installed on your system.
   
   On Debian/Ubuntu:
   ```
   sudo apt-get install arp-scan wireshark-common
   ```

2. Clone this repository or download the `network_scanner.sh` script.
3. Make the script executable:
   
   ```
   chmod +x network_scanner.sh
   ```

4. Run the script with desired options.

## Examples

1. Run the scanner once and display the results without logging:
   ```
   ./network_scanner.sh -d
   ```

2. Run the scanner continuously with a custom interval of 120 seconds and log to a custom file:
   ```
   ./network_scanner.sh -i 120 -l custom_log.txt
   ```

## License

MIT License. See `LICENSE` file for more details.

---

You can save this content to a `README.md` file. If you want to include a license, you can replace "MIT License. See `LICENSE` file for more details." with the actual license text or any other license you prefer.
