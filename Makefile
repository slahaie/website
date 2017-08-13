DOCS=index papers biography mentoring misc blog

HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix html/, $(HDOCS))

.PHONY : docs
docs : $(PHDOCS)

.PHONY : update
update : $(PHDOCS)
	@echo -n 'Copying to server...'
	rsync --delete --rsh=ssh -av html/ seblah@slahaie.net:/home/seblah/slahaie.net/
	@echo ' done.'

html/%.html : %.jemdoc
	python jemdoc.py -c bibtex.conf -o $@ $<

.PHONY : clean
clean :
	-rm -f html/*.html
