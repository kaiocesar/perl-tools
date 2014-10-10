#!/usr/bin/perl -w

use File::Find;
use Cwd;
my $dir = getcwd;
use Cwd 'abs_path';

my $abs_path = abs_path(__file__);

print $tabs_path;

sub Listener {
    #-1 && -e && print "Folder/File link: $File::Find::name\n";
    if (-d $File::Find::name) {
        -1 && -e print "Folder: $File::Find::name\n";
    }
    if (-f $File::Find::name) {
        -1 && -e print "File: $File::Find::name\n";
    }
}

find(\&Listener, './dir');
