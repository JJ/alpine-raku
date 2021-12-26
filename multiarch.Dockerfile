FROM ghcr.io/raku-multiarch

ARG WORKDIR="/home/raku"

ENV PKGS="git" PKGS_TMP="make gcc linux-headers musl-dev"

LABEL version="1.0.0" maintainer="JJMerelo@GMail.com" rakuversion=$VER
LABEL org.opencontainers.image.source=https://github.com/JJ/alpine-raku

USER root
RUN apk update && apk upgrade && apk add --no-cache $PKGS $PKGS_TMP
USER raku

ENV PATH="$WORKDIR/.raku/bin:$WORKDIR/.raku/share/perl6/site/bin:${PATH}" \
    ENV="$WORKDIR/.profile" \
    RAKULIB="inst#/home/raku/.raku"

WORKDIR ${WORKDIR}
RUN echo $PATH\
    && git clone --depth 1 https://github.com/ugexe/zef.git \
    && cd zef && raku -I. bin/zef install . \
    && zef install Linenoise\
    && cd .. && rm -rf zef

USER root
RUN apk del $PGKS_TMP
USER raku

ENTRYPOINT ["raku"]
