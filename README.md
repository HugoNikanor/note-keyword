# Note Keywords
A system for mapping keywords from documents into a database. It's basically hashtags. 

## About some stuff
Currently everything is installed via symlinks. This should probably be changed
so that the installer actually copies stuff. An uninstaller should then also be
written.

## Usage
Make sure that the remote git repo name matches the course name exactly. Course
names are always upper cased so the repo also needs to be that. The repo can
however still have a `.git` extension.

Also make sure to update `php/database.ini` with MySQL connection details.

### git-template
This directory works as a git template, with the git hook for auto compiling incomming documents marked for compilation.

## Dependencies (proved to work with the below)
This isn't a definitive list, it's just what the dev machine had installed
- Leiningen 2.0.0 or higher -- This could probably be lowered if I can figure out builds
- [LaTeX keywords](https://github.com/hugonikanor/LaTeXpackages), kinda, the system is worthless without them

## TODO
+ git hook location should depend on makefile
+ Checking of dependencies, especially LaTeX ones

## ISSUES
**TODO** Move this part to actual GitHub issues.
+ [Probably resolved] clojure program sometimes crash on first run. Not sure how to reproduce
+ [Solved] Clojure program crashes with null pointer exception when trying to run it on a file in a sub dir, maybe...

## Other
This system currently assumes that no keyword appears multiple times in the same
text...
This might become a problem further down the line.
