#!/bin/bash
sudo apt-get -y update

sudo apt install -y net-tools
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y libmysqlclient-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs
sudo apt-get install -y tmux
sudo apt-get install -y vim
# sudo apt-get install -y openssh-server
# sudo systemctl enable ssh

# install common python3 libraries
pip3 install boto3 requests

echo "Installing bash_profile aliases from recon_profile"
cat .bash_profile >> ~/.bash_profile
source ~/.bash_profile
echo "done"

#install go
if [[ -z "$GOPATH" ]];then
echo "It looks like go is not installed, would you like to install it now"
PS3="Please select an option : "
choices=("yes" "no")
select choice in "${choices[@]}"; do
	case $choice in
		yes)

			echo "Installing Golang"
			wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz
			sudo tar -xvf go1.13.4.linux-amd64.tar.gz
			sudo mv go /usr/local
			export GOROOT=/usr/local/go
			export GOPATH=$HOME/go
			export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
			echo 'export GOROOT=/usr/local/go' >> ~/.bash_profile
			echo 'export GOPATH=$HOME/go'	>> ~/.bash_profile			
			echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bash_profile	
			source ~/.bash_profile
			sleep 1
			break
			;;
		no)
			echo "Please install go and rerun this script"
			echo "Aborting installation..."
			exit 1
			;;
	esac	
done
fi

# Setting up tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ./.tmux.conf

#Don't forget to set up AWS credentials!
echo "Don't forget to set up AWS credentials!"
apt install -y awscli

#create a tools folder in ~/
mkdir ~/tools
cd ~/tools/

#install patator
echo "Installing Patator"
git clone https://github.com/lanjelot/patator
cd patator
sudo python3 setup.py install
cd ~/tools/
echo "done"

#install aquatone
echo "Installing Aquatone"
go get github.com/michenriksen/aquatone
echo "done"

#install eyewitness
echo "Installing EyeWitness"
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
cd EyeWitness
sudo python3 setup.py install
cd ~/tools/
echo "done"

#install chromium
# echo "Installing Chromium"
# sudo snap install chromium
# echo "done"

echo "Installing JSParser"
git clone https://github.com/nahamsec/JSParser.git
cd JSParser*
sudo python setup.py install
cd ~/tools/
echo "done"

echo "Installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip install -r requirements.txt
cd ~/tools/
echo "done"

echo "Installing teh_s3_bucketeers"
git clone https://github.com/tomdev/teh_s3_bucketeers.git
cd ~/tools/
echo "done"

echo "Installing wpscan"
git clone https://github.com/wpscanteam/wpscan.git
cd wpscan*
sudo gem install bundler && bundle install --without test
cd ~/tools/
echo "done"

echo "Installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools/
echo "done"

echo "Installing lazys3"
git clone https://github.com/nahamsec/lazys3.git
cd ~/tools/
echo "done"

echo "Installing virtual host discovery"
git clone https://github.com/jobertabma/virtual-host-discovery.git
cd ~/tools/
echo "done"

echo "Installing sqlmap"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
cd ~/tools/
echo "done"

echo "Installing knock.py"
git clone https://github.com/guelfoweb/knock.git
cd ~/tools/
echo "done"

echo "Installing lazyrecon"
git clone https://github.com/nahamsec/lazyrecon.git
cd ~/tools/
echo "done"

echo "Installing nmap"
sudo apt-get install -y nmap
echo "done"

echo "Installing massdns"
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
cd ~/tools/
echo "done"

echo "Installing asnlookup"
git clone https://github.com/yassineaboukir/asnlookup.git
cd ~/tools/asnlookup
pip install -r requirements.txt
cd ~/tools/
echo "done"

echo "Installing httprobe"
go get -u github.com/tomnomnom/httprobe 
echo "done"

echo "Installing unfurl"
go get -u github.com/tomnomnom/unfurl 
echo "done"

echo "Installing waybackurls"
go get github.com/tomnomnom/waybackurls
echo "done"

echo "Installing crtndstry"
git clone https://github.com/nahamsec/crtndstry.git
echo "done"

echo "Downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo "done"

echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
ls -la
