FROM alpine:latest

ARG VER="2020.07"
LABEL version="3.0.0" maintainer="JJMerelo@GMail.com" rakuversion=$VER

# Set up as root
ENV PKGS="curl git make gcc musl-dev" \
    PKGS_TMP="perl curl-dev linux-headers wget"

RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP
    
RUN addgroup -S raku  && adduser -S raku -G raku
USER raku

# Environment
ENV PATH="/home/raku/.raku/bin:/home/raku/.raku/share/perl6/site/bin:/home/raku/.rakudobrew/bin:${PATH}" \
    ENV="/home/raku/.profile"

# Basic setup, programs and init
WORKDIR /home/raku
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"\
    && rakudobrew build moar $VER --configure-opts='--prefix=/home/raku/.raku' \
    && rm -rf /home/raku/.rakudobrew/versions/moar-$VER \
    && rakudobrew register moar-$VER /home/raku/.raku \
    && rakudobrew global moar-$VER \
    && rakudobrew build-zef \
    && zef install Linenoise App::Prove6 \
    && rm -rf /home/raku/.rakudobrew /home/raku/zef

USER root
RUN apk del $PKGS_TMP

# Runtime
USER raku
ENTRYPOINT ["raku"]
