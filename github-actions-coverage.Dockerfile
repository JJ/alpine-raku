FROM ghcr.io/jj/raku-zef-gha

LABEL version="1.0.0" maintainer="jj@raku.org"

USER raku
WORKDIR $WORKDIR
RUN zef install App::RaCoCo
WORKDIR $TESTDIR

ENTRYPOINT ["racoco", "-l"]
