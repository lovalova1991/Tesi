#!/bin/sh

PATH=$PATH:`pwd`
echo ""
echo "################################"
echo "Welcome in Prolog Compare Setup!"
echo "################################"
echo ""
if which python3 > /dev/null 2>&1;
then
    #Python3.5 is installed
    python_version=`python3 --version 2>&1 | awk '{print $2}'`
    echo "Python version $python_version....[OK]"

else
    #Python3.5 is not installed
    echo "No Python3 executable is found. I'll Install Python 3."
    echo "Install build dependencies for Python 3.."
    sudo apt-get install build-essential checkinstall
    sudo apt-get install libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
    echo "Dependecies done!"
    
    echo "I'll download Python in your Downloads folder.."
    cd ~/Downloads 
    wget https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz
    tar -xvf Python-3.5.0.tgz
    cd Python-3.5.0
    
    echo "Downloaded. Installing.."
    
    ./configure
    sudo make install
    if which python3.5 > /dev/null 2>&1;
    then
        #Python3.5 is installed
        python_version=`python3 --version 2>&1 | awk '{print $2}'`
        echo "Python version $python_version is installed."
    else
        echo "There's something wrong in your Python installation. Now Exiting..."
        exit 1
    fi
    cd ..
    rm -rf Python-3.5.0
fi

if (pip3 list) > 0;
then
    echo "PiP3....................[OK]"
else
    echo "PiP3 not installed, installing now..."
    sudo apt install python3-pip
    pip3 install --upgrade pip
    if pip3 list;
    then    
        echo "Pip3 now installed."
    else
        echo "There was some problem installing PiP3. Exiting."
        exit 2
    fi
fi

echo ""
echo "Resolving Dependecies for Prolog Compare..."
echo ""

if (pip3 list | grep setuptools) > 0;
then    
    echo "setuptools....[OK]"
else
    echo "setuptools is required. Installing.."
    pip3 install setuptools
    if pip3 list | grep setuptools;
    then
        echo "setuptools now installed."
    else
        echo "There was some problem installing setuptools. Exiting."
        exit 3
    fi
fi


if (pip3 list | grep openpyxl) > 0;
then
    echo "openpyxl......[OK]"
else
    echo "openpyxl is required. Installing.."
    sudo pip3 install openpyxl
    if pip3 list | grep openpyxl;
    then
        echo "openpyxl now installed."
    else
        echo "There was some problem installing openpyxl. Exiting"
        exit 4
    fi
fi


if (pip3 list | grep PyQt5) > 0;
then    
    echo "PyQt5.........[OK]"
else
    pip3 install pyqt5
    if pip3 list | grep PyQt5;
    then
        echo "PyQt5 is now installed"
    else
        echo "There's something wrong in resolving this dependency. Exiting.."
        exit 5
    fi
fi
echo ""
echo "###############################################"
echo "Downloading Lastest Version of Prolog Compare.."
echo "###############################################"
echo ""
echo "This could take long, don't worry.."
echo ""
if wget -q https://github.com/lovalova1991/tesiv3/archive/master.zip;
then
    echo "Download complete!"
    unzip -q master.zip
    cd tesiv3-master
    toexport=`pwd`
    export PYTHONPATH=$PYTHONPATH:toexport
    echo "Starting...."
    python3 GUI/UI.py
    cd ..
    rm -rf master.zip
    rm -rf tesiv3-master
    rm -rf 0
    echo ""
    echo "Thank You for using me! Bye Bye!"
    echo ""
else
    echo "Error opening file."
    exit 6
fi
