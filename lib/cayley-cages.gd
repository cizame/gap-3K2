#############################################################################
##
##
#W  cayley-cages.gd       cayley-cages Package             
##
##  Declaration file for cayley-cages functions
##
#############################################################################

#F  CCEliminaInversos( l ) 
##
##  <#GAPDoc Label="CCEliminaInversos">
##  <ManSection>
##  <Func Name="CCEliminaInversos" Arg="lista"/>
##
##  <Description>
##  La función requiere una lista de elementos de un grupo y regresa la lista sin inversos.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCEliminaInversos" );

#F  CCConjuntoT1( a,b,c ) 
##
##  <#GAPDoc Label="CCConjuntoT1">
##  <ManSection>
##  <Func Name="CCConjuntoT1" Arg="elemento,elemento,elemento"/>
##
##  <Description>
##  Requiere tres elementos de un mismo grupo <M>a</M>, <M>b</M> y <M>c</M>.
##  Verifica que estos elementos cumplan con las condiciones necesarias para cear una gráfica de Cayley localmente <M>3K_2</M> del tipo uno.
##  En caso de cumplir las condiciones regresa la lista de seis elementos <M>[a,a^{-1},b,b^{-1},c,c^{-1}]</M>, de lo contrario regresa fail.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCConjuntoT1" );
