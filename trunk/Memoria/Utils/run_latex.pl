#!/usr/bin/perl -w

############################################
#                                          #
# Itsas KBP plantilla konpilatzeko scripta #
#                                          #
############################################

use strict;

#
# Fitxero nagusia badela ziurtatu
#
my $f = 'Main'; # Fitxero nagusiaren izena (alda dezakezu, noski).
die "File $f.tex does not exist!\n" unless (-f "$f.tex");

#
# Liburuaren tamaina .tex-etik atera
#
my $psize = 'a4';                                          # defektuz A4
$psize    = 'b5' if (`grep documentclass $f.tex` =~ /b5/); # B5, hala eskatu ezkero

#
# Noraino konpilatu 1 eta 4 bitarteko zenbakiak jarri, eta nahi diren opzioen 
# bezainbeste. Adbz. "24" = PSa generatu eta ikusi, "23" = PSa eta PDFa generatu,
# baina ez bata ez bestea ikusi ez.
#
my $mode  = $ARGV[0] || 3; # Modua:
                           # 1 -> .dvi soilik
			   # 2 -> .ps ere
			   # 3 -> .pdf ere
			   # 4 -> Ikus (PDF posible bada, bestela PS)

#
# Modua ondo dagoela ziurtatu
#
die "'$mode' argumentuak kompilazio opzio ezezagunak dauzka (1, 2, 3 edo 4)!\n" unless ($mode =~ /^[1234]+$/);

# Argumentu bakarra '4' bada, jarri '3' ere:
$mode = '34' if ($mode == 4);

#
# PostScript eta PDF bisoreak definitu
#
my $seeps  = 'gv';
my $seepdf = 'open';

#
# Otras variables
#
my $tmp    = 'tmp';
my $outps  = $f.'.ps';
my $outpdf = $f.'.pdf';

#
# Zeregin zerrenda sortu
#
my @list;
push(@list,"Utils/extract_lyx.pl");                                                 # LyX fitxerorik badago, LaTeX-era pasa
push(@list,"cp $f.tex $tmp.tex");                                                   # kompilatzeko fitxeroaren kopia temporala
push(@list,"pdflatex $tmp");                                                           # latex exekutatu
push(@list,"bibtex $tmp");                                                          # bibtex exekutatu
push(@list,"pdflatex $tmp");                                                           # bigarren kompilazioa, erref. gurutzatuetarako
push(@list,"pdflatex $tmp");                                                           # latex berriz exekutatu
#push(@list,"dvips -t $psize $tmp.dvi -o $tmp.ps >& /dev/null") unless ($mode == 1); # DVIa PS bihurtu
#push(@list,"mv $tmp.dvi Main.dvi") if ($mode =~ /1/);                               # DVIa gorde
#push(@list,"ps2pdf $tmp.ps") if ($mode =~ /3/ );                                    # PSa PDFan bihurtu
#push(@list,"mv -f $tmp.ps  $outps")  if ($mode =~ /2/);                             # PSaren kopia $outps-en gorde
push(@list,"mv -f $tmp.pdf $outpdf") if ($mode =~ /3/);                             # PDFaren kopia $outpdf-en gorde
#push(@list,"$seeps $outps >& /dev/null &") if ($mode =~ /4/ and $mode !~ /3/);      # PSa ireki, eta jarraitu
push(@list,"$seepdf $outpdf &")            if ($mode =~ /4/ and $mode =~ /3/);      # PDFa ireki, eta jarraitu
push(@list,"cp $tmp.log $f.log");
push(@list,"rm -f $tmp.*");                                                         # zaborra borratu

#
# Pasuek zenbat tardatu duten hartzeko
#
my $hasi = time(); # hasera data, +%s formatuan
my $oldt = $hasi;
my $str  = '';     # pasu guztiak dituen string-a

#
# Zerrendako pausuak exekutatu
#
foreach (@list)
{
  my $do = $_;

  my $ok  = 'OK';          # ea komandoa ondo bukatu den
  my $sys = system "$do";  # exekutatu komandoa, eta irteerako statusa harrapatu
  my $t   = time();
  my $dt  = $t-$oldt;      # pausuak iraun duen segundu kopurua
  my $dt0 = $t-$hasi;      # pausu horretarainoko denbora
  $oldt   = $t;            # pausua bukatu deneko unea
  if ($sys) { $ok = 'KO' } # ez-OK irteera statusa 0 ez bada

  #
  # Gorde informazioa, geroago pantailan ateratzeko
  #
  $str .= sprintf "%-50s   [ %2s ] %6is %6is\n",$do,$ok,$dt,$dt0;

  last if $sys;            # azken komandoak kale egin ezkero, irten
};

#
# Laburpena inprimatu
#
printf "\nLaburpena [ %1s ]:\n\n%-50s %8s %7s %7s\n\n%1s\n",$f,'Komandoa','Statusa','Pausua','Totala',$str;
