FROM izzyacademy/kafka-docs-base:1.0.0

RUN mkdir -p /tmp/kafka-validation

ENV TMPDIR="/tmp/kafka-validation"

WORKDIR /usr/local/software

RUN git clone https://github.com/apache/kafka-site.git site-docs

COPY httpd.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /etc/apache2/mods-enabled

RUN ln -s /etc/apache2/mods-available/include.load include.load 
RUN ln -s /etc/apache2/mods-available/rewrite.load rewrite.load

WORKDIR /usr/local/software

EXPOSE 80 443 

# This is how to build the base Docker image
# docker build . -f Docs.Dockerfile -t izzyacademy/kafka-docs:3.1.0-rc0

