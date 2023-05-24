# Pytorch version requires cuda 11.7
FROM nvidia/cuda:11.7.1-devel-ubuntu22.04

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git build-essential python3 python3-pip python3-dev

RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    pip3 install --no-cache-dir --upgrade pip


WORKDIR /autogptq
COPY . .

ARG AUTOGPTQ_SUBSYSTEM=llama
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    pip3 install .[${AUTOGPTQ_SUBSYSTEM}]

WORKDIR /autogptq/examples

ENTRYPOINT ["python3"]
