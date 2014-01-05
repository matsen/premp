PROJ=${proj}

default: docx

docx:
	pandoc $(PROJ).md --smart -o build.docx

pdf:
	pandoc $(PROJ).md --smart -o build.pdf
