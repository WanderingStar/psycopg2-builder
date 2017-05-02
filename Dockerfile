FROM amazonlinux

# if you wish to make an apple pie from scratch, you must first invent the universe
RUN yum install -y gcc zlib-devel
# why isn't there a package for this?
RUN curl -O https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz && tar xzf Python-3.6.1.tgz
RUN curl -O https://ftp.postgresql.org/pub/source/v9.6.2/postgresql-9.6.2.tar.gz && tar xzf postgresql-9.6.2.tar.gz
RUN curl -O http://initd.org/psycopg/tarballs/PSYCOPG-2-7/psycopg2-2.7.1.tar.gz && tar xzf psycopg2-2.7.1.tar.gz
RUN cd /Python-3.6.1 && ./configure && make && make install
RUN cd /postgresql-9.6.2 && ./configure --prefix /postgresql-9.6.2 --without-readline --without-zlib \
    && make && make install
RUN cd /psycopg2-2.7.1 \
    && python3.6 setup.py build_ext --static-libpq --pg-config /postgresql-9.6.2/bin/pg_config build

CMD cd psycopg2-2.7.1/build/lib.linux-x86_64-3.6 && tar c psycopg2