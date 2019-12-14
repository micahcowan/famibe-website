.SUFFIXES: .css .sass .pug .html

export PATH:=node_modules/.bin:$(PATH)

all: \
	html-out/style/famibe.css \
	html-out/welcome-to-famibe.html

html-out/style/%.css: html-out/style/%.sass Makefile packages-installed.stamp
	sass $< $@

.SECONDARY: $(patsubst sass-in/%.sass,html-out/style/%.sass,$(wildcard sass-in/*.sass))

html-out/style/%.sass: sass-in/%.sass Makefile packages-installed.stamp
	cp $< $@

html-out/%.html: pug-in/%.pug Makefile packages-installed.stamp
	sourceFile='$<' pug --basedir pug-in -P < $< > $@ || { rm -f $@; exit 1; }

packages-installed.stamp: package.json package-lock.json
	npm install
	touch $@
