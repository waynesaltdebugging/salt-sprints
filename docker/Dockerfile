FROM centos:7 as base
RUN yum install -y epel-release gcc redhat-rpm-config curl vim ed nano lnav openssh-server
RUN yum install -y python36 python36-devel python-devel
RUN python3 -m ensurepip
RUN python3 -m pip install salt==3000
RUN curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com
RUN sh bootstrap-salt.sh -L -M -S -d -X -x python3 git v3000
WORKDIR /requirements/
RUN curl -o base.txt -L https://raw.githubusercontent.com/saltstack/salt/master/requirements/base.txt
RUN curl -o zeromq.txt -L https://raw.githubusercontent.com/saltstack/salt/master/requirements/zeromq.txt
RUN curl -o pytest.txt -L https://raw.githubusercontent.com/saltstack/salt/master/requirements/pytest.txt
RUN python3 -m pip install nox-py2==2019.6.25
RUN python3 -m pip install -r pytest.txt
RUN python3 -m pip install -U pytest-salt

ADD master /etc/salt/master
ADD minion /etc/salt/minion
ADD roster /etc/salt/roster
ADD start-services.sh /
RUN chmod +x /start-services.sh
ADD restart-services.sh /
RUN chmod +x /restart-services.sh
ADD states/ssh_user.sls /srv/salt/
ADD pillars/top.sls /srv/pillar/
ADD pillars/ssh_user.sls /srv/pillar/

RUN ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key \
 && ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key \
 && ssh-keygen -t ecdsa -N '' -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key

WORKDIR /testing/
RUN git clone -b hotfix/pytest-salt --single-branch https://github.com/saltstack/salt .
RUN nox --install-only -e "runtests-parametrized-3(coverage=False, crypto=None, transport='zeromq')"
RUN nox --install-only -e "pytest-parametrized-3(coverage=False, crypto=None, transport='zeromq')"
RUN .nox/pytest-parametrized-3-coverage-false-crypto-none-transport-zeromq/bin/python -m pip install tornado

ENV LANG=en_US.utf8

FROM base
WORKDIR /testing/
