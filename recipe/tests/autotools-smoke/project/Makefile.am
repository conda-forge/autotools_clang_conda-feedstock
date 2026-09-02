lib_LTLIBRARIES = libautotools_smoke.la
libautotools_smoke_la_SOURCES = answer.c answer.h
libautotools_smoke_la_LDFLAGS = -no-undefined -version-info 0:0:0
include_HEADERS = answer.h

bin_PROGRAMS = autotools-smoke
autotools_smoke_SOURCES = main.c
autotools_smoke_LDADD = libautotools_smoke.la

TESTS = autotools-smoke$(EXEEXT)
