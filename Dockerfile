FROM alpine:latest
WORKDIR /root
ENTRYPOINT ["perl6"]
LABEL version="2.0" maintainer="JJMerelo@GMail.com" perl6version="2018.03"

ENV PATH="/root/.rakudobrew/bin:${PATH}"

#Basic setup and programs
RUN apk update && apk upgrade \
    && apk add gcc git linux-headers make musl-dev perl wget curl-dev curl \
    && git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && echo 'export PATH=~/.rakudobrew/bin:$PATH\neval "$(/root/.rakudobrew/bin/rakudobrew init -)"' >> /etc/profile \
    && rakudobrew build moar \
    && curl -L https://cpanmin.us | perl - App::cpanminus \
    && cpanm Test::Harness --no-wget \
    && git clone https://github.com/ugexe/zef.git && prove -v -e 'perl6 -I zef/lib' zef/t && perl6 -Izef/lib zef/bin/zef --verbose install ./zef \
    && rakudobrew rehash \
    && zef install Linenoise \
    && apk del gcc linux-headers make musl-dev curl-dev wget
    
RUN version=`sed "s/\n//" /root/.rakudobrew/CURRENT` && rm -rf /root/.rakudobrew/${version}/src
RUN rm -rf /root/.rakudobrew/git_reference /root/zef

# Print this as a check (really unnecessary) 
RUN rakudobrew init
