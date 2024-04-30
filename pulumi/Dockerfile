FROM python:alpine3.18
LABEL maintainer="simplifywoopii@gmail.com"

ENV PYTHONUNBUFFERED 1

COPY ./credentials.json /root/.gcp/credentials/credentials.json

RUN apk add curl &&\
    apk add build-base linux-headers

# gcloud install
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-473.0.0-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-473.0.0-linux-x86_64.tar.gz &&\
    rm -rf google-cloud-cli-473.0.0-linux-x86_64.tar.gz &&\
    ./google-cloud-sdk/install.sh

# pulumi install
RUN curl -fsSL https://get.pulumi.com | sh

ENV PATH="/pulumi_gke/venv/bin:$PATH"
ENV PATH="/root/.pulumi/bin:$PATH"
ENV PATH="/google-cloud-sdk/bin:$PATH"

WORKDIR /pulumi_gke
# RUN ./venv/bin/pip install -r requirements.txt

# RUN /pulumi_gke/venv/bin/pip install -r /pulumi_gke/requirements.txt