# Alpine containers for Raku [![Test-create and publish a Docker image](https://github.com/JJ/alpine-raku/actions/workflows/test-upload-ghcr.yaml/badge.svg)](https://github.com/JJ/alpine-raku/actions/workflows/test-upload-ghcr.yaml)

A Docker container with Raku using the minimalist Linux distro [Alpine](https://alpinelinux.org/).

It includes

* Raku (Rakudo - NQP - MoarVM), latest version, as well as older versions in tags/subdirectories
* `zef` for module installation
* [Linenoise](https://github.com/hoelzro/p6-linenoise) for easy shell use.
* `curl` which is needed for some other downstream compatibilities.
* `gcc` and `musl-dev`, which you probably don't need, but can be used
  for NativeCall-related builds.
* User `raku` is defined from version/tag 2020.07, and the Raku process is
  run as a non-privileged user.

New images should be automatically available [at Docker hub](https://hub.docker.com/r/jjmerelo/alpine-raku/).

> Please note that `wget` is installed by default in Alpine, but has some known issues. Use `curl` whenever possible.

## Working with this container

Use

	docker run -it jjmerelo/alpine-raku

to get into the raku interpreter REPL. Can also be used as a "binary" this way

	docker run -t jjmerelo/alpine-raku -e "say 'hello þor'"

or you can get into the container by running

	docker run -it --entrypoint sh -l -c jjmerelo/alpine-raku

You can also run external scripts via the mounted `/app` volume. After changing to this directory

	docker run -v `pwd`:/app -it  jjmerelo/alpine-raku /app/heloþor.p6

This `heloþor.p6` is the example provided in this repo, which you should have cloned or downloaded in the usual way. Check out the use of þ. Cool, isn't it? You can use any other directory instead of `/app`

For instance, we can create a directory this way

	docker run --rm -t jjmerelo/alpine-raku -e "mkdir 'raku-app'; say 'raku-app'.IO.absolute;"


This will return

	/home/raku/raku-app


And then

	docker run -t -v `pwd`:/home/raku/raku-app jjmerelo/alpine-raku /home/raku/raku-app/pell.p6 6


which would return the first 6 [Pell numbers](https://en.wikipedia.org/wiki/Pell_number). Or

	docker run -t -v `pwd`:/home/raku/raku-app jjmerelo/alpine-raku /home/raku/raku-app/horadam.p6 10


which will return the 10 first elements of the [Horadam
sequence](http://mathworld.wolfram.com/HoradamSequence.html) for p=0,
q=1, r= 0.25, s=0.75.

## Install new modules

Since `zef` is included in the image, you can use it to install new
modules. You can do it by getting into the container and running the
shell:

	docker run -it --entrypoint="/bin/sh" jjmerelo/alpine-raku

and then

	zef install Math::Constants


Or directly in a single command

	docker run -it --rm  --entrypoint=/bin/sh jjmerelo/alpine-raku -c "zef install Math::Sequences"


This overrides the default entrypoint and, instead, runs `zef` as a
shell command, installing the module within the container.

## More one-liners for demos

Check out the [Madhava-Leibniz series that computes the digits of
Pi](https://gist.github.com/JJ/eb09eefe5f2bd8ae7d0ea332378a51b9) or
[the binomial
coefficients](https://gist.github.com/JJ/a8634b671e78eda37dc513c6dec68294). Run
them directly thus:

```shell
docker run -t --rm jjmerelo/alpine-raku -e "say π  - 4 * ([+]  <1 -1> <</<<  (1,3,5,7,9...10000))  "
```

## Contributions

Contributions, suggestions and patches are welcome. Please go to the
[GitHub repo](https://github.com/JJ/alpine-raku).

## Previous versions

Previous versions of raku are available also as image tags. For instance, you can do

   docker run -t jjmerelo/alpine-raku:2019.07 -e "'hello þor'.say"

to download and/or run the 2019.07 version of this container.

Additionally, a `nightly` tag contains a fresh image, built every night from Rakudo `HEAD`.

## See also

The [`raku-test` image](https://hub.docker.com/r/jjmerelo/raku-test)
can be used directly for tests, no need to build your own based on
this one.
