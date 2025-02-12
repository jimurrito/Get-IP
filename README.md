# Get-IP
Simple server that provides the public IP back to the sending client. Written fully in Powershell.

- Compatible with both Windows and Linux.
- Small compute foot print.
- No install required (Pwsh core required for Linux)

<br><br>

# Install powershell core in Linux (Debian-based)

### Automated
```bash
git clone https://github.com/jimurrito/get-ip.git
cd get-ip/
sh setup.sh
```

### Manual
```bash
# Install pre-requisite packages.
sudo apt-get install -y wget

# Download the PowerShell package file
wget https://github.com/PowerShell/PowerShell/releases/download/v7.5.0/powershell_7.5.0-1.deb_amd64.deb

# Install the PowerShell package
sudo dpkg -i powershell_7.5.0-1.deb_amd64.deb

# Resolve missing dependencies and finish the install (if necessary)
sudo apt-get install -f

# Delete the downloaded package file
rm powershell_7.5.0-1.deb_amd64.deb
```

<br><br>

# Start server-side
**From bash**
```bash
# Setup looping server on port '8080'
pwsh get-ip-svr.ps1
# Non-looping mode
pwsh get-ip-svr.ps1 -SingleRun
# Custom Port
pwsh get-ip-svr.ps1 -Port 6900
```

**From Powershell**
```powershell
# Setup looping server on port '8080'
get-ip-svr.ps1
# Non-looping mode
get-ip-svr.ps1 -SingleRun
# Custom Port
get-ip-svr.ps1 -Port 6900
```

Once the server has started in looping mode, you can quit the loop by pressing the `q` key. The server will indicate the same on boot.
```bash
pwsh get-ip-svr.ps1
# [2025-02-12T00:35:17.177+00:00] Listening on port 8080... Press 'q' to quit.
```

<br><br>

# Start Client-side
**From bash**
```bash
# Connect to the server @ 127.0.0.1:8080
pwsh get-ip-client.ps1
# Connect to a custom host/port
pwsh get-ip-svr.ps1 -Target 192.168.0.4 -Port 6900
```

**From Powershell**
```powershell
# Connect to the server @ 127.0.0.1:8080
get-ip-client.ps1
# Connect to a custom host/port
get-ip-svr.ps1 -Target 192.168.0.4 -Port 6900
```

<br><br>

# Using `Get-IP-*.ps1`
```bash
# Server side
pwsh get-ip-svr.ps1
# Output:
# [2025-02-12T00:44:14.453+00:00] Listening on port 8080... Press 'q' to quit.

# Client side
get-ip-client.ps1 # => 127.0.0.1:8080
# Response:
# ::ffff:127.0.0.1
```
> If you connect over a network or the internet, the IP response will reflect the clients IP.
>  - Connecting from internal network => Private IP
>  - Connecting from public internet => Public IP

<br><br>

# Parameters

### `get-ip-svr.ps1`

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| `-SingleRun` | Switch | $false | If `-SingleRun` is used during runtime, the server will close the socket after the first connection. |
| `-Port` | Integer | 8080 | The Layer4 port the socket server will lisen on |


### `get-ip-client.ps1`

| Param | Type | Default | Description |
| --- | --- | --- | --- |
| `-Target` | System.Net.IPAddress | 127.0.0.1 | The target server hosting running the `get-ip-svr.ps1` script. |
| `-Port` | Integer | 8080 | The Layer4 port the socket client will connect to. |

<br><br>

# Any issues?
Open an issue on this github repo!
