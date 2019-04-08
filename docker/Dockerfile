FROM centos:7 as base
RUN yum install -y epel-release gcc redhat-rpm-config curl vim ed nano lnav openssh-server
RUN yum install -y python36 python36-devel
RUN python36 -m ensurepip
RUN python36 -m pip install salt==2019.2
RUN curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com
RUN sh bootstrap-salt.sh -L -M -S -d -X -x python36 git 2019.2

ADD master /etc/salt/master
ADD minion /etc/salt/minion
ADD roster /etc/salt/roster
ADD start-services.sh /
RUN chmod +x /start-services.sh
ADD states/ssh_user.sls /srv/salt/
ADD pillars/top.sls /srv/pillar/
ADD pillars/ssh_user.sls /srv/pillar/

RUN ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key \
 && ssh-keygen -t ecdsa -N '' -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key

FROM base
WORKDIR /srv/salt
