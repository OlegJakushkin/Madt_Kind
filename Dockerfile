FROM ubuntu:18.04
 
RUN apt-get update
RUN apt-get install wget -y

RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
 
WORKDIR /tmp
RUN wget https://dl.google.com/go/go1.14.linux-amd64.tar.gz
RUN tar -xvf go1.14.linux-amd64.tar.gz
RUN tar -xvf go1.14.linux-amd64.tar.gz
RUN mv go /usr/local
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH
 
RUN apt-get install curl -y
 
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
 
RUN curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=1.6.0 sh -
RUN chmod +x ./istio-1.6.0
RUN mv ./istio-1.6.0 /usr/local/bin/istio-1.6.0
ENV ISTIOPATH=/usr/local/bin/istio-1.6.0
ENV PATH=$ISTIOPATH/bin:$PATH
 
RUN curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64"
RUN chmod +x ./kind
RUN mv ./kind /usr/local/bin/kind
 
RUN curl -sSL https://get.docker.com/ | sh
RUN apt-get install systemd -y
 
WORKDIR /
COPY scripts scripts
COPY configs configs

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]