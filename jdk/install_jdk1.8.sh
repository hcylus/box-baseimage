#!/bin/bash
# vim: set ft=sh:

JDK_URL=http://oqc4nhm21.bkt.clouddn.com/java/jdk-8u111-linux-x64.tar.gz
JAVA1_8_0_HOME=/opt/java1.8

echo "--//java.home = ${JAVA1_8_0_HOME}"
echo "--// dl pkg..."
mkdir -p /opt \
  && curl --retry 3 -fSL $JDK_URL | gunzip | tar -x -C /opt \
  && ln -s /opt/jdk1.8.0_111 ${JAVA1_8_0_HOME}

echo "--// configure cli..."
for bincli in "java" "javac" "keytool"; do 
  update-alternatives --install "/usr/bin/${bincli}" "${bincli}" "$JAVA1_8_0_HOME/bin/${bincli}" 1
  update-alternatives --set "${bincli}" "$JAVA1_8_0_HOME/bin/${bincli}"
done;

JRE_HOME=${JAVA1_8_0_HOME}/jre 
CLASSPATH=$JAVA1_8_0_HOME/lib/dt.jar:$JAVA1_8_0_HOME/lib/tools.jar:$CLASSPATH

echo "--// configure env..."
echo "export JAVA_HOME=${JAVA1_8_0_HOME}" > /etc/profile.d/jdk1.8.sh
echo "export JAVA1_8_0_HOME=${JAVA1_8_0_HOME}" >> /etc/profile.d/jdk1.8.sh

rm -rf $JAVA1_8_0_HOME/*src.zip \
  $JAVA1_8_0_HOME/man \
  $JAVA1_8_0_HOME/lib/missioncontrol \
  $JAVA1_8_0_HOME/lib/visualvm \
  $JAVA1_8_0_HOME/lib/*javafx* \
  $JAVA1_8_0_HOME/jre/plugin \
  $JAVA1_8_0_HOME/jre/bin/javaws \
  $JAVA1_8_0_HOME/jre/bin/jjs \
  $JAVA1_8_0_HOME/jre/bin/orbd \
  $JAVA1_8_0_HOME/jre/bin/pack200 \
  $JAVA1_8_0_HOME/jre/bin/policytool \
  $JAVA1_8_0_HOME/jre/bin/rmid \
  $JAVA1_8_0_HOME/jre/bin/rmiregistry \
  $JAVA1_8_0_HOME/jre/bin/servertool \
  $JAVA1_8_0_HOME/jre/bin/tnameserv \
  $JAVA1_8_0_HOME/jre/bin/unpack200 \
  $JAVA1_8_0_HOME/jre/lib/javaws.jar \
  $JAVA1_8_0_HOME/jre/lib/deploy* \
  $JAVA1_8_0_HOME/jre/lib/desktop \
  $JAVA1_8_0_HOME/jre/lib/*javafx* \
  $JAVA1_8_0_HOME/jre/lib/*jfx* \
  $JAVA1_8_0_HOME/jre/lib/amd64/libdecora_sse.so \
  $JAVA1_8_0_HOME/jre/lib/amd64/libprism_*.so \
  $JAVA1_8_0_HOME/jre/lib/amd64/libfxplugins.so \
  $JAVA1_8_0_HOME/jre/lib/amd64/libglass.so \
  $JAVA1_8_0_HOME/jre/lib/amd64/libgstreamer-lite.so \
  $JAVA1_8_0_HOME/jre/lib/amd64/libjavafx*.so \
  $JAVA1_8_0_HOME/jre/lib/amd64/libjfx*.so \
  $JAVA1_8_0_HOME/jre/lib/ext/jfxrt.jar \
  $JAVA1_8_0_HOME/jre/lib/ext/nashorn.jar \
  $JAVA1_8_0_HOME/jre/lib/oblique-fonts \
  $JAVA1_8_0_HOME/jre/lib/plugin.jar

