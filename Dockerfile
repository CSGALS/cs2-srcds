FROM joedwards32/cs2:latest

LABEL maintainer="ashleigh.k.adams@gmail.com"

COPY custom_files /etc/custom_files.base
COPY pre.sh /etc/pre.sh

CMD [ "bash", "entry.sh" ]