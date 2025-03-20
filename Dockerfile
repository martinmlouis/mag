FROM alpine:latest

ARG PACKER_PRODUCT="packer"
ARG PACKER_VERSION

ARG TERRAFORM_PRODUCT="terraform"
ARG TERRAFORM_VERSION="1.10.5"

RUN apk add --update --virtual .deps --no-cache gnupg && \
  cd /tmp && \
  wget https://releases.hashicorp.com/${PACKER_PRODUCT}/${PACKER_VERSION}/${PACKER_PRODUCT}_${PACKER_VERSION}_linux_amd64.zip && \
  wget https://releases.hashicorp.com/${PACKER_PRODUCT}/${PACKER_VERSION}/${PACKER_PRODUCT}_${PACKER_VERSION}_SHA256SUMS && \
  wget https://releases.hashicorp.com/${PACKER_PRODUCT}/${PACKER_VERSION}/${PACKER_PRODUCT}_${PACKER_VERSION}_SHA256SUMS.sig && \
  wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt | gpg --import && \
  gpg --verify ${PACKER_PRODUCT}_${PACKER_VERSION}_SHA256SUMS.sig ${PACKER_PRODUCT}_${PACKER_VERSION}_SHA256SUMS && \
  grep ${PACKER_PRODUCT}_${PACKER_VERSION}_linux_amd64.zip ${PACKER_PRODUCT}_${PACKER_VERSION}_SHA256SUMS | sha256sum -c && \
  unzip /tmp/${PACKER_PRODUCT}_${PACKER_VERSION}_linux_amd64.zip -d /tmp && \
  mv /tmp/${PACKER_PRODUCT} /usr/local/bin/${PACKER_PRODUCT} && \
  rm -f /tmp/${PACKER_PRODUCT}_${PACKER_VERSION}_linux_amd64.zip ${PACKER_PRODUCT}_${PACKER_VERSION}_SHA256SUMS ${PACKER_VERSION}/${PACKER_PRODUCT}_${PACKER_VERSION}_SHA256SUMS.sig && \
  apk del .deps
 
RUN apk add --update --virtual .deps --no-cache gnupg && \
    cd /tmp && \
    wget https://releases.hashicorp.com/${TERRAFORM_VERSION}/${VERSION}/${TERRAFORM_VERSION}_${VERSION}_linux_amd64.zip && \
    wget https://releases.hashicorp.com/${TERRAFORM_VERSION}/${VERSION}/${TERRAFORM_VERSION}_${VERSION}_SHA256SUMS && \
    wget https://releases.hashicorp.com/${TERRAFORM_VERSION}/${VERSION}/${TERRAFORM_VERSION}_${VERSION}_SHA256SUMS.sig && \
    wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt | gpg --import && \
    gpg --verify ${TERRAFORM_VERSION}_${VERSION}_SHA256SUMS.sig ${TERRAFORM_VERSION}_${VERSION}_SHA256SUMS && \
    grep ${TERRAFORM_VERSION}_${VERSION}_linux_amd64.zip ${TERRAFORM_VERSION}_${VERSION}_SHA256SUMS | sha256sum -c && \
    unzip /tmp/${TERRAFORM_VERSION}_${VERSION}_linux_amd64.zip -d /tmp && \
    mv /tmp/${TERRAFORM_VERSION} /usr/local/bin/${PRODUCT} && \
    rm -f /tmp/${TERRAFORM_VERSION}_${VERSION}_linux_amd64.zip ${TERRAFORM_VERSION}_${VERSION}_SHA256SUMS ${VERSION}/${TERRAFORM_VERSION}_${VERSION}_SHA256SUMS.sig && \
    apk del .deps
