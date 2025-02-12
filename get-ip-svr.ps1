param(
    [switch]$SingleRun
)

# Define the port to listen on
$port = 8080

# Create a new TCP listener
$listener = [System.Net.Sockets.TcpListener]::Create($port)
$listener.Start()

$now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss.fffK")
Write-Host "[${now}] Listening on port $port... Press 'q' to quit."

# Function to get the public IP address of the client
function Get-PublicIP {
    param (
        [System.Net.Sockets.TcpClient]$client
    )
    $clientStream = $client.GetStream()
    $reader = New-Object System.IO.StreamReader($clientStream)
    $writer = New-Object System.IO.StreamWriter($clientStream)
    
    # Read the incoming request
    $request = $reader.ReadLine()
    if ($request.StartsWith("GET")) {
        # Get the client's IP address
        $clientIP = $client.Client.RemoteEndPoint.Address.ToString()
        
        # Verbose output
        $now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss.fffK")
        Write-Output "[${now}] Client IP is ${clientIP}."
        
        # Prepare the response
        $response = "HTTP/1.1 200 OK`r`nContent-Type: text/plain`r`n`r`n$clientIP"
        
        # Send the response
        $writer.WriteLine($response)
        $writer.Flush()
    }
    
    # Clean up
    $reader.Close()
    $writer.Close()
    $client.Close()
}

# Main loop to accept connections
while ($true) {
    if ($listener.Pending()) {
        $client = $listener.AcceptTcpClient()
        Get-PublicIP -client $client
        if ($SingleRun){break}
    }
    if ($Host.UI.RawUI.KeyAvailable) {
        $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        if ($key.Character -eq 'q') {
            break
        }
    }

    
}

# Stop the listener when done
$listener.Stop()
$now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss.fffK")
Write-Host "[${now}] Server stopped."
