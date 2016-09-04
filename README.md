# Note Keywords
A system for mapping keywords from documents into a database.

Basicly hashtags. This goes along with my LaTeX class *note* which should be
available [here](https://github.com/hugonikanor/latexclasses"). Those are also
downloaded to the server if the Makefile is run

## About some stuff

## Usage
Make sure that the remote git repo name matches the course name exactly. Course
names are always upper cased so the repo also needs to be that. The repo can
however still have a `.git` extension.

### git-template
This directory works as a git template, with the git hook for auto compiling incomming documents marked for compilation.

## Dependencies (proved to work with the below)
This isn't a definitive list, it's just what the dev machine had installed
- Leiningen 2.0.0 or higher -- This could probably be lowered if I can figure out builds


## TODO
+ git hook location should depend on makefile
+ database.ini should be hidden, probably via apache settings

## ISSUES
+ [Probably resolved] clojure program sometimes crash on first run. Not sure how to reproduce
+ [Solved] Clojure program crashes with null pointer exception when trying to run it on a file in a sub dir, maybe...

---

This system currently assumes that no keyword appears multiple times in the same
text...
This might become a problem further down the line
