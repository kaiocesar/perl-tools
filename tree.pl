#!usr/bin/perl -w

use File::Find;
use Cwd;

my $dir = getcwd();
my $activeDir = "";
my $count = 0;
my $countFounds = 0;
my $texto = "";


sub ReadFile{
    my $file = $_[0];
    my $flag = 0;


    open(INFO, $file) or die $!;
    @lines = <INFO>;
    close INFO;
    
    if ( scalar @lines > 0 ) {
        # print "@lines \n";  
        foreach $linhas(@lines) {
            # $cont++ while $linhas=~ /<dest>/gi;
            my $tag = trim($linhas);

            if ($tag eq "<dest>") {
                $flag = 1;
                $countFounds = $countFounds + 1;
                $texto .= "<dest>\n";
            }

            if ($flag eq 1) {
                if ($tag =~ /<CNPJ>/gi || $tag =~ /<xNome>/gi) {
                    $texto .= " $tag \n";
                }
            }

            if ($tag eq "</dest>") {
                $texto .= "</dest>\n";
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


find(\&Listener, "$dir/user_files");

# print "Countdow $count found $countFounds \n";

print "$texto\n";

