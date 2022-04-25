FROM ghcr.io/jj/raku-gha

ENV PKGS="git tar" PKGS_TMP="make gcc linux-headers musl-dev" WORKDIR="/home/raku" TESTDIR="/home/raku/test"
LABEL version="1.0.6" maintainer="JJMerelo@GMail.com"

USER root
RUN apk update && apk upgrade && apk add --no-cache $PKGS $PKGS_TMP
USER raku

# Environment
ENV PATH="${WORKDIR}/.raku/bin:${WORKDIR}/.raku/share/perl6/site/bin:${PATH}" \
    ENV="${WORKDIR}/.profile"\
    RAKULIB="inst#/home/raku/.raku"

# Basic setup, programs and init
WORKDIR $WORKDIR
RUN git clone --depth 1 https://github.com/ugexe/zef.git \
    && cd zef && raku -I. bin/zef install . \
    && zef install Linenoise \
    && cd .. && rm -rf zef

USER root
RUN apk del $PGKS_TMP
USER raku

WORKDIR $TESTDIR

ENTRYPOINT ["zef", "install", "."]
