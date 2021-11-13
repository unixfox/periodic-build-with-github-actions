FROM erikvl87/languagetool

RUN mkdir -p /ngrams
    wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip -O /tmp/ngrams-en-20150817.zip && \
    unzip /tmp/ngrams-en-20150817.zip -d /ngrams && \
    rm /tmp/ngrams-en-20150817.zip && \
    wget https://languagetool.org/download/ngram-data/ngrams-fr-20150913.zip -O /tmp/ngrams-fr-20150913.zip && \
    unzip /tmp/ngrams-fr-20150913.zip -d /ngrams && \
    rm /tmp/ngrams-fr-20150913.zip