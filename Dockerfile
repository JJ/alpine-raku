FROM alpine:latest
WORKDIR /root
CMD ["sh", "-l", "-c", "perl6"]

#Basic setup
RUN apk update
RUN apk upgrade

#Add basic programs
RUN apk add git
RUN apk add perl
RUN apk add gcc
RUN apk add musl-dev
RUN apk add make
RUN apk add linux-headers

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
