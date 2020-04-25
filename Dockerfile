FROM fedora

MAINTAINER green@moxielogic.com

RUN yum -y install git curl jq

COPY ./moxie-nightly.sh /usr/bin/moxie-nightly.sh
RUN chmod go+x /usr/bin/moxie-nightly.sh

