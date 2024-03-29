FROM alpine:latest

ARG VER="2021.07"
LABEL version="3.1.2" maintainer="JJMerelo@GMail.com" rakuversion=$VER

# Set up as root
ENV PKGS="curl git make gcc musl-dev" \
    PKGS_TMP="perl curl-dev linux-headers bash"

RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \
    && addgroup -S raku  && adduser -S raku -G raku
USER raku

# Environment
ENV PATH="/home/raku/.raku/bin:/home/raku/.raku/share/perl6/site/bin:${PATH}" \
    ENV="/home/raku/.profile"

# Basic setup, programs and init
WORKDIR /home/raku
RUN curl https://rakubrew.org/install-on-perl.sh | bash \
    && echo eval "$(/home/raku/.rakubrew/bin/rakubrew init Sh)" >> ~/.profile \
    && source ~/.profile \
    && rakubrew build moar $VER --configure-opts='--prefix=/home/raku/.raku' \
    && rm -rf /home/raku/.rakubrew/versions/moar-$VER \
    && rakubrew register moar-$VER /home/raku/.raku \
    && rakubrew global moar-$VER \
    && rakubrew build-zef \
    && zef install Linenoise App::Prove6 \
    && rm -rf .profile /home/raku/.rakubrew /home/raku/zef

USER root
RUN apk del $PKGS_TMP

# Runtime
USER raku
ENTRYPOINT ["raku"]
