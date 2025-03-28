#!/bin/sh

# Define variables to be used in the script, which are patched by Terraform
ado_agent_pool=${ado_agent_pool}
ado_org_url=${ado_org_url}
ado_pat_token=${ado_pat}
ado_project_id=${ado_project_id}
ado_agent_version="4.248.0"
ado_agent_user="adminuser"

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

# Assign the agent user to the Docker group
# Ensure the docker group exists
if grep -q docker /etc/group
then
  echo "Docker group already exists"
else
  groupadd docker
fi

# Ensure the adminuser is part of the group
usermod -aG docker $ado_agent_user

###########################################
# Install Azure DevOps Agent
###########################################

echo "Installing Azuure DevOps Agent"

mkdir /agent 

echo "\tDownload"

curl -L https://vstsagentpackage.azureedge.net/agent/$ado_agent_version/vsts-agent-linux-x64-$ado_agent_version.tar.gz -o /tmp/agent.tar.gz

echo "\tUnpack"

tar zxf /tmp/agent.tar.gz -C /agent

chmod -R 777 /agent

echo "\tConfigure"

# The configuration script for the agent must be executed under a non-root user
cat << EOF > /tmp/setup_agent.sh
/agent/config.sh --unattended  --url $ado_org_url --auth pat --token $ado_pat_token --pool $ado_agent_pool
EOF

chmod +x /tmp/setup_agent.sh
su -c /tmp/setup_agent.sh $ado_agent_user

echo "\tInstall and run service"

# Now install and run the service, which must be run as root
# Service install must be run from the agent root
cd /agent
/agent/svc.sh install $ado_agent_user
/agent/svc.sh start
cd -

exit 0