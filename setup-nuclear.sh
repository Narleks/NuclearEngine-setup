#!/bin/bash
echo "\033[32mPhase 0: \033[33mChecking\033[m";
if ! which docker >> /dev/null; then
    echo -n "\033[31mCheck failed: docker not found. \033[32mMay be install Docker? (y/n) \033[m"
	read item
	case "$item" in
    y|Y) 
		 apt-get remove docker docker-engine docker.io containerd runc -y >> /dev/null
		 apt-get update >> /dev/null
		 apt-get install \
			apt-transport-https \
			ca-certificates \
			curl \
			gnupg-agent \
			software-properties-common -y >> /dev/null
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - >> /dev/null
		add-apt-repository \
			"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
			$(lsb_release -cs) \ 
			stable" >> /dev/null
		apt-get update >> /dev/null
		apt-get install docker-ce docker-ce-cli containerd.io
        ;;
    *) exit 1
        ;;
	esac
fi

if ! which docker-compose >> /dev/null; then
    echo -n "\033[31mCheck failed: docker-compose not found. \033[32mMay be install Docker Compose? (y/n) \033[m"
	read item
	case "$item" in
    y|Y) 
		 apt-get update >> /dev/null
		 curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
		 chmod +x /usr/local/bin/docker-compose
        ;;
    *) exit 1
        ;;
	esac
fi
echo "\033[32mPhase 1: \033[33mClone NuclearEngine Docker repository\033[m";
git clone https://github.com/Narleks/NarleksEngine-docker.git ./nuclear;
cd ./nuclear;
ln -s ./public ./app/public;
echo "\033[32mPhase 1: \033[33mInstall NuclearEngine Docker\033[m";
docker-compose build;
echo docker-compose up -d >> start.sh;
echo "\033[32mPhase 1: \033[33mClone NuclearEngine repository\033[m";

