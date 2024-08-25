ARG IMAGE
FROM ${IMAGE}

RUN apt update \
    && apt upgrade -y \
    && apt-get install -y sudo \
    && apt-get install -y vim \
    && apt-get install -y git \
    && apt-get install -y gnupg \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Add User
ARG USERNAME
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && usermod -aG sudo ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/add_sudoers \
    && chmod 0440 /etc/sudoers.d/add_sudoers

