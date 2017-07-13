# Instructions casually stolen from http://www.gridcoin.us/Guides/gridcoin-install.htm.
# Specifically, the build instructions for the gridcoin research client for Ubuntu.

FROM ubuntu
MAINTAINER Vishakh Kumar <vishakhpradeepkumar@gmail.com>



RUN sudo add-apt-repository ppa:gridcoin/gridcoin-stable \
    && sudo apt-get update \
    && sudo apt-get install gridcoinresearchd

CMD [gridcoinresearchd]
