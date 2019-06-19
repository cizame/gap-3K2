SetPackageInfo( rec(
  PackageName := "3K2",
  Version := "0.1",
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "0.1">
##  <!ENTITY RELEASEDATE "16 February 2016">
##  <#/GAPDoc>
  Subtitle := "Locally 3K2 graphs",
  Date := "19/06/2019",
  ArchiveURL := "https://github.com/cizame/gap-3K2",
  ArchiveFormats := ".tar.gz",
  Status := "dev",
  README_URL := "https://github.com/cizame/gap-3K2",
  PackageInfoURL := "https://github.com/cizame/gap-3K2/blob/master/PackageInfo.g",
  AbstractHTML :=
  "The <span class=\"pkgname\">3K2</span> package, provides basic functions for working with locally 3K_2 graphs.",
  PackageWWWHome := "https://github.com/cizame/gap-3K2",
  PackageDoc := rec(
                     BookName  := "3K2",
                     ArchiveURLSubset := ["doc"],
                     HTMLStart := "doc/chap0.html",
                     PDFFile   := "doc/manual.pdf",
                     SixFile   := "doc/manual.six",
                     LongTitle := "Locally 3K_2 graphs",
                     Autoload  := true ),
  Dependencies := rec(
      GAP       := "4.5",
      NeededOtherPackages := [ ["GAPDoc", "1.3"] ],
      SuggestedOtherPackages := [ ["GRAPE", "4.6.1"] ] ),
  AvailabilityTest := ReturnTrue ) );
