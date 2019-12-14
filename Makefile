.SUFFIXES: .css .sass .pug .html

SHELL=bash # for set -o pipefail

export PATH:=node_modules/.bin:$(PATH)

# filter to fix up quotes (just right single quotes, for now. filter is dumb.)
FIXQUOTS:= sed -e 's/\([A-Za-z]\)'\''/\1\&rsquo;/g'

PUGS := $(wildcard pug-in/*.pug)
HTML := $(patsubst pug-in/%.pug,html-out/%.html,$(PUGS))

all: \
	html-out/style/famibe.css \
	$(HTML)

html-out/style/%.css: html-out/style/%.sass Makefile packages-installed.stamp
	sass $< $@

.SECONDARY: $(patsubst sass-in/%.sass,html-out/style/%.sass,$(wildcard sass-in/*.sass))

html-out/style/%.sass: sass-in/%.sass Makefile packages-installed.stamp
	cp $< $@

html-out/%.html: pug-in/%.pug Makefile packages-installed.stamp pug-in/templates/famibe-tmpl.pug
	set -o pipefail; sourceFile='$<' pug --basedir pug-in -P < $< | $(FIXQUOTS) > $@ || { rm -f $@; exit 1; }

packages-installed.stamp: package.json package-lock.json
	npm install
	touch $@
