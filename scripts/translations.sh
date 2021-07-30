#!/bin/sh

mkdir -p i18n

pybabel extract -F babelrc -k text -k LineEdit/placeholder_text -k tr --no-location -o i18n/messages.pot \
    scenes \
    maps \
    player \
    addons/shared

cd i18n

LANGS=(en de)

for LANG in "${LANGS[@]}"; do
    # msginit --no-translator --input=messages.pot --locale=$LANG

    msgmerge --update --no-fuzzy-matching --backup=none --no-location $LANG.po messages.pot

    msgfmt $LANG.po --check

    msgcmp $LANG.po $LANG.po
    # echo $str1 | grep -o "msgstr \"\"\n\n" | wc -l
done