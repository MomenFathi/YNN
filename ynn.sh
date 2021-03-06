#!/bin/sh
#Banner
/usr/bin/clear
cat << "BANNER"
         Script to pass all your traffic through Tor

	
	           <-. (`-')_ <-. (`-')_ 
	     .->      \( OO) )   \( OO) )
	 ,--.'  ,-.,--./ ,--/ ,--./ ,--/ 
	(`-')'.'  /|   \ |  | |   \ |  | 
	(OO \    / |  . '|  |)|  . '|  |)
	 |  /   /) |  |\    | |  |\    | 
	 `-/   /`  |  | \   | |  | \   | 
	   `--'    `--'  `--' `--'  `--' 
		By : Mr.Kara
BANNER
echo ""
echo ""
echo "[!]Updating the repositories && Downloading requirements"
sudo apt-get update
sleep 2
sudo apt-get install tor && sudo apt-get install privoxy
sleep 3
echo ""
echo "[+]All requirements have been downloaded."
echo ""
sleep 3
echo "[!]Adding the forwarding lines to Privoxy config file"
string1="localhost:9050"
serchs="/etc/privoxy/config"
if grep -q $string1 $serchs;then
        echo "[|]The lines already there :3."
else
        echo "forward-socks5 / localhost:9050 ." >> /etc/privoxy/config
        echo "forward-socks4 / localhost:9050 ." >> /etc/privoxy/config
        echo "forward-socks4a / localhost:9050 ." >> /etc/privoxy/config
	echo "forward-socks5 / 127.0.0.1:9050 ." >> /etc/privoxy/config
        echo "forward-socks4 / 127.0.0.1:9050 ." >> /etc/privoxy/config
        echo "forward-socks4a / 127.0.0.1:9050 ." >> /etc/privoxy/config
	sleep 3
	echo "[+]The lines have been added"
fi
echo ""
sleep 3
echo ""
echo ""
sleep 3
echo "[!]Configuring the proxy"
sleep 3
echo '[!]Adding the export lines to bash.bashrc file'
sleep 3
string2="http://localhost:8118"
serchs1="/etc/bash.bashrc"
if grep -q $string2 $serchs1;then
        echo "The lines already there :3."
else
        echo 'export http_proxy="http://localhost:8118"' >> /etc/bash.bashrc 
        echo 'export https_proxy="http://localhost:8118"' >> /etc/bash.bashrc
        echo 'export socks_proxy="http://localhost:9050"' >> /etc/bash.bashrc

fi
sleep 3
echo '[!]Adding the export lines to profile file'
sleep 3
string3="http://localhost:8118"
serchs2="/etc/profile"
if grep -q $string3 $serchs2;then
        echo "The lines already there :3."
else
        echo 'export http_proxy="http://localhost:8118"' >> /etc/profile
        echo 'export https_proxy="http://localhost:8118"' >> /etc/profile
        echo 'export socks_proxy="http://localhost:9050"' >> /etc/profile

fi
sleep 3
echo '[!] Changing gnome proxy settings'
gsettings set org.gnome.system.proxy.http host '127.0.0.1'
gsettings set org.gnome.system.proxy.http port 8118
gsettings set org.gnome.system.proxy.https host '127.0.0.1'
gsettings set org.gnome.system.proxy.https port 8118
gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
gsettings set org.gnome.system.proxy.socks port 9050
gsettings set org.gnome.system.proxy mode 'manual'
sleep 3
echo ""
echo ""
echo "[+]The proxy have been configured"
echo ""
sleep 3
echo "[!]Starting services"
service privoxy start && service tor start
sleep 3
echo ""
echo "[+]Services have been started"
echo ""
sleep 3
check_s() {
string4="privoxy"
serchs3="/root/.bashrc"
if grep -q $string4 $serchs3;then
        echo "The lines already there :3."
else
        echo -e "alias ynn='service tor start && service privoxy start'" >> /root/.bashrc
fi
}
while true;do
        read -p "[?] Do you want to add the ynn command to start the services with it?" yn
        case $yn in
                [Yy]* ) check_s; break;;
                [Nn]* ) break;;
                * ) echo "Please choose yes or no";;
        esac
done
sleep 10
/usr/bin/clear
echo "[!]Testing the connection and showing your new ip"
echo ""
sleep 3
xterm -hold -e 'ipnt=$(curl ident.me) && echo "Your Ip Is $ipnt"'
echo ""
echo ""
echo ""
echo "Type ynn in the terminal to start the services"
echo "Thanks for using the script , Good Luck!"
echo ""
sleep 5
/usr/bin/clear
