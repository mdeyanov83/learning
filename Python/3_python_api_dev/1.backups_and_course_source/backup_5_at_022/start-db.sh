#!/bin/bash

echo "Starting PostgreSQL server..."

# Running the command
postgres -D ./postgres-data -k /tmp -h 0.0.0.0
