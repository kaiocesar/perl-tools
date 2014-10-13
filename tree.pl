#!/usr/bin/perl -w

use File::Find;
use Cwd;
my $dir = getcwd();

sub ReadFile{
        my $file = @_[0];

        open(INFO, $file) or die $!;
        @lines = <INFO>;
        close INFO;

        print "Size: ". scalar @lines . "\n";

        if ( scalar @lines > 0) {
            print "Read ok.";
        }

}

sub Listener {
    if (-d $File::Find::name) {
        -1 && -e print "Folder: $File::Find::name\n";
    }
    if (-f $File::Find::name) {
        -1 && -e print "Folder: $File::Find::name\n";
        ReadFile($File::Find::name);
    }
}


find(\&Listener, "$dir/dir");


