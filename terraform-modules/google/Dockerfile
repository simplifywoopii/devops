FROM python:alpine3.18
LABEL maintainer="simplifywoopii@gmail.com"

ENV PYTHONUNBUFFERED 1

COPY ./credentials.json /root/.gcp/credentials/credentials.json
COPY entrypoint.sh /entrypoint.sh


RUN apk add curl unzip &&\
    apk add build-base linux-headers

RUN curl -O https://releases.hashicorp.com/terraform/1.8.2/terraform_1.8.2_linux_arm.zip &&\
    unzip terraform_1.8.2_linux_arm.zip &&\
    mv terraform /usr/local/bin/ &&\
    rm terraform_1.8.2_linux_arm.zip

ENV TERRAFORM_WORKSPACE=${TERRAFORM_WORKSPACE}
ENV TERRAFORM_BACKEND_CONF=${TERRAFORM_BACKEND_CONF}
ENV GOOGLE_APPLICATION_CREDENTIALS="/root/.gcp/credentials/credentials.json"


WORKDIR /gke
# RUN terraform init -backend-config ${TERRAFORM_BACKEND_CONF} &&\
#     terraform workspace select ${TERRAFORM_WORKSPACE}
# gcloud install
# RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-473.0.0-linux-x86_64.tar.gz && \
#     tar -xf google-cloud-cli-473.0.0-linux-x86_64.tar.gz &&\
#     rm -rf google-cloud-cli-473.0.0-linux-x86_64.tar.gz &&\
#     ./google-cloud-sdk/install.sh

# pulumi install
# RUN curl -fsSL https://get.pulumi.com | sh

# ENV PATH="/gke/venv/bin:$PATH"
# ENV PATH="/root/.pulumi/bin:$PATH"
# ENV PATH="/google-cloud-sdk/bin:$PATH"
# ENV USE_GKE_GCLOUD_AUTH_PLUGIN=True
# ENV GOOGLE_APPLICATION_CREDENTIALS="/root/.gcp/credentials/credentials.json"
# ENV GOOGLE_PROJECT=${GOOGLE_PROJECT}
# ENV GOOGLE_APPLICATION_SERVICE_ACCOUNT=${GOOGLE_APPLICATION_SERVICE_ACCOUNT}

# WORKDIR /gke
# RUN gcloud --quiet components install gke-gcloud-auth-plugin
# RUN gcloud auth activate-service-account ${GOOGLE_APPLICATION_SERVICE_ACCOUNT} --key-file=${GOOGLE_APPLICATION_CREDENTIALS} --project=${GOOGLE_PROJECT}
# RUN ./venv/bin/pip install -r requirements.txt

# RUN /gke/venv/bin/pip install -r /gke/requirements.txt