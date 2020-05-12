FROM ubuntu:18.04

RUN apt-get update \
    && apt-get -y install wget unzip build-essential curl

RUN wget -q https://github.com/Perl/perl5/archive/blead.zip \
    && unzip blead.zip \
    && cd perl5-blead \
    && unset PERL5LIB \
    && ./Configure -des -Dprefix=/opt/perl -Dman1dir=none -Dman3dir=none -Dlddlflags=-shared -DLibs='-lm -ldl -lpthread -lcrypt -lutil -lc' -Dusethreads -Dcc=gcc -Dld=gcc -Dcccdlflags=-fPIC -Dusedl -Ddlsrc=dl_dlopen.xs -Dusedevel \
    && make \
    && make install \
    && ln -s /opt/perl/bin/perl5.*  /opt/perl/bin/perl

CMD ["/opt/perl/bin/perl", "-V"]
