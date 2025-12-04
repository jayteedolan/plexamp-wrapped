#!/bin/bash
echo "Starting Plexamp Wrapped server..."
echo "Access at: http://$(hostname -I | awk '{print $1}'):5678"
python3 -m http.server 5678
