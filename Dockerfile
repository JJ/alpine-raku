FROM alpine:latest
WORKDIR /root
ENTRYPOINT ["perl6"]
LABEL version="2.0" maintainer="JJMerelo@GMail.com" perl6version="2017.11"

#Basic setup and programs
RUN apk update && apk upgrade \
    && apk add gcc git linux-headers make musl-dev perl wget curl-dev openssl-dev

#Download and install rakudo
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew
RUN echo 'export PATH=~/.rakudobrew/bin:$PATH\neval "$(/root/.rakudobrew/bin/rakudobrew init -)"' >> /etc/profile
ENV PATH="/root/.rakudobrew/bin:${PATH}"

#Build moar, zef and line utilities and erase everything
RUN rakudobrew build moar
RUN git clone https://github.com/ugexe/zef.git && cd zef && perl6 -Ilib bin/zef --verbose --force-test install .
RUN rakudobrew rehash
RUN zef install --force-test Linenoise
RUN apk del gcc linux-headers make musl-dev curl-dev
RUN version=`sed "s/\n//" /root/.rakudobrew/CURRENT` && rm -rf /root/.rakudobrew/${version}/src
RUN rm -rf /root/.rakudobrew/git_reference /root/zef
RUN rakudobrew init
