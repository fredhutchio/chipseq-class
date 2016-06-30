.PHONY: all clean watch

all: images/.dirstamp index.html

%.html: %.md images/.dirstamp
	pandoc -s -o $@ $<

images/.dirstamp: images.in
	mkdir -p images
	cp images.in/*.png images/
	mogrify -scale 50% images/*.png
	touch $@

clean:
	rm -f images/.dirstamp
	rm -f index.html

watch: all
	fswatch -o index.md images.in | xargs -n1 -I\{\} make
