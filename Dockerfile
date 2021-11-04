FROM registry.access.redhat.com/ubi8/ubi-minimal

USER root

ENV TMPDIR /tmp

RUN mkdir -p ${HOME} &&\
    chown 1001:0 ${HOME} &&\
    chmod ug+rwx ${HOME}

RUN microdnf update -y && \
    microdnf install -y \
      bash \
      tar \
      gzip \
      openssl \
    && microdnf clean all && \
    rm -rf /var/cache/yum

COPY delconfigmap.yaml $TMPDIR
COPY deleteandwait.sh $TMPDIR

ADD https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz $TMPDIR/
RUN tar -C /usr/local/bin -xvf $TMPDIR/oc.tar.gz && \
    chmod +x /usr/local/bin/oc && \
    rm $TMPDIR/oc.tar.gz

CMD $TMPDIR/deleteandwait.sh

USER 1001