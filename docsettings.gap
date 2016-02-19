# Useful to create GAP documentation of this package

path := Directory("./doc");;
main := "main.xml";;
files := ["../lib/cayley-cages.gd", "../lib/cayley-cages.gi","../PackageInfo.g"];;
bookname := "3K2";;

MakeGAPDocDoc(path, main, files, bookname);;
