#!/bin/sh

mkdir -p i18n

pybabel extract -F babelrc -k text -k LineEdit/placeholder_text -k tr --no-location -o i18n/messages.pot \
    scenes \
    maps \
    player \
    addons/shared

cd i18n

# Init
# msginit --no-translator --input=messages.pot --locale=de
# msginit --no-translator --input=messages.pot --locale=en

msgmerge --update --backup=none --no-location de.po messages.pot
msgmerge --update --backup=none --no-location en.po messages.pot

msgfmt de.po --check
msgfmt en.po --check