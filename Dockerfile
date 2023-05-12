FROM inseefrlab/python-pytorch

USER root

RUN pip install -r requirements.txt

CMD ["python3", "-c", "\"import fasttext\""]