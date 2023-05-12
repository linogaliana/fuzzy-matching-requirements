ARG BASE_IMAGE=inseefrlab/onyxia-python-minimal
FROM $BASE_IMAGE

SHELL ["/bin/bash", "-c"]

USER root

ADD requirements.txt .

RUN if ! [[ -z "${CUDA_VERSION}" ]]; then \
        # CUDA support
        pip install torch torchvision torchaudio; \
    else \
        # CPU only
        pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu; \
    fi && \
    # Fix permissions
    chown -R ${USERNAME}:${GROUPNAME} ${HOME} ${MAMBA_DIR} && \
    # Clean
    mamba clean --all -f -y && \
    rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt

USER 1000

CMD ["python3", "-c", "\"import fasttext\""]