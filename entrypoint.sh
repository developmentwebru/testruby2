#!/bin/sh
set -e

# Dependenc check for Postgres
echo "Waiting for database ⛳️"
until PGPASSWORD=postgres psql -h db -U postgres -c '\q' > /dev/null 2>&1; do
  sleep 1
done

# Run migrations and seed database before starting the server
echo "Running migrations 🧶"
rails db:migrate

# Remove a potentially pre-existing server.pid for Rails.
rm -f tmp/pids/server.pid

echo "Starting server 🚀"
exec "$@"
