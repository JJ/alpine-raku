FROM ghcr.io/jj/raku-zef-gha

LABEL version="1.0.0" maintainer="jj@raku.org"

COPY --chown=raku tools/coverage.sh /home/raku/.raku/bin

USER raku
WORKDIR $WORKDIR
RUN chmod +x ~/.raku/bin/coverage.sh \
    && zef install App::RaCoCo
WORKDIR $TESTDIR

ENTRYPOINT ["coverage.sh"]
