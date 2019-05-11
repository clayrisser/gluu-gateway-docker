FROM ubuntu:16.04

LABEL image=codejamninja/gg-kong:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=ubuntu:16.04

RUN apt-get update && apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  sudo \
  wget
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo && \
  echo "deb https://repo.gluu.org/ubuntu/ xenial main" > /etc/apt/sources.list.d/gluu-repo.list && \
  curl https://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add - && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/psql.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get update
RUN apt-get install -y \
  unzip \
  lua-cjson \
  python-requests \
  kong-community-edition

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh

RUN chmod +x /usr/local/sbin/entrypoint.sh

USER docker

ENTRYPOINT ["sh", "-c", "/usr/local/sbin/entrypoint.sh"]
