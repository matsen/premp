PROJ=${proj}

default: pdf

pdf:
	pandoc $(PROJ).md --template pandoc-template.tex --smart -o build.pdf
