#############################################################################
##
##
#W  cayley-cages.gd       cayley-cages Package             
##
##  Declaration file for cayley-cages functions
##
#############################################################################

#F  CheckKnapsackInput( <P>, <W>, <M> ) 
##
##  <#GAPDoc Label="CheckKnapsackInput">
##  <ManSection>
##  <Func Name="CheckKnapsackInput" Arg="profits, weights, capacity"/>
##
##  <Description>
##  Checks for valid input data for the Knapsack problems (Problems 1.1-1.4).
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CheckKnapsackInput" );

#F  IsCayleyCage( s ) 
##
##  <#GAPDoc Label="IsCayleyCage">
##  <ManSection>
##  <Func Name="IsCayleyCage" Arg="numero"/>
##
##  <Description>
##  la funcion solo imprime el numero que le des 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "IsCayleyCage" );

#F  CCEliminaInversos( l ) 
##
##  <#GAPDoc Label="CCEliminaInversos">
##  <ManSection>
##  <Func Name="CCEliminaInversos" Arg="lista"/>
##
##  <Description>
##  La función requiere una lista de elementos de un grupo y regresa la lista sin invrsos.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCEliminaInversos" );
