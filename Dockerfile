#
# Dockerfile
#
#
# Pull base image.
FROM alpine:latest
MAINTAINER qida
# Install.
## use cn source
RUN \
  apk add --no-cache --update-cache bash && \
  apk --update add wget
# Add files.
COPY addUser.js /root/addUser.js
COPY start.sh /root/start.sh

# Set environment variables.
ENV HOME /root
ENV GOPATH /root/leanote/bin

# Define working directory.
WORKDIR /root

# Download leanote and mongodb.
RUN wget http://sunqida.qiniudn.com/leanote-linux-amd64-v2.0.bin.tar.gz -O leanote.tar.gz && \
    wget http://sunqida.qiniudn.com/mongodb-linux-x86_64-ubuntu1204-3.2.8.tgz -O mongodb.tgz

# Extract them.
RUN tar -xvf leanote.tar.gz && \
    tar -xvf mongodb.tgz
RUN ["/bin/bash", "-c", "mv /root/mongodb-linux-x86_64-ubuntu1204-3.2.8/bin/* /usr/local/bin/"]

# Clean
RUN rm leanote.tar.gz && \
    rm mongodb.tgz && \
    rm -rf mongodb*

# Run leanote.
CMD ["/bin/bash","/root/start.sh"]
# CMD ["bash"]
EXPOSE 80
VOLUME ["/root/notedata","/var/log","/root/leanote/conf"]
