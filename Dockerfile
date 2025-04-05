FROM joedwards32/cs2:latest

LABEL maintainer="ashleigh.k.adams@gmail.com"

USER root
RUN apt-get update --fix-missing \
    && apt-get install -y --no-install-recommends sudo \
    && echo "steam ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/steam \
    && chmod 0440 /etc/sudoers.d/steam
USER ${USER}

COPY entry-override.sh "${HOMEDIR}/entry-override.sh"

COPY mods/metamod /etc/custom_files
COPY mods/serverlistplayersfix /etc/custom_files
COPY mods/counterstrikesharp /etc/custom_files

COPY pre.sh /etc/pre.sh

CMD [ "bash", "entry-override.sh" ]