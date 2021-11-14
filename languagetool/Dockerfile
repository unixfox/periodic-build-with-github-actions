FROM erikvl87/languagetool

USER root

RUN apk add --no-cache unzip aria2 && \
    mkdir -p /ngrams && \
    aria2c -x 16 -s 16 https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip -o /var/tmp/ngrams-en-20150817.zip && \
    unzip /var/tmp/ngrams-en-20150817.zip -d /ngrams && \
    rm /var/tmp/ngrams-en-20150817.zip && \
    aria2c -x 16 -s 16 https://languagetool.org/download/ngram-data/ngrams-fr-20150913.zip -o /var/tmp/ngrams-fr-20150913.zip && \
    unzip /var/tmp/ngrams-fr-20150913.zip -d /ngrams && \
    rm /var/tmp/ngrams-fr-20150913.zip && \
    apk del unzip aria2

USER languagetool