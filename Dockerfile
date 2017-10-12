FROM python:3

RUN apt-get install --yes curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install --yes nodejs

RUN mkdir ellie
COPY .env.example /ellie/.env
COPY *.txt \
     *.json \
     *.js \
     *.py \
     make \
     client \
     Procfile \
     scripts \
     server \
     ellie/

WORKDIR ellie/

RUN python3 -m venv ./env && . env/bin/activate
RUN pip install --no-cache-dir -r requirements.txt
RUN export $(cat .env | xargs)



