FROM joedwards32/cs2:latest

LABEL maintainer="ashleigh.k.adams@gmail.com"

USER root
VOLUME ${STEAMAPPDIR}
USER ${USER}

COPY entry-override.sh "${HOMEDIR}/entry-override.sh"

COPY custom_files /etc/custom_files.base
COPY pre.sh /etc/pre.sh

CMD [ "bash", "entry-override.sh" ]