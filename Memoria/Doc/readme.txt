# Poner en el fichero .tcsh o .login, o ejecutar a mano:

setenv BIBINPUTS ::./Config # Esto hace que se busque el .bib en los sitios "habituales" (el ::),
                            # y en la carpeta Config dentro del directorio actual

setenv BSTINPUTS ::./Config # idem, para ficheros .bst

setenv TEXINPUTS ::./Config # idem, para el fichero .cls

# Para compilar

Utils/run_latex.pl

# o bien:

latex  Main.tex
bibtex Main
latex  Main.tex
latex  Main.tex
dvips -t a4 Main.dvi -o Main.ps
ps2pdf Main.ps

# Borrar los ficheros temporales:

rm -f Main.aux Main.b?? Main.toc Main.dvi Main.mtc* Main.log Main.ps

# Ver el resultado:

acroread Main.pdf
