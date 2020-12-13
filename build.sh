echo -e " Installing BitCoin PPA...$COL_RESET"
if [ ! -f /etc/apt/sources.list.d/bitcoin.list ]; then
sudo add-apt-repository -y ppa:bitcoin/bitcoin
fi

mkdir -p miningcore_setup/tmp
cd miningcore_setup/tmp

echo -e "Temp Folder Created$COL_RESET"

echo -e " Installing additional system files required for daemons...$COL_RESET"
sudo apt-get update
sudo apt-get install software-properties-common build-essential libtool git autotools-dev \
automake pkg-config libssl-dev libevent-dev bsdmainutils git libboost-all-dev libminiupnpc-dev \
libqt5gui5 libqt5core5a libqt5webkit5-dev libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev \
protobuf-compiler libqrencode-dev libzmq3-dev libgmp-dev libsqlite3-dev -y

echo -e "Installing PostgreSQL v11.0$COL_RESET"

echo -e " Installing additional system files required for daemons...$COL_RESET"
sudo apt -y install vim bash-completion wget
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-11

echo -e "Installed PostgreSQL v11.0 $COL_RESET"

echo -e " Building Berkeley 4.8, this may take several minutes...$COL_RESET"
mkdir -p berkeley/db4/
cd miningcore_setup/tmp
wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz'
tar -xzvf db-4.8.30.NC.tar.gz
cd db-4.8.30.NC/build_unix/
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/berkeley/db4/
make install
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
cd miningcore_setup/tmp
sudo rm -r db-4.8.30.NC.tar.gz db-4.8.30.NC

echo -e "Berkeley 4.8 Completed...$COL_RESET"

echo -e " Building Berkeley 5.1, this may take several minutes...$COL_RESET"
mkdir -p berkeley/db5/
cd miningcore_setup/tmp
wget 'http://download.oracle.com/berkeley-db/db-5.1.29.tar.gz'
tar -xzvf db-5.1.29.tar.gz
cd db-5.1.29/build_unix/
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/berkeley/db5/
make install
cd miningcore_setup/tmp
sudo rm -r db-5.1.29.tar.gz db-5.1.29

echo -e "Berkeley 5.1 Completed...$COL_RESET"

echo -e " Building Berkeley 5.3, this may take several minutes...$COL_RESET"
mkdir -p berkeley/db5.3/
cd miningcore_setup/tmp
wget 'http://anduin.linuxfromscratch.org/BLFS/bdb/db-5.3.28.tar.gz'
tar -xzvf db-5.3.28.tar.gz
cd db-5.3.28/build_unix/
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=/berkeley/db5.3/
make install
cd miningcore_setup/tmp
sudo rm -r db-5.3.28.tar.gz db-5.3.28

echo -e "Berkeley 5.3 Completed...$COL_RESET"

echo -e " Building MiningCore, this may take several minutes...$COL_RESET"
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update -y
sudo apt-get install apt-transport-https -y
sudo apt-get update -y
sudo apt-get -y install dotnet-sdk-2.2 git cmake build-essential libssl-dev pkg-config libboost-all-dev libsodium-dev libzmq5
cd
git clone https://github.com/coinfoundry/miningcore
cd miningcore/src/Miningcore

echo -e "MiningCore Build Completed...$COL_RESET"

