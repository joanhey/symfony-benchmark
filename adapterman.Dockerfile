FROM php:8.3-alpine

COPY --from=mlocati/php-extension-installer --link /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=composer/composer:latest-bin --link /composer /usr/local/bin/composer

RUN install-php-extensions pcntl sockets event

WORKDIR /var/www
COPY --link . .

RUN composer install --no-dev

#ENV APP_RUNTIME="Runtime\Swoole\Runtime"

RUN echo disable_functions=header,header_remove,headers_sent,headers_list,http_response_code,setcookie,session_create_id,session_id,session_name,session_save_path,session_status,session_start,session_write_close,session_regenerate_id,session_unset,session_get_cookie_params,session_set_cookie_params,set_time_limit > /usr/local/etc/php/conf.d/adapterman.ini

#ENTRYPOINT ["php", "-i"]
ENTRYPOINT ["php", "server.php", "start"]
