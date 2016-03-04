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
##  <Func Name="CCConjuntoT1" Arg="elemento, elemento, elemento"/>
##
##  <Description>
##  Requiere tres elementos de un mismo grupo <M>a</M>, <M>b</M> y <M>c</M>.
##  Verifica que estos elementos cumplan con las condiciones necesarias para
##  crear una gráfica de Cayley localmente <M>3K_2</M> del tipo uno.
##  En caso de cumplir las condiciones regresa la lista de seis elementos
##  <M>[a,a^{-1},b,b^{-1},c,c^{-1}]</M>, de lo contrario regresa fail.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCConjuntoT1" );

#F  CCConjuntoT2( a,b ) 
##
##  <#GAPDoc Label="CCConjuntoT2">
##  <ManSection>
##  <Func Name="CCConjuntoT2" Arg="elemento, elemento"/>
##
##  <Description>
##  Requiere dos elementos de un mismo grupo <M>a</M> y <M>b</M>.
##  Verifica que estos elementos cumplan con las condiciones necesarias 
##  para crear una gráfica de Cayley localmente <M>3K_2</M> del tipo dos.
##  En caso de cumplir las condiciones regresa la lista de seis elementos 
##  <M>[a,a^{-1},b,b^{-1},a^{-1}b,b^{-1}a]</M>, de lo contrario regresa fail.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCConjuntoT2" );

#F  CCCantidadDeGrupos( a,b ) 
##
##  <#GAPDoc Label="CCCantidadDeGrupos">
##  <ManSection>
##  <Func Name="CCCantidadDeGrupos" Arg="número, número"/>
##
##  <Description>
##  Recibe dos números naturales, los que se interpretan como
##  un intervalo en el cual se desea saber la cantidad de 
##  grupos de orden <M>i</M> con <M>i \in [a,b]</M>, para cada <M>i</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCCantidadDeGrupos" );

#F  CCPosibleCuello( T ) 
##
##  <#GAPDoc Label="CCPosibleCuello">
##  <ManSection>
##  <Func Name="CCPosibleCuello" Arg="lista"/>
##
##  <Description>
##  Recibe una lista <M>T</M> de seis elementos de un grupo;
##  <M>T</M> es un conjunto que genera una gráfica de Cayley localmente <M>3K_2</M>.
##  La función revisa cuales son los dos tamaños posibles de "cuello de triángulos" 
##  de la gráfia de Cayley generada por <M>T</M> y lo reporta.   
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCPosibleCuello" );

#F  CCPosiblesT( l, a ) 
##
##  <#GAPDoc Label="CCPosiblesT">
##  <ManSection>
##  <Func Name="CCPosiblesT" Arg="lista, número_1_o_2"/>
##
##  <Description>
##  Recibe dos argumentos, el primero es una lista de elementos de un grupo,
##  el segundo es el número uno o dos, según la candición para crear gráficas
##  de Cayley localmente <M>3K_{2}</M> que se quiera verificar.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCPosiblesT" );
