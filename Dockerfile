# 미디어 위키 버전 설정
# 참고
# - https://github.com/wikimedia/mediawiki-docker/blob/master/dev/Dockerfile
# - https://github.com/wikimedia/mediawiki-docker/blob/master/{VERSION}/Dockerfile

ARG MEDIAWIKI_MAJOR_VERSION=1.34
ARG MEDIAWIKI_BRANCH=REL1_34
ARG MEDIAWIKI_VERSION=1.34.1
ARG MEDIAWIKI_SHA512=3a03ac696e2d5300faba0819ba0d876a21798c8dcdc64cc2792c6db0aa81d4feaced8dc133b6ca3e476c770bf51516b0a624cb336784ae3d2b51c8c0aa5987a0

FROM 827392432764.dkr.ecr.ap-northeast-2.amazonaws.com/hy-wiki/base:latest

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

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
  rm mediawiki.tar.gz;

# Extension Install
RUN git clone -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/VisualEditor.git \
  /usr/src/extensions/VisualEditor \
  && cd /usr/src/extensions/VisualEditor \
  && git submodule update --init

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/MobileFrontend \
  /usr/src/extensions/MobileFrontend

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

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/AntiSpoof \
  /usr/src/extensions/AntiSpoof

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/CodeMirror \
  /usr/src/extensions/CodeMirror

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/Description2 \
  /usr/src/extensions/Description2

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/DisableAccount \
  /usr/src/extensions/DisableAccount

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/Disambiguator \
  /usr/src/extensions/Disambiguator

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/Echo \
  /usr/src/extensions/Echo

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/Josa \
  /usr/src/extensions/Josa

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/LoginNotify \
  /usr/src/extensions/LoginNotify

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/OpenGraphMeta \
  /usr/src/extensions/OpenGraphMeta

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateData \
  /usr/src/extensions/TemplateData

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateSandbox \
  /usr/src/extensions/TemplateSandbox

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateWizard \
  /usr/src/extensions/TemplateWizard

## for Graph Extensions
RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/JsonConfig \
  /usr/src/extensions/JsonConfig

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/Graph \
  /usr/src/extensions/Graph

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/Mpdf \
  /usr/src/extensions/Mpdf

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/HitCounters \
  /usr/src/extensions/HitCounters

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/BetaFeatures \
  /usr/src/extensions/BetaFeatures

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/CommonsMetadata \
  /usr/src/extensions/CommonsMetadata

##
# Skins
##

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/skins/MinervaNeue \
  /usr/src/skins/MinervaNeue

###
# Non Wikimedia Repository
###
RUN git clone --depth 1 \
  https://github.com/edwardspec/mediawiki-aws-s3.git \
  /usr/src/extensions/AWS

RUN git clone --depth 1 \
  https://gitlab.com/hydrawiki/extensions/EmbedVideo.git \
  /usr/src/extensions/EmbedVideo

# COPY Resources
COPY --chown=www-data:www-data resources /usr/src/resources/

# Change owner
RUN chown -R www-data:www-data /usr/src

# AWS Composer Installation
RUN cd /usr/src/extensions/AWS && sudo -u www-data COMPOSER_CACHE_DIR=/dev/null composer install --no-dev

# SwiftMailer Composer Installation
RUN cd /usr/src/extensions/SwiftMailer && sudo -u www-data COMPOSER_CACHE_DIR=/dev/null composer install --no-dev

# AntiSpoof Composer Installation
RUN cd /usr/src/extensions/AntiSpoof && sudo -u www-data COMPOSER_CACHE_DIR=/dev/null composer install --no-dev

# MPdf Composer Installation
RUN cd /usr/src/extensions/Mpdf && sudo -u www-data COMPOSER_CACHE_DIR=/dev/null composer install --no-dev

# Maps Extension Installation
RUN cd /usr/src && COMPOSER=composer.local.json composer require --no-update mediawiki/maps:~7.0 && composer update mediawiki/maps --no-dev -o

# PHP & Apache Configure
COPY php/php.ini /usr/local/etc/php/conf.d/mediawiki.ini
COPY php/opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY php/www.conf /usr/local/etc/php-fpm.d/www.conf

VOLUME /ct

COPY run /usr/local/bin/
RUN chmod 755 /usr/local/bin/run

WORKDIR /usr/src

# FIXME: [TEMP] MPdf Configurations for Korean Font
RUN sed -i 's/$this->useAdobeCJK = .*/$this->useAdobeCJK = true;/' /usr/src/extensions/Mpdf/vendor/mpdf/mpdf/config.php
RUN sed -i 's/$mpdf=.*/$mpdf = new mPDF( $mode, $format, 0, "unbatang", $marginLeft, $marginRight, $marginTop, $marginBottom, $marginHeader, $marginFooter, $orientation );/' /usr/src/extensions/Mpdf/Mpdf.hooks.php

EXPOSE 9000
CMD ["/usr/local/bin/run"]
