FROM docker:20.10.0-dind

ADD ../../certificates/certs/ca.cert.pem /usr/local/share/ca-certificates/rootCA.pem
RUN chmod 644 /usr/local/share/ca-certificates/rootCA.pem && update-ca-certificates
