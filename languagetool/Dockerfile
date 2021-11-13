FROM erikvl87/languagetool

USER root

RUN apk add --no-cache unzip && \
    mkdir -p /ngrams && \
    wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip -O /var/tmp/ngrams-en-20150817.zip && \
    unzip /var/tmp/ngrams-en-20150817.zip -d /ngrams && \
    rm /var/tmp/ngrams-en-20150817.zip && \
    wget https://languagetool.org/download/ngram-data/ngrams-fr-20150913.zip -O /var/tmp/ngrams-fr-20150913.zip && \
    unzip /var/tmp/ngrams-fr-20150913.zip -d /ngrams && \
    rm /var/tmp/ngrams-fr-20150913.zip && \
    apk del unzip

USER languagetool