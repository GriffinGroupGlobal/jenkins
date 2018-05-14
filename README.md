# Continuous Delivery

This is the G3 continuous delivery engine, [jenkins][jenkins]. This setup is based on the 
[jenkins docker][jenkinsdocker] image. This image will setup jenkins, brpassing the initial wizard based setup and 
loading default plugins as specified in the plugins.txt file.

specifically, we are using [jenkins blue ocean][jenkinsblue] [docker image][jenkinsbluedocker].

# Building the Continuous Delivery Server
- copy build_data.yml to build_data_copy.yml and replace the parameters with the values you want
  - specifically change password
- run buildcontainer.sh
- publish to docker hub using image g3dev/jenkins
  - don't forget to specify a tag if you don't want this to be latest

# Compliance

All readme files within this project are written according to the [Common Mark][commonmark] specification.
[Learning Common Mark in 60 seconds][commonmarkhelp]

[commonmark]:http://commonmark.org/
[commonmarkhelp]:http://commonmark.org/help/
[jenkins]:https://jenkins.io/
[jenkinsdocker]:https://hub.docker.com/r/jenkins/jenkins/
[jenkinsblue]:https://jenkins.io/projects/blueocean/
[jenkinsbluedocker]:https://hub.docker.com/r/jenkinsci/blueocean/