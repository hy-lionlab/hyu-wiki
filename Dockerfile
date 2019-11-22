# Ref: https://github.com/wikimedia/mediawiki-docker/blob/master/dev/Dockerfile
# Ref: https://github.com/wikimedia/mediawiki-docker/blob/master/{VERSION}/Dockerfile

# Mediawiki Version
ARG MEDIAWIKI_MAJOR_VERSION=1.33
ARG MEDIAWIKI_BRANCH=REL1_33
ARG MEDIAWIKI_VERSION=1.33.1
ARG MEDIAWIKI_SHA512=0cf786872714546fb13843bc5f8b851bfcc665f7459a0326a3fb77efb0d1976b618d4e2206d3fb0852a60b7fa375e98aa0b5600b03209ce9eabd9e3dc5db7d1a

FROM php:7.2-fpm

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# System dependencies
RUN set -eux; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    netcat \
    librsvg2-bin \
    imagemagick \
    # Required for SyntaxHighlighting
    python3 \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /var/cache/apt/archives/*;

# Install the PHP extensions
RUN set -eux; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    build-essential \
    libicu-dev \
    ; \
    \
    docker-php-ext-install -j "$(nproc)" \
    intl \
    mbstring \
    mysqli \
    opcache \
    ; \
    \
    # APCU Install TODO: common install cmd 
    pecl install apcu-5.1.17; \
    docker-php-ext-enable \
    apcu \
    ; \
    # Clean
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*

ARG MEDIAWIKI_MAJOR_VERSION
ARG MEDIAWIKI_BRANCH
ARG MEDIAWIKI_VERSION
ARG MEDIAWIKI_SHA512

# MediaWiki setup
RUN set -eux; \
    mkdir -p /usr/src; \
    cd /tmp; \
    curl -fSL "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz" -o mediawiki.tar.gz; \
    echo "${MEDIAWIKI_SHA512} *mediawiki.tar.gz" | sha512sum -c -; \
    tar -xzf mediawiki.tar.gz --strip-components=1 --directory /usr/src/; \
    rm mediawiki.tar.gz; \
    chown -R www-data:www-data /usr/src;

# Composer Install
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Extension Install
RUN git clone -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/VisualEditor.git \
    /usr/src/extensions/VisualEditor \
    && cd /usr/src/extensions/VisualEditor \
    && git submodule update --init

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/MobileFrontend \
    /usr/src/extensions/MobileFrontend

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/googleAnalytics \
    /usr/src/extensions/googleAnalytics

RUN git clone https://github.com/somadeaki/RestrictEmailDomain.git \
    /usr/src/extensions/RestrictEmailDomain

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles \
    /usr/src/extensions/TemplateStyles

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/SwiftMailer \
    /usr/src/extensions/SwiftMailer

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/UserMerge \
    /usr/src/extensions/UserMerge

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/ContributionScores \
    /usr/src/extensions/ContributionScores

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/CleanChanges \
    /usr/src/extensions/CleanChanges

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/Babel \
    /usr/src/extensions/Babel

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr \
    /usr/src/extensions/cldr

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/ContentTranslation \
    /usr/src/extensions/ContentTranslation

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/UniversalLanguageSelector.git \
    /usr/src/extensions/UniversalLanguageSelector

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/Translate \
    /usr/src/extensions/Translate

RUN git clone --depth 1 \
    https://github.com/edwardspec/mediawiki-aws-s3.git \
    /usr/src/extensions/AWS

# AWS Composer Installation for www-data user
RUN chown -R www-data:www-data /usr/src/extensions
USER www-data
RUN cd /usr/src/extensions/AWS && COMPOSER_CACHE_DIR=/dev/null composer install
USER root

# PHP & Apache Configure
COPY php/php.ini /usr/local/etc/php/conf.d/mediawiki.ini
COPY php/opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini

VOLUME /ct

COPY run /usr/local/bin/
RUN chown root:root /usr/local/bin/run
RUN chmod 755 /usr/local/bin/run

WORKDIR /usr/src

EXPOSE 9000
CMD ["/usr/local/bin/run"]
