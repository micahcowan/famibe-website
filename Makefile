.SUFFIXES: .css .sass .pug .html

export PATH:=node_modules/.bin:$(PATH)

all: \
	html-out/style/famibe.css \
	html-out/welcome-to-famibe.html

html-out/style/%.css: sass-in/%.sass Makefile
	sass $< $@

html-out/%.html: pug-in/%.pug Makefile
	pug -P < $< > $@ || { rm -f $@; exit 1; }
