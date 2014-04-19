LS = ./node_modules/.bin/lsc
LS_MODULE = ./node_modules/LiveScript/
MOCHA = ./node_modules/.bin/mocha
BROWSERIFY = node ./node_modules/browserify/bin/cmd.js
WISP = ./node_modules/wisp/bin/wisp.js
WISP_MODULE = ./node_modules/wisp/
UGLIFYJS = ./node_modules/.bin/uglifyjs
BANNER = "/*! fw.js - v0.1.0 - MIT License - https://gitfwb.com/h2non/fw */"

define release
	VERSION=`node -pe "require('./package.json').version"` && \
	NEXT_VERSION=`node -pe "require('semver').inc(\"$$VERSION\", '$(1)')"` && \
	node -e "\
		var j = require('./package.json');\
		j.version = \"$$NEXT_VERSION\";\
		var s = JSON.stringify(j, null, 2);\
		require('fs').writeFileSync('./package.json', s);" && \
	node -e "\
		var j = require('./bower.json');\
		j.version = \"$$NEXT_VERSION\";\
		var s = JSON.stringify(j, null, 2);\
		require('fs').writeFileSync('./bower.json', s);" && \
	git commit -am "release $$NEXT_VERSION" && \
	git tag "$$NEXT_VERSION" -m "Version $$NEXT_VERSION"
endef

default: all
all: test
test: compile mocha
browser: cleanbrowser test banner browserify uglify

mkdir:
	mkdir -p lib

clean:
	rm -rf lib
	rm -f *.js

cleanbrowser:
	rm -f *.js

compile: clean mkdir
	cat src/macros.wisp src/fw.wisp | $(WISP) --no-map > lib/fw.js
	cat src/macros.wisp src/series.wisp | $(WISP) --no-map > lib/series.js
	cat src/macros.wisp src/parallel.wisp | $(WISP) --no-map > lib/parallel.js
	cat src/macros.wisp src/whilst.wisp | $(WISP) --no-map > lib/whilst.js
	cat src/macros.wisp src/util.wisp | $(WISP) --no-map > lib/util.js

mocha:
	$(MOCHA) --timeout 2000 --reporter spec --ui tdd --compilers wisp:$(WISP_MODULE)

banner:
	@echo $(BANNER) > fw.js

browserify:
	$(BROWSERIFY) \
		--exports require \
		--standalone fw \
		--entry ./lib/fw.js >> ./fw.js

uglify:
	$(UGLIFYJS) fw.js --mangle --preamble $(BANNER) > fw.min.js

release:
	@$(call release,patch)

release-minor:
	@$(call release,minor)

publish: release
	git push --tags origin HEAD:master
	npm publish

loc:
	wc -l src/*
