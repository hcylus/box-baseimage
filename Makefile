
DOCKER_HUB=hub.digi-sky.com

.PHONY: base/centos7 jdk jenkins/slave \
	jenkins/ssh-slave jenkins/swarm-slave jenkins/master \
	vsftpd

base/centos7:
	.bin/docker-build.sh base/centos7

jdk: base/centos7
	.bin/docker-build.sh jdk

jenkins/slave:
	.bin/docker-build.sh jenkins/slave

jenkins/ssh-slave: jenkins/slave
	.bin/docker-build.sh jenkins/ssh-slave

push-jenkins/ssh-slave: jenkins/ssh-slave
	.bin/docker-push.sh --registry-host ${DOCKER_HUB} jenkins/ssh-slave

jenkins/swarm-slave: jenkins/slave
	.bin/docker-build.sh jenkins/swarm-slave

push-jenkins/swarm-slave: jenkins/swarm-slave
	.bin/docker-push.sh --registry-host ${DOCKER_HUB} jenkins/swarm-slave

jenkins/jnlp-slave: jenkins/slave
	.bin/docker-build.sh jenkins/jnlp-slave

jenkins/master: 
	.bin/docker-build.sh jenkins/master

vsftpd:
	.bin/docker-build.sh vsftpd

