#!/bin/bash

# Build the Docker image
docker build -t freeswitch_exporter .

# Run a temporary container based on the image
docker run -d --name temp_container freeswitch_exporter

# Copy the binary out of the container
docker cp temp_container:/freeswitch_exporter ./freeswitch_exporter

# Copy the systemd service file into the current directory (if it's available)
# Ensure you have freeswitch_exporter.service in the same folder as this script
cp ./freeswitch_exporter.service ./freeswitch_exporter.service

# Stop and remove the temporary container
docker rm -f temp_container

# Create a tar.gz archive of the freeswitch_exporter binary and the systemd service file
tar -czvf freeswitch_exporter.tar.gz freeswitch_exporter freeswitch_exporter.service

# Optional: Remove the copied binary and service file to clean up
rm ./freeswitch_exporter ./freeswitch_exporter.service

echo "freeswitch_exporter.tar.gz has been created successfully."
