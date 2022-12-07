apt-get update && apt-get install -y python2 python2-dev iptables dnsmasq uml-utilities net-tools build-essential curl && apt-get clean

mkdir build
cp switchedrelay.py limiter.py requirements.txt build/
cp docker-image-config/docker-startup.sh && mv build/docker-startup.sh start.sh && chmod +x start.sh
cp -r public build/
mkdir -p /etc/dnsmasq.d
cp docker-image-config/dnsmasq/interface docker-image-config/dnsmasq/dhcp /etc/dnsmasq.d/

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && python2 get-pip.py && rm get-pip.py
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash && rm install.sh && nvm install 18

cd build/

pip2 install -r ./requirements.txt
npm install --global http-server
iptables -I INPUT -p tcp --dport 80 -j ACCEPT; iptables -I INPUT -p tcp --dport 8080 -j ACCEPT; iptables -I INPUT -p tcp --dport 9134 -j ACCEPT
iptables -I OUTPUT -p tcp --sport 80 -j ACCEPT; iptables -I OUTPUT -p tcp --sport 8080 -j ACCEPT; iptables -I OUTPUT -p tcp --sport 9134 -j ACCEPT

echo "Setup complete! Go to build directory and run start.sh"
