FROM jenkins/jenkins
LABEL description="Container to build custom jenkin server"
MAINTAINER Mamun Ahmed (maamun7@gmail.com)
USER root

# copy run file
COPY ["run.sh", "/"]

# update and install all necessary packages
RUN apt-get update -yq \
   && apt-get install sudo \
   && apt-get install curl gnupg -yq

# add repository & install nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
   && apt-get install nodejs -yq

# add repository & install docker
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-17.03.2-ce.tgz && tar --strip-components=1 -xvzf docker-17.03.2-ce.tgz -C /usr/local/bin \
   && chmod +x ./run.sh

# add repository & install docker-compose
RUN curl -L --fail https://github.com/docker/compose/releases/download/1.21.2/run.sh -o /usr/local/bin/docker-compose \
   && chmod +x /usr/local/bin/docker-compose

# clean
RUN apt-get clean -y

#Adding jenkins to sudoers list and making an alias for sudo docker
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers \
      && printf '#!/bin/bash\nsudo /usr/bin/docker "$@"' > /usr/local/bin/docker \
      && chmod +x /usr/local/bin/docker

# Run Jenkins as dedicated non-root user
USER jenkins

ENTRYPOINT ["/bin/bash","-c","./run.sh"]
