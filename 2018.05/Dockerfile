FROM alpine:latest
LABEL version="2.0.4" maintainer="JJMerelo@GMail.com" perl6version="2018.05"

# Environment
ENV PATH="/root/.rakudobrew/bin:${PATH}" \
    PKGS="curl git perl" \
    PKGS_TMP="curl-dev linux-headers make gcc musl-dev wget"

# Basic setup and programs
RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \
    && git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && echo 'export PATH=~/.rakudobrew/bin:$PATH\neval "$(/root/.rakudobrew/bin/rakudobrew init -)"' >> /etc/profile \
    && rakudobrew build moar  2018.05 \
    && curl -L https://cpanmin.us | perl - App::cpanminus \
    && cpanm Test::Harness --no-wget \
    && git clone https://github.com/ugexe/zef.git \
    && prove -v -e 'perl6 -I zef/lib' zef/t \
    && perl6 -Izef/lib zef/bin/zef --verbose install ./zef \
    && rakudobrew rehash \
    && zef install Linenoise \
    && apk del $PKGS_TMP \
    && RAKUDO_VERSION=`sed "s/\n//" /root/.rakudobrew/CURRENT` \
       rm -rf /root/.rakudobrew/${RAKUDO_VERSION}/src /root/zef \
       /root/.rakudobrew/git_reference \
    # Print this as a check (really unnecessary) 
    && rakudobrew init

# Runtime    
WORKDIR /root
ENTRYPOINT ["perl6"]
