param(
 [System.Net.IPAddress]$target=127.0.0.1,
 [int]$port=8080
)

(Invoke-WebRequest "http://${target}:${port}").content
