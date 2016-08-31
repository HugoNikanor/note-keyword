.PHONY: all roll disp live

# File
f=`date -I`

all:
	latexmk -pdf $(f)
	@echo "KEYWORDS:"
	./get-keywords $(f)

roll:
	latexmk -pdf -pvc $(f)

disp:
	mupdf $(f).pdf &

live: | disp roll
