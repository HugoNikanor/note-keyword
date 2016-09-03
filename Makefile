.PHONY: clojure mysql latex install full
path=$$HOME/lecture
mysqluser=root
user=`whoami`
here=`pwd`

clojure:
	cd clojure; lein uberjar

mysql:
	mysql -u $(mysqluser) -p < sql/create_full.sql

latex:
	rm -rf /tmp/latexclasses || true
	rm -rf /tmp/latexpackages || true
	git clone https://github.com/hugonikanor/latexclasses.git /tmp/latexclasses
	git clone https://github.com/hugonikanor/latexpackages.git /tmp/latexpackages

# Run this after the other ones!
install:
	@echo "Make sure that a directory /var/www/html/lectures/ extists"
	@echo "And is read and writeable by $(user)" 
	ls -dl /var/www/html/lectures

	mkdir $(path) || true

	ln -s /var/www/html/lectures $(path)/publish                       || true
	ln -s $(here)/sh/get-keywords $(path)/                             || true
	ln -s $(here)/clojure/target/database-deploy.jar $(path)/          || true
	ln -s $(here)/make/Makeremote $(path)/Makefile                     || true
	ln -s $(here)/php/* $(path)/publish/                               || true
	#ln -s $(here)/sql/get_full_keyword_table.sql $(path)/publish/     || true
	ln -s $(here)/clojure/database-deploy.jar $(path)/                 || true
	ln -s $(here)/php/database.ini $(path)/                            || true
	
	cp /tmp/latexclasses/note.cls $(path)/
	cp /tmp/latexpackages/keyword.sty $(path)/

	@echo "Remember to set SQL connection information in php/database.ini"

full: mysql clojure latex install
