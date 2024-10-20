# wget https://mirror.de.leaseweb.net/ubuntu-releases/24.04.1/ubuntu-24.04.1-desktop-amd64.iso
# Install VM

sudo apt install -y pcscd libpcsclite-dev help2man libtool pkg-config build-essential git 

# debian/ubuntu vsmartcard package (https://salsa.debian.org/philou/vsmartcard) is outdated
# use upstream
# 
git clone https://github.com/frankmorgner/vsmartcard
cd vsmartcard/virtualsmartcard/
 
aclocal
autoreconf -i
./configure
make
sudo make install

sudo systemctl stop pcscd.socket 
sudo systemctl stop pcscd
#sudo journalctl -f -u pcscd

sudo pcscd -f -d 
# should say: "Attempting startup of Virtual PCD"

sudo ss -tlnp | grep pcscd
# Should list two ports


wget 'https://eszemelyi.hu/wp-content/uploads/2023/05/eSzemelyi_Kliens_x64_1_7_3.deb'
sudo apt install ./eSzemelyi_Kliens_x64_1_7_3.deb

/usr/lib/ESZEMELYI/eszig-cmu
