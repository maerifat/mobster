FROM ubuntu:rolling
LABEL org.opencontainers.image.authors="maerifat@gmail.com"
RUN mkdir -p /home/tools
RUN mkdir -p /home/dist
WORKDIR /home/tools
COPY tools /home/tools
COPY dist /home/dist
RUN apt-get update -y \
    && apt-get install -y \
    python2 \
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
    default-jre \
    python3-dev \
    python3-venv \
    python3-pip \
    build-essential \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg8-dev \
    zlib1g-dev \
    make \
    gcc \
    libzip-dev \
    curl \
    pkg-config \
    xfonts-75dpi \
    xfonts-base \
    python-is-python3 \
    &&  rm -rf /var/lib/apt/lists/*\
    && apt-get update --fix-missing
RUN pip install \
    frida-tools \
    angr \
    twisted \
    django \
    service_identity
RUN pip3 install \
    objection \
    Pyopenssl 
RUN python2 /home/dist/get-pip.py \
    && python2 -m pip install --upgrade "pip < 21.0"
RUN dpkg -i /home/dist/wkhtmltox_0.12.6.1-2.jammy_amd64.deb
RUN mv /home/dist/apktool /usr/local/bin \
    && mv /home/dist/apktool.jar /usr/local/bin \
    && chmod +x /usr/local/bin/apktool
RUN sudo mkdir /usr/share/desktop-directories \
    && dpkg -i /home/dist/jdgui.deb \
    && echo "java  --add-opens java.base/jdk.internal.loader=ALL-UNNAMED \
        --add-opens jdk.zipfs/jdk.nio.zipfs=ALL-UNNAMED \
        -jar /opt/jd-gui/jd-gui.jar" > /usr/local/bin/jd-gui \
    && chmod +x /usr/local/bin/jd-gui 
RUN cd /home/tools/apkx \
    && chmod +x install.sh \
    && ./install.sh
#RUN dpkg -i /home/tools/wkhtmltopdf
#RUN git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git \
RUN cd Mobile-Security-Framework-MobSF \
    && ./setup.sh
#ENTRYPOINT ["java", "-jar", "/home/tools/Bytecode-Viewer-2.11.2.jar"]
#ENV DISPLAY=host.docker.internal:0.0
RUN mv /home/dist/bytecode-viewer.jar /usr/local/bin/bytecode-viewer.jar \
	&& echo "java -jar /usr/local/bin/bytecode-viewer.jar" > /usr/local/bin/bytecode-viewer \
	&& chmod +x /usr/local/bin/bytecode-viewer
#RUN git clone --recursive https://github.com/nowsecure/r2frida.git \
#    && cd r2frida 
   # && make \
   # && make install
#testing...
#here we go
RUN pip2 install /home/dist/drozer-2.4.4-py2-none-any.whl 
# adb -H host.docker.internal devices