#!/bin/bash

# Function to get database host based on OS
setup_db_host() {
    # Check if host.docker.internal is available (Docker Desktop)
    if ping -c1 host.docker.internal >/dev/null 2>&1; then
        echo "Using host.docker.internal for database connection"
        export DB_HOST=host.docker.internal
    else
        # For Linux without Docker Desktop, use the host's IP
        echo "Setting up host IP for database connection..."
        export DB_HOST=$(ip route get 1 | awk '{print $(NF-2);exit}')
        echo "Using host IP: $DB_HOST"
        echo "Make sure your database is configured to accept connections from Docker containers"
    fi
}

# Only set DB_HOST if it's not already set in config.env or environment
if [ -z "$DB_HOST" ]; then
    setup_db_host
fi

echo -e "\nVerifying configuration..."
echo "DB_HOST: ${DB_HOST:-from config.env}"
echo "DB_PORT: ${DB_PORT:-from config.env}"
echo "DB_SID: ${DB_SID:-from config.env}"
echo "DB_USER: ${DB_USER:-from config.env}"
echo -e "\nStarting the application with Docker Compose..."
docker-compose up --build

# To stop the container, press Ctrl+C
