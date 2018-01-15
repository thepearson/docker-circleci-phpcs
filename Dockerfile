FROM circleci/php:5.6

RUN sudo curl -L http://cs.sensiolabs.org/download/php-cs-fixer-v1.phar -o php-cs-fixer \
  && sudo chmod +x php-cs-fixer && sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer

COPY ./scripts/tag.sh /usr/local/bin/tag.sh
