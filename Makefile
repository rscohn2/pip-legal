build: build-pip_legal

build-%:
	pandoc -t latex -s $*.md -o $*.pdf
