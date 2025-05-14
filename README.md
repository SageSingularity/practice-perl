# Oracle Perl Application

## Initial Setup

1. Prerequisites:
   - Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows/macOS) or Docker Engine (Linux)
   - Oracle database running (local or remote)

2. Clone the repository:
   ```bash
   git clone <repository-url>
   cd practice-perl
   ```

3. Configure database connection:
   - Option 1: Edit `config.env` file with your database settings
   - Option 2: Set environment variables (will override config.env)

## Database Configuration

### Option 1: Using config.env (Recommended)
1. Edit the `config.env` file:
   ```env
   DB_HOST=your_database_host
   DB_PORT=1521
   DB_SID=your_sid
   DB_USER=your_username
   DB_PASSWORD=your_password
   ```
2. Run the start script (the config will be automatically loaded)

### Option 2: Using Environment Variables
You can override any database settings using environment variables:

Windows PowerShell:
```powershell
$env:DB_HOST = "your_database_host"
$env:DB_PORT = "1521"
$env:DB_SID = "your_sid"
$env:DB_USER = "your_username"
$env:DB_PASSWORD = "your_password"
```

Linux/macOS:
```bash
export DB_HOST=your_database_host
export DB_PORT=1521
export DB_SID=your_sid
export DB_USER=your_username
export DB_PASSWORD=your_password
```

### Default Settings
If no configuration is provided, these defaults will be used:
- Host: host.docker.internal (Windows/macOS) or auto-detected (Linux)
- Port: 1521
- SID: XE
- User: SYSTEM
- Password: myCurrentPassword$523

## Running the Application

### Windows
```powershell
.\start_windows.ps1
```

### Linux/macOS
```bash
./start_linux.sh
```

The application will:
1. Load configuration from config.env (if present)
2. Apply any environment variables (overriding config.env)
3. Start the container with Docker Compose
4. Store output files in the `output` directory

To stop the application, press Ctrl+C.

## Troubleshooting

1. If you see connection errors:
   - Verify your Oracle database is running
   - Check if the database accepts connections from Docker containers
   - Ensure your database credentials in config.env are correct
   - For Linux: Check if your database listener accepts connections from the container network

2. If `host.docker.internal` is not working:
   - Windows/macOS: Ensure Docker Desktop is running
   - Linux: The script will automatically use your host IP
   - Or manually set DB_HOST in config.env or environment variables