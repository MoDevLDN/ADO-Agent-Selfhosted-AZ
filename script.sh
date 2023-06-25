#!/bin/sh

# Creates directory & download ADO agent install files

su - modev -c "
mkdir myagent && cd myagent
wget https://vstsagentpackage.azureedge.net/agent/3.220.5/vsts-agent-linux-x64-3.220.5.tar.gz
tar zxvf vsts-agent-linux-x64-3.220.5.tar.gz
"

# Unattended install

su - modev -c "
./config.sh --unattended \
  --agent \"${AZP_AGENT_NAME:-$(hostname)}\" \
  --url \"https://dev.azure.com/modev\" \
  --auth PAT \
  --token \"7dfrodawz3nrglcazl76wq\" \
  --pool \"modevstage\" \
  --replace \
  --acceptTeeEula & wait $!
"

cd /home/modev/
# Configure as a service
sudo ./svc.sh install modev

# Start svc
sudo ./svc.sh start
