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
	# TODO check if LaTeX packages already are installed

	rm -rf /tmp/latexclasses || true
	git clone https://github.com/hugonikanor/latexclasses.git /tmp/latexclasses
	cd /tmp/latexclasses; make

	rm -rf /tmp/latexpackages || true
	git clone https://github.com/hugonikanor/latexpackages.git /tmp/latexpackages
	cd /tmp/latexpackages; make

# Run this after the other ones!
install:
	@echo "Make sure that a directory /var/www/html/lectures/ extists"
	@echo "And is read and writeable by $(user)" 
	ls -dl /var/www/html/lectures

	# TODO LaTeX check and warning

	mkdir $(path) || true

	ln -s /var/www/html/lectures $(path)/publish                       || true
	ln -s $(here)/sh/get-keywords $(path)/                             || true
	ln -s $(here)/clojure/target/database-deploy.jar $(path)/          || true
	ln -s $(here)/make/Makeremote $(path)/Makefile                     || true
	ln -s $(here)/php/* $(path)/publish/                               || true
	ln -s $(here)/clojure/database-deploy.jar $(path)/                 || true
	ln -s $(here)/php/database.ini $(path)/                            || true

	@echo "Remember to set SQL connection information in php/database.ini"

full: mysql clojure latex install
