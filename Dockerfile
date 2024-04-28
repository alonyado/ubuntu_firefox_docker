# We are going to use the Latest version of Ubuntu
FROM  ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0
ARG DOCKER_USERNAME=testuser
ARG DOCKER_USER_UID=1001

RUN apt update && apt install -y wget

RUN useradd -m -u ${DOCKER_USER_UID} ${DOCKER_USERNAME}

# Preparing apt repository to install firefox from Mozilla and not snap
RUN install -d -m 0755 /etc/apt/keyrings && wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
#RUN /bin/bash -c "echo -e 'Types: deb\nURIs: https://packages.mozilla.org/apt\nSuites: mozilla\nComponents: main\nSigned-By: /etc/apt/keyrings/packages.mozilla.org.asc' | tee -a /etc/apt/sources.list.d/mozilla.sources > /dev/null"

RUN echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list /dev/null

RUN /bin/bash -c "echo -e '\nPackage: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n' > /etc/apt/preferences.d/mozilla"

#Install firefox + upgrade packages if needed
RUN apt update && apt install -y firefox && apt upgrade

# Starting Firefox application
USER ${DOCKER_USERNAME}
CMD  "firefox"
