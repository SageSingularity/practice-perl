# Windows PowerShell script to start the application

Write-Host "Starting the application with Docker Compose..." -ForegroundColor Green
docker-compose up --build

# To stop the container, press Ctrl+C