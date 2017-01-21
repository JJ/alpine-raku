FROM alpine:latest
MAINTAINER JJ Merelo <jjmerelo@GMail.com>
WORKDIR /root
ENTRYPOINT ["perl6"]

#Basic setup and programs
RUN apk update &&  apk upgrade \
    &&  apk add gcc git linux-headers make musl-dev perl

#Download and install rakudo
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew
RUN echo 'export PATH=~/.rakudobrew/bin:$PATH\neval "$(/root/.rakudobrew/bin/rakudobrew init -)"' >> /etc/profile
ENV PATH="/root/.rakudobrew/bin:${PATH}"

#Build moar
RUN rakudobrew build moar && rakudobrew build panda && panda install Linenoise
RUN rakudobrew init
RUN apk del gcc git linux-headers make musl-dev 

#Mount point
RUN mkdir /app
VOLUME /app
