FROM ubuntu:16.04

MAINTAINER Alex Zvonaryov

RUN apt-get update \
    && apt install unzip -y \
    && apt install build-essential -y \
    && apt install wget -y \
    && apt install libpcre++-dev -y \
    && apt install libssl-dev -y \
    && cd /tmp \
    && wget 'http://nginx.org/download/nginx-1.14.0.tar.gz' \
    && tar -xzvf nginx-1.14.0.tar.gz \
    && wget 'http://luajit.org/download/LuaJIT-2.0.5.tar.gz' \
    && tar -xzvf LuaJIT-2.0.5.tar.gz \
    && wget http://luajit.org/download/LuaJIT-2.1.0-beta3.tar.gz \
    && tar -xzvf LuaJIT-2.1.0-beta3.tar.gz \
    && wget https://github.com/simplresty/ngx_devel_kit/archive/v0.3.1rc1.zip \
    && unzip v0.3.1rc1.zip \
    && wget https://github.com/openresty/lua-nginx-module/archive/v0.10.13.zip \
    && unzip v0.10.13.zip \
    && cd /tmp/LuaJIT-2.0.5 \
    && make install \
    && cd /tmp/LuaJIT-2.1.0-beta3 \
    && make install \
    && cd /tmp/nginx-1.14.0 \
    && export LUAJIT_LIB=/usr/local/lib/ \
    && export LUAJIT_INC=/usr/local/include/luajit-2.0 \
    && export LUAJIT_LIB=/usr/local/lib/ \
    && export LUAJIT_INC=/usr/local/include/luajit-2.1 \
    && ./configure --prefix=/opt/nginx \
         --with-ld-opt="-Wl,-rpath,/usr/local/lib" \
         --add-module=/tmp/ngx_devel_kit-0.3.1rc1 \
         --add-module=/tmp/lua-nginx-module-0.10.13 \
    && make -j2 \
    && make install \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "daemon off;" >> /opt/nginx/nginx.conf


EXPOSE 80
#CMD ["nginx"]
