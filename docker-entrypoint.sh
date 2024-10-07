#!/bin/bash
set -e

# Wait for database to be ready
until mysqladmin ping -h"db" -P"3306" --silent; do
  echo "Waiting for database connection..."
  sleep 2
done
echo "Database is ready!"

# Check if setup has been run before
if [ ! -f "/app/.db_created" ]; then
  echo "Create DB"
  rails db:create
  touch /app/.db_created
else
  echo "DB created, skipping..."
fi

if [ ! -f "/app/.setup_complete" ]; then
  echo "Running initial setup..."
  ./bin/setup
  touch /app/.setup_complete
else
  echo "Setup already completed, skipping..."
fi

# Execute the main command
exec "$@"
