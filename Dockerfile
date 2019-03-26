FROM openshift/jenkins-slave-base-centos7:v3.11

# Install skaffold
RUN curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
    chmod +x skaffold && \
    mv skaffold /usr/local/bin

# Install helm
ENV HELM_VERSION v2.13.1
RUN curl -LO https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    helm init --client-only

# Install terraform
ENV TERRAFORM_VERSION=0.11.13
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin

# yum packages
RUN yum install -y epel-release && \
    yum makecache fast && \
    yum install -y \
    docker-client \
    jq \
    python2-pip &&\
    yum clean all && \ 
    rm -rf /var/cache/yum

# pip packages
RUN pip install --upgrade pip && \
    pip install awscli 

