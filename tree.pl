#!/usr/bin/perl -w

use File::Find;

sub Listener {
	-1 && -e && print "Folder/File link: $File::Find::name\n";
}

find(\&Listener, './dir');