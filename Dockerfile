FROM alpine:latest
LABEL version="2.0.7" maintainer="JJMerelo@GMail.com" perl6version="2019.03.1"

# Environment
ENV PATH="/home/jmerelo/.rakudobrew/bin/../versions/moar-2019.03.1/install/bin:/home/jmerelo/.rakudobrew/bin/../versions/moar-2019.03.1/install/share/perl6/site/bin:/home/jmerelo/.rakudobrew/bin:${PATH}" \
    PKGS="curl git perl" \
    PKGS_TMP="curl-dev linux-headers make gcc musl-dev wget"

# Basic setup, programs and init
RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \
    && git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && echo 'eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"' >> /etc/profile \
    && cat /etc/profile \
    && eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"\
    && echo "export PATH=$PATH" > /etc/environment \
    && rakudobrew build moar 2019.03.1 \
    && curl -L https://cpanmin.us | perl - App::cpanminus \
    && cpanm Test::Harness --no-wget \
    && rakudobrew global moar-2019.03.1 \
    && rakudobrew build-zef\
    && which perl6 \
    && which zef \
    && zef install Linenoise \
    && apk del $PKGS_TMP \
    && RAKUDO_VERSION=`sed "s/\n//" /root/.rakudobrew/CURRENT` \
       rm -rf /root/.rakudobrew/${RAKUDO_VERSION}/src /root/zef \
       /root/.rakudobrew/git_reference

# Runtime
WORKDIR /root
ENTRYPOINT perl6
