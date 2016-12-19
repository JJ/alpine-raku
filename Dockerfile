FROM alpine:latest
MAINTAINER JJ Merelo <jjmerelo@GMail.com>
WORKDIR /root
ENTRYPOINT ["/root/.rakudobrew/bin/perl6"]

#Basic setup
RUN apk update
RUN apk upgrade

#Add basic programs
RUN apk add gcc git linux-headers make musl-dev perl

#Download and install rakudo
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew
RUN echo 'export PATH=~/.rakudobrew/bin:$PATH' >> /etc/profile
RUN echo 'eval "$(/root/.rakudobrew/bin/rakudobrew init -)"' >> /etc/profile
RUN export PATH=~/.rakudobrew/bin:$PATH && rakudobrew init

#Build moar
RUN export PATH=~/.rakudobrew/bin:$PATH && rakudobrew build moar

#Build other utilities
RUN export PATH=~/.rakudobrew/bin:$PATH && rakudobrew build panda
RUN export PATH=~/.rakudobrew/bin:$PATH && panda install Linenoise
