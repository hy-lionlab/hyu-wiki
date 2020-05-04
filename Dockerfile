# Ref: https://github.com/wikimedia/mediawiki-docker/blob/master/dev/Dockerfile
# Ref: https://github.com/wikimedia/mediawiki-docker/blob/master/{VERSION}/Dockerfile

# Mediawiki Version
ARG MEDIAWIKI_MAJOR_VERSION=1.33
ARG MEDIAWIKI_BRANCH=REL1_33
ARG MEDIAWIKI_VERSION=1.33.1
ARG MEDIAWIKI_SHA512=0cf786872714546fb13843bc5f8b851bfcc665f7459a0326a3fb77efb0d1976b618d4e2206d3fb0852a60b7fa375e98aa0b5600b03209ce9eabd9e3dc5db7d1a

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
  https://gerrit.wikimedia.org/r/mediawiki/extensions/PageImages \
  /usr/src/extensions/PageImages

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateData \
  /usr/src/extensions/TemplateData

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateSandbox \
  /usr/src/extensions/TemplateSandbox

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateWizard \
  /usr/src/extensions/TemplateWizard

##
# Skins
##

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
  https://gerrit.wikimedia.org/r/mediawiki/skins/MinervaNeue \
  /usr/src/skins/MinervaNeue

###
# Wikimedia Repository
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

# PHP & Apache Configure
COPY php/php.ini /usr/local/etc/php/conf.d/mediawiki.ini
COPY php/opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY php/www.conf /usr/local/etc/php-fpm.d/www.conf

VOLUME /ct

COPY run /usr/local/bin/
RUN chmod 755 /usr/local/bin/run

WORKDIR /usr/src

EXPOSE 9000
CMD ["/usr/local/bin/run"]
