FROM alpine:latest
LABEL version="2.3" maintainer="JJMerelo@GMail.com" perl6version="2019.11"

# Environment
ENV PATH="/root/raku-install/bin:/root/raku-install/share/perl6/site/bin:/root/.rakudobrew/bin:${PATH}" \
    PKGS="curl git perl" \
    PKGS_TMP="curl-dev linux-headers make gcc musl-dev wget" \
    ENV="/root/.profile" \
    VER="2019.11"

# Basic setup, programs and init
RUN mkdir /home/raku \
    && apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \
    && git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && echo 'eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"' >> ~/.profile \
    && eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"\
    && rakudobrew build moar $VER --configure-opts='--prefix=/root/raku-install' \
	&& rm -rf /root/.rakudobrew/versions/moar-$VER \
	&& rakudobrew register moar-$VER /root/raku-install \
    && rakudobrew global moar-$VER \
    && rakudobrew build-zef\
    && zef install Linenoise App::Prove6\
    && apk del $PKGS_TMP \
    && rm -rf /root/.rakudobrew /root/raku-install/zef

# Runtime
WORKDIR /home/raku
ENTRYPOINT ["raku"]
