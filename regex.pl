#!/usr/bin/perl 

my $path = "user_files/estabelecimento_100/anexos/moddoc103_nfe/2838/19047/0000000000000000000000000000000000000000.xml";

if ($path =~ m/_([0-9]+)\/anexos\/moddoc103_nfe\/([0-9]+)\/([0-9]+)\//i) {
    print "Estabelecimento: $1\nCliente: $2\nModdoc103: $3\n";
} else {
    print "no match\n";
}