#!/usr/bin/env bash

sudo rm -rf static/

# Collect emojione
mkdir -p static/js
if [ -f emojione/Emoji.js ]; then
    cp emojione/Emoji.js static/js/Emoji.js
fi
if [ -f emojione/EmojiMini.js ]; then
    cp emojione/EmojiMini.js static/js/EmojiMini.js
fi

# Regenerate public state
if [ -f scripts/regenerate_public_state_js.py ]; then
    python3 scripts/regenerate_public_state_js.py
fi

python3 manage.py allapps collectstatic --noinput --ignore *.es6.js --ignore *.jsx

# Collect static files
if [ -f django-static/robots.txt ]; then
    cp django-static/robots.txt static/robots.txt
fi
