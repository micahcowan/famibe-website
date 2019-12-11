.SUFFIXES: .css .sass .pug .html

export PATH:=node_modules/.bin:$(PATH)

all: \
	html-out/style/famibe.css \
	html-out/welcome-to-famibe.html

html-out/style/%.css: sass-in/%.sass
	sass $< $@

html-out/%.html: pug-in/%.pug
	scripts/mkpug.js $< $@
