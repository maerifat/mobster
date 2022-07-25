FROM ubuntu:22.04
LABEL org.opencontainers.image.authors="maerifat@gmail.com"
WORKDIR /home/tools
RUN mkdir -p /home/tools
RUN apt-get update -y
RUN apt update --fix-missing
RUN apt install python2 -y
RUN apt-get install -y \
    git \
    sudo \
    unzip \
    vim \
    nano \
    wget \
    xdg-utils \
    adb \
    python3-pip \
    default-jdk \
    default-jre
RUN pip install frida-tools 
COPY tools /home/tools
RUN mv apktool /usr/local/bin \
    && mv apktool.jar /usr/local/bin \
    && chmod +x /usr/local/bin/*
#RUN apt install default-jdk -y
#RUN apt install default-jre -y
RUN wget -nv https://github.com/java-decompiler/jd-gui/releases/download/v1.6.6/jd-gui-1.6.6.deb -O jdgui.deb \
    && sudo mkdir /usr/share/desktop-directories \
    && dpkg -i jdgui.deb \
    && echo "java  --add-opens java.base/jdk.internal.loader=ALL-UNNAMED \
        --add-opens jdk.zipfs/jdk.nio.zipfs=ALL-UNNAMED \
        -jar /opt/jd-gui/jd-gui.jar" > /usr/local/bin/jd-gui \
    && chmod +x /usr/local/bin/jd-gui 
RUN pip3 install objection
RUN git clone https://github.com/b-mueller/apkx && cd apkx && sudo ./install.sh
RUN apt install python-is-python3
#ENTRYPOINT ["java", "-jar", "/home/tools/Bytecode-Viewer-2.11.2.jar"]
#ENV DISPLAY=host.docker.internal:0.0
RUN mv /home/tools/bytecode-viewer.jar /usr/local/bin/bytecode-viewer.jar \
	&& echo "java -jar /usr/local/bin/bytecode-viewer.jar" > /usr/local/bin/bytecode-viewer \
	&& chmod +x /usr/local/bin/bytecode-viewer
#testing...
#here we go