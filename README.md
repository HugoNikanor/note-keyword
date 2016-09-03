# Note Keywords
A system for mapping keywords from documents into a database.

Basicly hashtags. This goes along with my LaTeX class *note* which should be
available [here](https://github.com/hugonikanor/latexclasses"). Those are also
downloaded to the server if the Makefile is run

## About some stuff

### git-template
This directory works as a git template, with the git hook for auto compiling incomming documents marked for compilation.

## Dependencies

## TODO
+ PDF files should be sorted in directories depending on course, otherwise there can only be a single pdf for each day.
+ git hook location should depend on makefile

## ISSUES
+ [Probably resolved] clojure program sometimes crash on first run. Not sure how to reproduce
+ Clojure program crashes with null pointer exception when trying to run it on a file in a sub dir, maybe...

---

This system currently assumes that no keyword appears multiple times in the same
text...
This might become a problem further down the line
