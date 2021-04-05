#!/usr/bin/env bash

IS_UP=1
LOGIN_TIMEOUT=30
SERVER_URL="localhost"

# Starts mssql server
/opt/mssql/bin/sqlservr &

# Wait for it to be available
echo "Waiting for database engine to be available"
while [[ ${IS_UP} -ne 0 ]]; do
  /opt/mssql-tools/bin/sqlcmd -l "${LOGIN_TIMEOUT}" -U sa -P "${SA_PASSWORD}" -S "${SERVER_URL}" -h-1 -Q "SET NOCOUNT ON SELECT \"Login successfull\" , @@servername" 2>/dev/null
  IS_UP="${?}"
  sleep 5
done
echo "Database engine available"
sleep 10

echo "Creating PAB database"
/opt/mssql-tools/bin/sqlcmd -l "${LOGIN_TIMEOUT}" -U sa -P "${SA_PASSWORD}" -S "${SERVER_URL}" -V1 -h-1 -Q "CREATE DATABASE test"
/opt/mssql-tools/bin/sqlcmd -l "${LOGIN_TIMEOUT}" -U sa -P "${SA_PASSWORD}" -S "${SERVER_URL}" -V1 -h-1 -e -i "/init.sql"
echo "PAB database created"

# Keep container running
sleep infinity
