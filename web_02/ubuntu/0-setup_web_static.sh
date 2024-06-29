#!/usr/bin/env bash
# A bash script that sets up your web servers for the deployment of web_static

# Install Nginx if it is not already installed
if ! command -v nginx &> /dev/null; then
	    sudo apt-get update
	        sudo apt-get install nginx -y
fi

# Create necessary directories
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared

# Create fake HTML file
sudo touch /data/web_static/releases/test/index.html
echo "<html><head><title>Test Page</title></head><body>A test page.</body></html>" | sudo tee /data/web_static/releases/test/index.html > /dev/null

# Create symbolic link
sudo ln -sf /data/web_static/releases/test /data/web_static/current

# Set ownership of /data/ directory recursively
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
sudo sed -i '/^\s*location \/hbnb_static {/a \\talias /data/web_static/current/;' /etc/nginx/sites-available/default

# Restart Nginx
sudo service nginx restart

exit 0
