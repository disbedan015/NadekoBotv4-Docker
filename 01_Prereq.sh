#!/bin/bash -e
# Install dotnet
root=$(pwd)
echo ""

function detect_OS_ARCH_VER_BITS {
    ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

    if [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
    fi

    if ! [ "$DISTRIB_ID" = "" ]; then
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    elif [ -f /etc/debian_version ]; then
        OS=Debian  # XXX or Ubuntu??
        VER=$(cat /etc/debian_version)
        SVER=$( grep -oP "[0-9]+" /etc/debian_version | head -1 )
    elif [ -f /etc/centos-release ]; then
        OS=CentOS
        VER=$( grep -oP "[0-9]+" /etc/centos-release | head -1 )
    elif [ -f /etc/fedora-release ]; then
        OS=Fedora
        VER=$( grep -oP "[0-9]+" /etc/fedora-release | head -1 )
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$NAME" = "" ]; then
          OS=$(uname -s)
          VER=$(uname -r)
        else
          OS=$NAME
          VER=$VERSION_ID
        fi
    else
        OS=$(uname -s)
        VER=$(uname -r)
    fi
    case $(uname -m) in
    x86_64)
        BITS=64
        ;;
    i*86)
        BITS=32
        ;;
    armv*)
        BITS=32
        ;;
    *)
        BITS=?
        ;;
    esac
    case $(uname -m) in
    x86_64)
        ARCH=x64  # or AMD64 or Intel64 or whatever
        ;;
    i*86)
        ARCH=x86  # or IA32 or Intel32 or whatever
        ;;
    *)
        # leave ARCH as-is
        ;;
    esac
}

declare OS ARCH VER BITS

detect_OS_ARCH_VER_BITS

export OS ARCH VER BITS

if [ "$BITS" = 32 ]; then
    echo -e "Your system architecture is $ARCH which is unsupported to run Microsoft .NET Core SDK. \nYour OS: $OS \nOS Version: $VER"
    echo
    printf "\e[1;31mPlease check the NadekoBot self-hosting guide for alternatives.\e[0m\n"
    rm n-prereq.sh
    exit 1
fi

if [ "$OS" = "Ubuntu" ]; then
    supported_ver=("16.04" "18.04" "20.04" "21.04" "21.10" "22.04")

    if [[ "${supported_ver[*]}" =~ ${VER} ]]; then
        supported=1
    else
        supported=0
    fi
fi

if [ "$OS" = "LinuxMint" ]; then
    SVER=$( echo $VER | grep -oP "[0-9]+" | head -1 )
    supported_ver=("19" "20")

    if [[ "${supported_ver[*]}" =~ ${SVER} ]]; then
        supported=1
    else
        supported=0
    fi
fi

if [ "$supported" = 0 ]; then
    echo -e "Your OS $OS $VER $ARCH looks unsupported to run Microsoft .NET Core. \nExiting..."
    printf "\e[1;31mContact NadekoBot's support on Discord with screenshot.\e[0m\n"
    rm n-prereq.sh
    exit 1
fi

if [ "$OS" = "Linux" ]; then
    echo -e "Your OS $OS $VER $ARCH probably can run Microsoft .NET Core. \nContact NadekoBot's support on Discord with screenshot."
    rm n-prereq.sh
    exit 1
fi

echo "This installer will download all of the required packages for NadekoBot. It will use about 350MB of space. This might take awhile to download if you do not have a good internet connection.\n"
echo -e "Would you like to continue? \nYour OS: $OS \nOS Version: $VER \nArchitecture: $ARCH"

while true; do
    read -p "[y/n]: " yn
    case $yn in
        [Yy]* ) clear; echo Running NadekoBot Auto-Installer; sleep 2; break;;
        [Nn]* ) echo Quitting...; rm n-prereq.sh && exit;;
        * ) echo "Couldn't get that please type [y] for Yes or [n] for No.";;
    esac
done

echo ""

if [ "$OS" = "Ubuntu" ]; then
    if [ "$VER" = "21.04" ]; then
        echo -e "*Ubuntu 21.04 has reached an End Of Life (EOL) on January 20, 2022. For more information, see the official Ubuntu EOL page. For now, .NET 6 will be supported but it is advised you upgrade to another version."
    fi
    echo "Installing dotnet"
    wget "https://packages.microsoft.com/config/ubuntu/$VER/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb

    sudo apt-get update;
    sudo apt-get install -y apt-transport-https && sudo apt-get update;
    sudo apt-get install -y dotnet-sdk-6.0;

    echo "Installing Git, Redis and Tmux..."
    sudo apt-get install git tmux redis-server -y

    echo "Installing music prerequisites..."
    sudo apt-get install libopus0 opus-tools libopus-dev libsodium-dev -y
    sudo apt install python
    echo ""
    sudo apt-get install ffmpeg
    sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
elif [ "$OS" = "Debian" ]; then
    if [[ "$SVER" == "9" ]]; then
        echo "Support for Debian 9 has reached End of Life (EOL) as of August 9, 2022"
        echo "Please upgrade to Debian 10 or newer"
        rm n-prereq.sh
        exit 1
    elif [[ "$SVER" == "10" ]]; then
        su -
        apt-get install sudo -y
        wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb
    elif [[ "$SVER" == "11" ]]; then
        wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        sudo dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb
    fi

    echo "Installing dotnet"
    sudo apt-get update; \
      sudo apt-get install -y apt-transport-https && \
      sudo apt-get update && \
      sudo apt-get install -y dotnet-sdk-6.0

    echo "Installing Git, Redis and Tmux..."
    sudo apt-get install git tmux redis-server -y

    echo "Installing music prerequisites..."
    sudo apt-get install libopus0 opus-tools libopus-dev libsodium-dev -y
    sudo apt-get install ffmpeg
    echo ""
    sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
elif [ "$OS" = "Fedora" ]; then
    sudo dnf -y install dotnet-sdk-6.0
    sudo dnf -y install git

    sudo dnf -y install redis
    sudo systemctl enable --now redis

    sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y install ffmpeg
    sudo dnf -y install opus-tools opus libsodium
    sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
elif [ "$OS" = "openSUSE Leap" ] || [ "$OS" = "openSUSE Tumbleweed" ]; then
    echo -e "Installing dotnet..."
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    wget https://packages.microsoft.com/config/opensuse/15/prod.repo
    sudo mv prod.repo /etc/zypp/repos.d/microsoft-prod.repo
    sudo chown root:root /etc/zypp/repos.d/microsoft-prod.repo
    sudo zypper install -y dotnet-sdk-6.0

    echo -e "\nInstalling git, tmux..."
    sudo zypper install -y git tmux

    echo "Installing redis..."
    sudo zypper install -y redis
    # Instructions here: https://build.opensuse.org/package/view_file/openSUSE:Factory/redis/README.SUSE?expand=1
    sudo cp -a /etc/redis/default.conf.example /etc/redis/nadeko.conf
    sudo sudo install -d -o redis -g redis -m 0750 /var/lib/redis/nadeko/
    sudo systemctl start redis@nadeko
    sudo systemctl enable redis@nadeko

    echo -e "\nInstalling music prerequisites..."
    if [ "$OS" = "openSUSE Leap" ]; then
      sudo zypper ar -G -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_$releasever/' packman
    else
      sudo zypper ar -G -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
    fi
    sudo zypper install -y libicu ffmpeg libopus0 libopus-devel opus-tools youtube-dl

elif [ "$OS" = "CentOS" ]; then
    if [ "$VER" = "7" ]; then
        echo ""
        yum -y install sudo
        sudo yum -y install libunwind libicu
        sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm
        sudo yum -y install dotnet-sdk-6.0.x86_64
        sudo yum -y install http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm epel-release
        sudo yum -y install \
        https://repo.ius.io/ius-release-el7.rpm \
        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        sudo yum -y localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
        sudo yum -y install git222 opus opus-devel ffmpeg ffmpeg-devel tmux yum-utils ca-certificates wget
        sudo yum -y install redis
        sudo systemctl start redis
        sudo systemctl enable redis
        sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
        sudo chmod a+rx /usr/local/bin/youtube-dl
    elif [ "$VER" = "8" ]; then
        echo -e "*CentOS 8 has reached an End Of Life (EOL) on December 31st, 2021. For more information, see the official CentOS Linux EOL page. Because of this, .NET 6 won't be supported on CentOS Linux 8."
        rm n-prereq.sh
        exit 1
    else
        echo -e "Your OS $OS $VER $ARCH probably can run Microsoft .NET Core. \nContact NadekoBot's support on Discord with screenshot."
        rm n-prereq.sh
        exit 1
    fi
elif [ "$OS" = "LinuxMint" ]; then
        echo "Installing Git, Redis and Tmux..."
        sudo apt-get install git tmux redis-server -y

        echo "Installing dotnet..."
        if [ "$SVER" = "19" ]; then
          wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        elif [ "$SVER" = "20" ]; then
            wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        elif [ "$SVER" = "21" ]; then
            wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
        fi

        sudo dpkg -i packages-microsoft-prod.deb
        rm packages-microsoft-prod.deb
        sudo apt-get update;
        sudo apt-get install -y apt-transport-https && sudo apt-get update;
        sudo apt-get install -y dotnet-sdk-6.0;

        echo "Installing music prerequisites..."
        sudo apt-get update
        sudo apt-get install libopus0 opus-tools libopus-dev libsodium-dev ffmpeg -y
        sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
        sudo chmod a+rx /usr/local/bin/youtube-dl
elif [ "$OS" = "Darwin" ]; then
    brew update
    brew install wget git ffmpeg openssl opus opus-tools opusfile libffi libsodium tmux python youtube-dl redis
    brew services start redis

    brew install mono-libgdiplus
fi

echo
echo "NadekoBot Prerequisites Installation completed..."
read -n 1 -s -p "Press any key to continue..."
sleep 2

cd "$root"
rm "$root/n-prereq.sh"
exit 0
