path=$$HOME/lecture
mysqluser=root
user=`whoami`
here=`pwd`

remote:

	cd clojure; lein uberjar

	@echo "Make sure that a directory /var/www/html/lectures/ extists"
	@echo "And is read and writeable by $(user)" 
	ls -dl /var/www/html/lectures

	mkdir $(path) || true
	mysql -u $(mysqluser) -p < sql/create_full.sql

	ln -s /var/www/html/lectures $(path)/publish                       || true
	ln -s $(here)/sh/get-keywords $(path)/                             || true
	ln -s $(here)/clojure/target/*-standalone.jar $(path)/database-deploy.jar || true
	ln -s $(here)/make/Makeremote $(path)/Makefile                     || true
	ln -s $(here)/php/* $(path)/publish/                               || true
	#ln -s $(here)/sql/get_full_keyword_table.sql $(path)/publish/     || true
	ln -s $(here)/clojure/database-deploy.jar $(path)/                 || true
	ln -s $(here)/php/database.ini $(path)/                            || true
	
	rm -rf /tmp/latexclasses || true
	rm -rf /tmp/latexpackages || true
	git clone https://github.com/hugonikanor/latexclasses.git /tmp/latexclasses
	git clone https://github.com/hugonikanor/latexpackages.git /tmp/latexpackages
	cp /tmp/latexclasses/note.cls $(path)/
	cp /tmp/latexpackages/keyword.sty $(path)/

	@echo "Remember to set SQL connection information in php/database.ini"
