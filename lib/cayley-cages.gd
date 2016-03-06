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
##  de Cayley localmente <M>3K_{2}</M> que se quiera verificar. La función regresa 
##  una nueva lista donde cada entrada contiene dos o tres elementos, según sea el caso, de la lista original. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCPosiblesT" );

#F  CCEsGraficaDeCayley( G ) 
##
##  <#GAPDoc Label="CCEsGraficaDeCayley">
##  <ManSection>
##  <Func Name="CCEsGraficaDeCayley" Arg="gráfica"/>
##
##  <Description>
##  Recibe una gráfica <M>G</M> y verifica si <M>G</M> es de Cayley o no,
##  en caso afirmativo regresa true o de lo contrario false.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCEsGraficaDeCayley" );

#F  CCOrbitas( g ) 
##
##  <#GAPDoc Label="CCOrbitas">
##  <ManSection>
##  <Func Name="CCOrbitas" Arg="grupo"/>
##
##  <Description>
##  Recibe un grupo, y calcula las orbitas del conjunto de elementos del
##  grupo, usando el grupo de automorfismos del mismo grupo. Regresa una 
##  lista con un representante de cada orbita. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCOrbitas" );

#F  CCListaTBuenas( g, a ) 
##
##  <#GAPDoc Label="CCListaTBuenas">
##  <ManSection>
##  <Func Name="CCListaTBuenas" Arg="grupo, número_1_o_2"/>
##
##  <Description>
##  Recibe dos parametros el primero es un grupo y el segundo es
##  el número uno o dos, según sea el caso de las condiciones para
##  construir gráficas de Cayley localmente <M>3K_2</M>. La función
##  regresa una lista, cuyos elementos son conjuntos de seis elementos del 
##  grupo dado, los cuales construyen gráficas de Cayley localmente
##  <M>3K_2</M>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCListaTBuenas" );

#F  CCExaminaGrupo( g, a ) 
##
##  <#GAPDoc Label="CCExaminaGrupo">
##  <ManSection>
##  <Func Name="CCExaminaGrupo" Arg="grupo, número_1_o_2"/>
##
##  <Description>
##  Recibe tres argumentos el primero es un grupo, el segundo es el
##  tamaño del cuello de triángulos que se desea y el tercero es el número
##  uno o dos según sea el caso de acuerdo al tipo, uno o dos, de gráficas de
##  Cayley Localmente <M>3K_2</M> que se quiera construir. A partir de los 
##  elementos del grupo se construyen conjuntos que generen gráficas de Cayley 
##  localmente <M>3K_2</M> y los filtra usando los valores de los posibles
##  cuellos, finalmente regresa una lista cuyos elementos son listas con dos
##  entradas, la primera es el conjunto <M>T</M> que genera una gráfica de
##  Cayley localmente <M>3K_2</M> y la segunda el cuello más grande que podría
##  tener dicha gráfica.  
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCExaminaGrupo" );

#F  CCGraficaDePuntosYTriangulos( g ) 
##
##  <#GAPDoc Label="CCGraficaDePuntosYTriangulos">
##  <ManSection>
##  <Func Name="CCGraficaDePuntosYTriangulos" Arg="gráfica"/>
##
##  <Description>
##  Recibe una gráfica localmente <M>3K_2</M> y regresa su gráfica
##  bipartita clánica.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCGraficaDePuntosYTriangulos" );

#F  CCTsParaCuelloDado( g, c, a ) 
##
##  <#GAPDoc Label="CCTsParaCuelloDado">
##  <ManSection>
##  <Func Name="CCTsParaCuelloDado" Arg="grupo, cuello_de_triángulos, número"/>
##
##  <Description>
##  Recibe tres parametros: un grupo, el cuello de triangulos que se desea y
##  el número uno o dos según sea el caso de acuerdo al tipo de gráficas de
##  Cayley localmente <M>3K_2</M> que se quiera construir. La función regresa
##  una lista  cuyos elementos son listas con dos
##  entradas, la primera es el conjunto <M>T</M> que genera una gráfica de
##  Cayley localmente <M>3K_2</M> con el cuello de triangulos que se desea y
##  la segunda es el cuello de su grafica bipartita clánica.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "CCTsParaCuelloDado" );
