# Windows PowerShell script to start the application

# Function to get database host based on OS
function Setup-DbHost {
    # Test if host.docker.internal is available
    if (Test-Connection host.docker.internal -Count 1 -Quiet) {
        Write-Host "Using host.docker.internal for database connection" -ForegroundColor Green
        $env:DB_HOST = "host.docker.internal"
    } else {
        # For environments without Docker Desktop
        Write-Host "host.docker.internal is not available." -ForegroundColor Yellow
        Write-Host "Please set DB_HOST environment variable manually:" -ForegroundColor Yellow
        Write-Host "    $env:DB_HOST = 'your_database_host'" -ForegroundColor Yellow
        exit 1
    }
}

# Only set DB_HOST if it's not already set in config.env or environment
if (-not $env:DB_HOST) {
    Setup-DbHost
}

Write-Host "`nVerifying configuration..." -ForegroundColor Cyan
Write-Host "DB_HOST: $(if ($env:DB_HOST) { $env:DB_HOST } else { 'from config.env' })"
Write-Host "DB_PORT: $(if ($env:DB_PORT) { $env:DB_PORT } else { 'from config.env' })"
Write-Host "DB_SID: $(if ($env:DB_SID) { $env:DB_SID } else { 'from config.env' })"
Write-Host "DB_USER: $(if ($env:DB_USER) { $env:DB_USER } else { 'from config.env' })"

Write-Host "`nStarting the application with Docker Compose..." -ForegroundColor Green
docker-compose up --build

# To stop the container, press Ctrl+C