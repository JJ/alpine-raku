FROM alpine:latest
WORKDIR /root
ENTRYPOINT ["perl6"]
LABEL version="2.0" maintainer="JJMerelo@GMail.com" perl6version="2018.01"

#Basic setup and programs
RUN apk update && apk upgrade \
    && apk add gcc git linux-headers make musl-dev perl wget curl-dev curl

#Download and install rakudo
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew
RUN echo 'export PATH=~/.rakudobrew/bin:$PATH\neval "$(/root/.rakudobrew/bin/rakudobrew init -)"' >> /etc/profile
ENV PATH="/root/.rakudobrew/bin:${PATH}"

#Build moar
RUN rakudobrew build moar 2018.01

#Build zef
RUN curl -L https://cpanmin.us | perl - App::cpanminus
RUN cpanm Test::Harness --no-wget
RUN git clone https://github.com/ugexe/zef.git && prove -v -e 'perl6 -I zef/lib' zef/t && perl6 -Izef/lib zef/bin/zef --verbose install ./zef
RUN rakudobrew rehash

#Install the rest of the stuff
RUN zef install Linenoise

#Clean up a bit
RUN apk del gcc linux-headers make musl-dev curl-dev
RUN version=`sed "s/\n//" /root/.rakudobrew/CURRENT` && rm -rf /root/.rakudobrew/${version}/src
RUN rm -rf /root/.rakudobrew/git_reference /root/zef

# Print this as a check (really unnecessary) 
RUN rakudobrew init
