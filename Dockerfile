# Instructions casually stolen from http://wiki.gridcoin.us/Linux_guide
# Specifically, the build instructions for the gridcoin research client for Ubuntu.

FROM ubuntu
MAINTAINER Vishakh Kumar <vishakhpradeepkumar@gmail.com>

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -y update 

# Installing Dependencies 
RUN apt-get -y install ntp \
                       git \
                       build-essential \
                       libssl-dev \
                       libdb-dev \
                       libdb++-dev \
                       libqrencode-dev \
                       libcurl4-openssl-dev \
                       curl \
                       libzip-dev \
                       libzip4 \
                       libboost-atomic-dev \
                       libboost-chrono-dev \
                       libboost-date-time-dev \
                       libboost-filesystem-dev \
                       libboost-program-options-dev \
                       libboost-serialization-dev \
                       libboost-system-dev \
                       libboost-thread-dev \
                       wget

# Dependencies
RUN apt-get -y update                \
    && apt-get -y install ntp git build-essential libssl-dev libdb-dev libdb++-dev libboost-all-dev libqrencode-dev \
    && apt-get -y install qt-sdk qt4-default \
    && apt-get -y install libcurl3-dev \
    && apt-get -y install libzip-dev
    

# Build Gridcoin Daemon
# We'll be cloning from the github repo and following directions from there.
# Just to be explicit, the directions were found at Gridcoin-Research/doc/build-unix.txt
RUN cd ~ \
    && git clone https://github.com/gridcoin/Gridcoin-Research \
    && cd ~/Gridcoin-Research/src \
    && mkdir obj \
    && chmod 755 leveldb/build_detect_platform  \
    && make -f makefile.unix USE_UPNP=-  \
    && strip gridcoinresearchd \ 
    && install -m 755 gridcoinresearchd /usr/bin/gridcoinresearchd \
	&& mkdir ~/.GridcoinResearch \
	&& cd ~/.GridcoinResearch 

RUN echo 'addnode=node.gridcoin.us\nserver=1  \n\                              
rpcuser=grokkingStuff           \n\    
rpcpassword=2YoXwdv9bkxM3kcS9S4KK3C9ngopEzM1DVe9PEuaxVPc      \n'\
>> ~/.GridcoinResearch/gridcoinresearch.conf 


#RUN echo 'addnode=node.gridcoin.us\nserver=1                       
#daemon=1                       
#rpcport=9332                   
#rpcallowip=127.0.0.1            
#rpcuser=grokkingStuff               
#rpcpassword=2YoXwdv9bkxM3kcS9S4KK3C9ngopEzM1DVe9PEuaxVPc      
#rpcallowip=external IP         
##rpcssl=1'\
#>> gridcoinresearch.conf 

CMD ["gridcoinresearchd"]
