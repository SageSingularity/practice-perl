Write-Host "Building the docker container..."
docker build -t oracle-perl-app .

Write-Host "Starting the docker container..."
docker run --rm oracle-perl-app ./entrypoint.sh 