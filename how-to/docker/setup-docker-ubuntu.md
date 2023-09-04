## Setting Up Docker and Docker Compose on Ubuntu

### 1. Introduction

Docker allows developers to package applications into containers — standardized executable components that combine application source code with all the operating system (OS) libraries and dependencies required to run the code in any environment.

In this guide, we will walk you through the process of setting up Docker and Docker Compose on an Ubuntu machine.

### 2. Installing Docker

1. **Update your system**:

```bash
sudo apt update && sudo apt upgrade -y
```

2. **Install dependencies**:

```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

3. **Add Docker's GPG key**:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

4. **Add Docker's repository**:

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

5. **Install Docker**:

```bash
sudo apt update
sudo apt install docker-ce
```

6. **Add your user to the Docker group** (optional, but allows running Docker commands without `sudo`):

```bash
sudo usermod -aG docker ${USER}
```

### 3. Installing Docker Compose

1. **Download the latest version of Docker Compose**:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

2. **Apply executable permissions**:

```bash
sudo chmod +x /usr/local/bin/docker-compose
```

### 4. Testing the Installation

1. **Docker**:

```bash
docker --version
```

2. **Docker Compose**:

```bash
docker-compose --version
```

You should see the version numbers for both Docker and Docker Compose if everything has been set up correctly.

### 5. Conclusion

Now that you've installed Docker and Docker Compose, you're ready to start deploying containerized applications on your Ubuntu machine. The next step is often to familiarize yourself with basic Docker commands and best practices.
