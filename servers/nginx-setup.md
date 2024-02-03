### Setting up Nginx Web Server on Ubuntu

#### 1. **Prerequisites**:

- An Ubuntu system (version 20.04 LTS recommended).
- A non-root user with `sudo` privileges.

#### 2. **Update System Packages**:

Before installing any package, it's a good practice to update the system's package list.

```bash
sudo apt update && sudo apt upgrade -y
```

#### 3. **Install Nginx**:

Install the Nginx package using `apt`:

```bash
sudo apt install nginx -y
```

#### 4. **Adjusting the Firewall**:

If you have `ufw` (Uncomplicated Firewall) enabled, you need to adjust some settings. Allow Nginx through the firewall:

```bash
sudo ufw allow 'Nginx HTTP'
```

Verify the change with:

```bash
sudo ufw status
```

#### 5. **Starting and Enabling Nginx**:

Start the Nginx service:

```bash
sudo systemctl start nginx
```

Enable Nginx to start on boot:

```bash
sudo systemctl enable nginx
```

#### 6. **Testing the Nginx Installation**:

You can check if Nginx is running by accessing your server's IP in a browser:

```
http://your_server_ip
```

You should see the default Nginx landing page.

#### 7. **Configuring a Basic Web Page**:

Navigate to the default web directory:

```bash
cd /var/www/html
```

Create a new HTML file:

```bash
echo "<h1>Welcome to My Web Server!</h1>" | sudo tee index.html
```

Now, when you access your server's IP in a browser, you should see "Welcome to My Web Server!"

#### 8. **Best Practices**:

- Always keep your server updated.
- Consider setting up SSL for a secure connection (can use Let's Encrypt for a free certificate).
- Regularly check Nginx and server logs for any unusual activities.
