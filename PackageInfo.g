SetPackageInfo( rec(
  PackageName := "3K2",
  Version := "1.0",
##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "1.0">
##  <!ENTITY RELEASEDATE "16 February 2016">
##  <#/GAPDoc>

  PackageDoc := rec(
      BookName  := "3K2",
      SixFile   := "doc/manual.six",
      Autoload  := true ),
  Dependencies := rec(
      GAP       := "4.5",
      NeededOtherPackages := [ ["GAPDoc", "1.3"] ],
      SuggestedOtherPackages := [ ["GRAPE", "4.6.1"] ] ),
  AvailabilityTest := ReturnTrue ) );
