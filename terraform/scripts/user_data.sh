#!/bin/bash
set -e

# Redirect output to log file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "==> Starting Healthcare Web Server Setup..."

# Update OS package repository
apt-get update -y
apt-get upgrade -y

# Install Nginx, Git, and Curl
apt-get install -y nginx git curl

# Ensure web directory exists and set permissions for deployment user
mkdir -p /var/www/html
chown -R ubuntu:www-data /var/www/html
chmod -R 775 /var/www/html

# Add ubuntu user to www-data group
usermod -a -G www-data ubuntu

# Create initial placeholder index file while waiting for GitHub Actions deploy
cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PulseCare Health | EC2 Server Ready</title>
    <style>
        body { font-family: system-ui, sans-serif; background: #0b192c; color: #fff; display: flex; height: 100vh; align-items: center; justify-content: center; text-align: center; }
        .box { background: #1e293b; padding: 2rem 3rem; border-radius: 1rem; border: 1px solid #334155; }
        h1 { color: #38bdf8; }
        .status { background: #10b981; color: #000; font-weight: bold; padding: 0.25rem 0.75rem; border-radius: 9999px; }
    </style>
</head>
<body>
    <div class="box">
        <h1>🏥 PulseCare Web Server Provisioned</h1>
        <p><span class="status">Nginx Online</span> AWS EC2 server initialized successfully.</p>
        <p>Awaiting GitHub Actions CI/CD initial code deployment...</p>
    </div>
</body>
</html>
EOF

# Ensure Nginx service is enabled and running
systemctl enable nginx
systemctl restart nginx

echo "==> Healthcare Web Server setup complete!"
