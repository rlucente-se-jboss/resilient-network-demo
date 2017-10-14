########################################################################
#                        AMQ Interconnect Router                       #
########################################################################

FROM registry.access.redhat.com/rhel7

MAINTAINER Rich Lucente <rlucente@redhat.com>

LABEL vendor="Red Hat"
LABEL version="0.1"
LABEL description="AMQ Interconnect Router"

ENV QDROUTER_CONF /etc/qpid-dispatch/qdrouterd.conf

RUN    yum repolist --disablerepo=* \
    && yum-config-manager --disable \* > /dev/null \
    && yum-config-manager --enable rhel-7-server-rpms \
    && yum -y update \
    && yum -y install \
           --enablerepo=amq-interconnect-1-for-rhel-7-server-rpms \
           --enablerepo=a-mq-clients-1-for-rhel-7-server-rpms \
           qpid-dispatch-router \
           qpid-dispatch-tools \
           python-qpid-proton \
           git \
    && yum -y clean all \
    && cd /usr/share \
    && git clone https://github.com/apache/qpid-proton.git

VOLUME /etc/qpid-dispatch

USER 1000

EXPOSE 5000 6000 8080

CMD /usr/sbin/qdrouterd --config=${QDROUTER_CONF}

