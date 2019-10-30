FROM mediawiki:stable

RUN git clone -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/VisualEditor.git \
    /var/www/html/extensions/VisualEditor \
    && cd /var/www/html/extensions/VisualEditor \
    && git submodule update --init \
    && cd /var/www/html

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/MobileFrontend \
    /var/www/html/extensions/MobileFrontend

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/googleAnalytics \
    /var/www/html/extensions/googleAnalytics

RUN git clone https://github.com/somadeaki/RestrictEmailDomain.git \
    /var/www/html/extensions/RestrictEmailDomain

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/TemplateStyles \
    /var/www/html/extensions/TemplateStyles

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/SwiftMailer \
    /var/www/html/extensions/SwiftMailer

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/UserMerge \
    /var/www/html/extensions/UserMerge

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/ContributionScores \
    /var/www/html/extensions/ContributionScores

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/CleanChanges \
    /var/www/html/extensions/CleanChanges

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/Babel \
    /var/www/html/extensions/Babel

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr \
    /var/www/html/extensions/cldr

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/ContentTranslation \
    /var/www/html/extensions/ContentTranslation

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/UniversalLanguageSelector.git \
    /var/www/html/extensions/UniversalLanguageSelector

RUN git clone --depth 1 -b $MEDIAWIKI_BRANCH \
    https://gerrit.wikimedia.org/r/mediawiki/extensions/Translate \
    /var/www/html/extensions/Translate