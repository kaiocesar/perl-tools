#!usr/bin/perl -w

use File::Find;
use Cwd;

my $dir = getcwd();
my $activeDir = "";
my $count = 0;
my $countFounds = 0;
my $texto = "";
my $noDest = "";
my $dubleDest = 0;
my $numCnpj = "";

sub ReadFile{
    my $file = $_[0];
    my $flag = 0;


    open(INFO, $file) or die $!;
    @lines = <INFO>;
    close INFO;

    if ( scalar @lines > 0 ) {

        foreach $linhas(@lines) {
            
            my $tag = trim($linhas);


            if ($tag eq "<dest>") {
                $flag = 1;
                $countFounds = $countFounds + 1;
                $noDest .= "<dest>\n";
            }

            if ($flag eq 1) {

                if ($tag =~ /<CNPJ>/gi) {
                        $numCnpj = $tag;
                        $noDest .= "$tag\n";
                }

                if ( $tag =~ /<xNome>/gi ||
                     $tag =~ /<email>/gi ||
                     $tag =~ /<fone>/gi ) {
                     $noDest .= " $tag \n";
                }
            }

            if ($tag eq "</dest>") {
                $noDest .= "</dest>\n";

                if ( $texto =~ /$numCnpj/gi ) {
                        print "\n Found duplicty $numCnpj  \n";
                } else {
                        $texto .= $noDest;
                        $texto .= "$file";
                }
                          

                $noDest = "";
                $numCnpj = "";
                $flag = 0;

            }

        }
    }

}

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub Listener {

    if (-f $File::Find::name && $File::Find::name =~ /estabelecimento_\d+\/anexos\/moddoc103_nfe\/\d+\/\d+\/.+\.xml/) {
        ReadFile($File::Find::name);
        $count = $count + 1;
    }

}


find(\&Listener, "$dir");

# print "Countdow $count found $countFounds \n";


print "$texto\n";

