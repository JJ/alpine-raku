# alpine-perl6

A docker container with Perl 6 using the minimalist Linux distro Alpine. 

It includes

* Rakudobrew
* Perl6, latest version
* panda
* Readline for easy access
* perl, needed to run rakudobrew


New images should be automatically available  [at the Docker hub](https://hub.docker.com/r/jjmerelo/alpine-perl6/)

Use

	sudo docker run -it jjmerelo/alpine-perl6

to get into the perl6 interpreter REPL. Can also be used as a "binary" this way

	sudo docker run -t jjmerelo/alpine-perl6 -e "say 'hello þor'"
	
or you can get into the container by running

	sudo docker run -it --entrypoint sh -l -c jjmerelo/alpine-perl6
	
You can also run external scripts via the mounted `/app` volume

	sudo docker run -v `pwd`:/app -it  jjmerelo/alpine-perl6 /app/heloþor.p6
	
This `heloþor.p6` is the example provided in this repo, which you should have cloned or downloaded in the usual way. Check out the use of þ. Cool, isn't it? You can use any other directory instead of `/app`

For instance, we can create a directory this way

	sudo docker run -t jjmerelo/alpine-perl6 -e "mkdir 'p6-app'; say 'p6-app'.IO.abspath;"
	
This will return
	
	/root/p6-app

And then

	sudo -E  docker run -t -v `pwd`:/root/p6-app jjmerelo/alpine-perl6 /root/p6-app/pell.p6 6

which would return the first 6 [Pell numbers](https://en.wikipedia.org/wiki/Pell_number). Or

	sudo -E  docker run -t -v `pwd`:/root/p6-app jjmerelo/alpine-perl6 /root/p6-app/horadam.p6 10

which will return the 10 first elements of the [Horadam sequence](http://mathworld.wolfram.com/HoradamSequence.html) for p=0, q=1, r= 0.25, s=0.75

## More one-liners for demos

Check out the [Madhava-Leibniz series that computes the digits of Pi](https://gist.github.com/JJ/eb09eefe5f2bd8ae7d0ea332378a51b9) or [the binomial coefficients](https://gist.github.com/JJ/a8634b671e78eda37dc513c6dec68294)

## Contributions

Contributions, suggestions and patches are welcome.
