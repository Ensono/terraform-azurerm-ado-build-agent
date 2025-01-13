#!/bin/sh

# Define variables to be used in the script, which are patched by Terraform
ado_agent_pool=${ado_agent_pool}
ado_org_url=${ado_org_url}
ado_pat_token=${ado_pat}
ado_project_id=${ado_project_id}
ado_agent_version="4.248.0"

###########################################
# Install Azure DevOps Agent
###########################################

echo "Installing Azuure DevOps Agent"

mkdir /agent 

echo "\tDownload"

curl -L https://vstsagentpackage.azureedge.net/agent/$ado_agent_version/vsts-agent-linux-x64-$ado_agent_version.tar.gz -o /tmp/agent.tar.gz

echo "\tUnpack"

tar zxf /tmp/agent.tar.gz -C /agent
rm -f /tmp/agent.tar.gz

chmod -R 777 /agent

echo "\tConfigure"

# The configuration script for the agent must be executed under a non-root user
cat << EOF > /tmp/setup_agent.sh
/agent/config.sh --unattended  --url $ado_org_url --auth pat --token $ado_pat_token --pool $ado_agent_pool
EOF

chmod +x /tmp/setup_agent.sh
su -c /tmp/setup_agent.sh adminuser

echo "\tInstall and run service"

# Now install and run the service, which must be run as root
# Service install must be run from the agent root
cd /agent
/agent/svc.sh install adminuser
/agent/svc.sh start
cd -

###########################################
# Install PowerShell
###########################################

echo "\n\n\nInstalling PowerShell"

# Install pre-requisite packages.
apt-get install -y wget apt-transport-https software-properties-common ca-certificates curl gnupg build-essential unzip

# Download the Microsoft repository GPG keys
curl -L "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb" -o powershell.deb

# Register the Microsoft repository GPG keys
dpkg -i powershell.deb

# Delete the the Microsoft repository GPG keys file
rm powershell.deb

# Update the list of packages
apt-get update

# Install PowerShell
apt-get install -y powershell

###########################################
# Install Docker
###########################################

# Update the system and install Docker
# https://docs.docker.com/engine/install/ubuntu/

echo "\n\n\nInstalling Docker"

# Add Docker's official GPG key
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

exit 0