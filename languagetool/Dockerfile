FROM erikvl87/languagetool

USER root

RUN mkdir -p /ngrams && \
    wget -qO- https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip | unzip -d /ngrams - && \
    wget https://languagetool.org/download/ngram-data/ngrams-fr-20150913.zip -O /tmp/ngrams-fr-20150913.zip && \
    unzip /tmp/ngrams-fr-20150913.zip -d /ngrams && \
    rm /tmp/ngrams-fr-20150913.zip

USER languagetool