# alpine-perl6

A docker container with Perl 6 using the minimalist distro Alpine. 

It includes

* Rakudobrew
* Perl6, latest version
* panda
* Readline for easy access


Images should be available automatically [at the Docker hub](https://hub.docker.com/r/jjmerelo/alpine-perl6/)

Use

	sudo docker run -it jjmerelo/alpine-perl6

to get into the perl6 interpreter. Can also be used as a "binary"

	sudo docker run -t jjmerelo/alpine-perl6 -e "say 'hello þor'"
	
or you can get into the container by running

	sudo docker run -it --entrypoint sh -l -c jjmerelo/alpine-perl6
	
You can also run external scripts via the mounted `/app` volume

	sudo docker run -v `pwd`:/app -it  jjmerelo/alpine-perl6 /app/heloþor.p6
	
This is the example provided in this repo. Check out the use of þ.

Contributions, suggestions and patches are welcome.
