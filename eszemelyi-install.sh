# wget https://mirror.de.leaseweb.net/ubuntu-releases/24.04.1/ubuntu-24.04.1-desktop-amd64.iso
# Install VM

wget 'https://eszemelyi.hu/wp-content/uploads/2023/05/eSzemelyi_Kliens_x64_1_7_3.deb'
sudo apt install ./eSzemelyi_Kliens_x64_1_7_3.deb

# Apply libnfc workarounds from 
# https://github.com/nfc-tools/libnfc/issues/666#issuecomment-2061370787
# and
# https://github.com/nfc-tools/libnfc/issues/684#issuecomment-1632260381
LD_PRELOAD=/usr/local/lib/libnfc.so.5 nfc-list

/usr/lib/ESZEMELYI/eszig-cmu
