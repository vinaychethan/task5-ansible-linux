#!/bin/bash
set -e

APP_DIR="/opt/task5-app"
LOG_FILE="/var/log/task5-deploy.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] Starting deployment..." | tee -a $LOG_FILE

# Install Node.js if not present
if ! command -v node &> /dev/null; then
    echo "[$TIMESTAMP] Installing Node.js..." | tee -a $LOG_FILE
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# Stop existing app if running
if pgrep -f "node $APP_DIR/app.js" > /dev/null; then
    echo "[$TIMESTAMP] Stopping existing app..." | tee -a $LOG_FILE
    pkill -f "node $APP_DIR/app.js" || true
fi

# Install dependencies
cd $APP_DIR
npm install --production

# Start the app in background
nohup node app.js > /var/log/task5-app.log 2>&1 &
echo $! > /var/run/task5-app.pid

echo "[$TIMESTAMP] Deployment successful! App running on port 3000." | tee -a $LOG_FILE
