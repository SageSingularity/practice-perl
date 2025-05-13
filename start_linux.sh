echo -e "Building the docker container..."
docker build -t oracle-perl-app .

echo -e "Starting the docker container..."
docker run --rm oracle-perl-app