#!/bin/bash

source ~/user.cfg.sh

# в .bashrc поместить JAVA_HOME

echo 'export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

this_is_done
