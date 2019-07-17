FROM debian:9 as base
RUN apt-get update && apt-get install -y build-essential curl vim ed nano lnav openssh-server
RUN apt-get install -y python3 python3-dev
RUN curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
RUN python3.5 /tmp/get-pip.py
RUN curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com
RUN sh bootstrap-salt.sh -L -M -S -d -X -x python3.5 git 2019.2
WORKDIR /requirements/
RUN curl -o tests.txt -L https://raw.githubusercontent.com/saltstack/salt/develop/requirements/tests.txt
RUN curl -o base.txt -L https://raw.githubusercontent.com/saltstack/salt/develop/requirements/base.txt
RUN curl -o zeromq.txt -L https://raw.githubusercontent.com/saltstack/salt/develop/requirements/zeromq.txt
RUN curl -o dev.txt -L https://raw.githubusercontent.com/saltstack/salt/develop/requirements/dev.txt
RUN curl -o pytest.txt -L https://raw.githubusercontent.com/saltstack/salt/develop/requirements/pytest.txt
RUN python3.5 -m pip install -r tests.txt

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

FROM base
WORKDIR /srv/salt
