FROM alpine:latest

# Environment
ARG VER="2018.06"
LABEL version="2.3" maintainer="JJMerelo@GMail.com" perl6version=$VER

ENV PATH="/root/.rakudobrew/versions/moar-${VER}/install/bin:/root/.rakudobrew/versions/moar-${VER}/install/share/perl6/site/bin:${PATH}" \
    PKGS="curl git perl" \
    PKGS_TMP="curl-dev linux-headers make gcc musl-dev wget"

# Basic setup, programs and init
RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \
    && git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && echo 'eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"' >> ~/.profile \
    && eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"\
    && rakudobrew build moar $VER \
    && rakudobrew global moar-$VER \
    && curl -L https://cpanmin.us | perl - App::cpanminus \
    && cpanm Test::Harness --no-wget \
    && git clone https://github.com/ugexe/zef.git \
    && rakudobrew build-zef \
    && zef install Linenoise \
    && apk del $PKGS_TMP \
    && RAKUDO_VERSION=`sed "s/\n//" /root/.rakudobrew/CURRENT` \
       rm -rf /root/.rakudobrew/${RAKUDO_VERSION}/src /root/zef \
       /root/.rakudobrew/git_reference

# Runtime
WORKDIR /root
ENTRYPOINT ["perl6"]
