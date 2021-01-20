FROM openjdk:alpine
#Mashup - main props to 3jackdaws and jtc42

USER root
WORKDIR /minecraft

VOLUME /minecraft/world
VOLUME /minecraft/settings

EXPOSE 25565

RUN apk update && apk add curl bash
RUN apk add unzip && apk iputils-ping

# Download and unzip minecraft files
RUN mkdir -p /minecraft/settings
RUN mkdir -p /minecraft/world

RUN wget https://media.forgecdn.net/files/2756/981/ATM3-5.12.3_Server-FULL.zip -O server_files.zip
RUN unzip server_files.zip
RUN rm server_files.zip

# Accept EULA
RUN echo "# EULA accepted on $(date)" > /minecraft/eula.txt && \
    echo "eula=true" >> eula.txt

# Fix borked settings.cfg by sticking a semi-colon at the end of each line 
#
RUN sed -i "s/$/;/g" settings.cfg

# Startup script
COPY start.sh /minecraft/
RUN chmod +x /minecraft/*.sh

CMD ["/bin/bash", "/minecraft/start.sh"]
