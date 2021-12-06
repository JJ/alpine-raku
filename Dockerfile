ARG VER="latest"
FROM jjmerelo/raku:${VER}

ENV PKGS="git"
LABEL version="4.0.0" maintainer="JJMerelo@GMail.com" rakuversion=$VER

USER root
RUN apk update && apk upgrade && apk add --no-cache $PKGS
USER raku

# Environment
ENV PATH="/home/raku/.raku/bin:/home/raku/.raku/share/perl6/site/bin:${PATH}" \
    ENV="/home/raku/.profile"

# Basic setup, programs and init
WORKDIR /home/raku
RUN git clone --depth 1  https://github.com/ugexe/zef.git \
    && cd zef \
    && raku -I. bin/zef install . \
    && zef install Linenoise

ENTRYPOINT ["raku"]
