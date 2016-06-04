
LoadPackage("grape");

EsGraficaDeCayley := function (g)
    local aut,cc,reps,l,esono,i;
    aut := AutGroupGraph(g);
    if IsTransitive(aut,Vertices(g)) and Order(aut)=OrderGraph(g) then
        return true;
    else
        esono := false;
        cc := ConjugacyClassesSubgroups(aut);
        reps := List(cc,x->x[1]);
        l := List([1..Length(reps)],x->[x,Order(reps[x])]);
        l := Filtered(l,x->x[2]=OrderGraph(g));
    fi;
     for i in [1..Length(l)] do
        if  IsTransitive(reps[l[i][1]],Vertices(g))=true then
            return true;
        fi; 
    od;
    return false;
end;


Orbitas:= function(g)
    local orb, aut, l, x;
    aut := AutomorphismGroup(g);
    orb := Orbits(aut,Elements(g));
    l := List(orb,x->x[1]);
    return l;    
end;


ListaTBuenas := function ( g, a )
    local aut, l, l1, l2, i, orb, t, L;
    aut := AutomorphismGroup(g);
    l2 := [];
#    L := CCOrbitas(g);    
    L := Elements(g);
    if a=1 then
        l := Filtered(L, x-> Order(x)=3);
    else
        l := Filtered(L, x-> not Order(x)=3);
    fi;
    l1 := ShallowCopy(CCEliminaInversos(l));
    l := Set(CCPosiblesT(l1,a));
    orb := Orbits(aut,Set(l),OnSets);
    l := List(orb,x->x[1]);
    orb := [];
    if a=1 then
        for i in [1..Length(l)] do
            t := CCConjuntoT1(l[i][1],l[i][2],l[i][3]);
            if t<>fail then
                Add(l2,t);
            fi;
        od;
    else
        for i in [1..Length(l)] do
            t := CCConjuntoT2(l[i][1],l[i][2]);            
            if t<>fail then
                Add(l2,t);
            fi;
        od;
    fi;
    return l2;
end;

PosibleCuello := function( T )
    local XX, T1, k, Multipli;
    XX := ShallowCopy( T );
    T1 := [T[1]*T[1]^-1];
    Multipli := function (l)
        local i, j, TT, aux;
        TT := [];
        for j in [1..Length(XX)] do
            for i in [1..6] do
                Add(TT,XX[j]*T[i]);
            od;
        od;
        aux := Union(XX,T1);
        T1 := ShallowCopy(XX);
        TT := Set(TT);
        SubtractSet(TT,Set(aux));
        XX := Set(TT);
        if Length(XX) = 6*4^(l) then
            Multipli(l+1);
        else
            k := 2*(l+1);
        fi;
    end;
    if Length(XX) <> 6 then
        return fail;
    else
        Multipli(1);
    fi;
    return k;   
end;

ExaminaGrupo:= function(g, c, a)
    local l, l1, orb, aut, i, C, C1;
    l := ListaTBuenas(g,a);
    C := [];
    aut := AutomorphismGroup(g);
    orb := Orbits(aut,Set(l),OnSets);
    l := List(orb,x->x[1]);
    orb := [];
    for i in [1..Length(l)] do
        C[i] := [l[i],PosibleCuello(l[i])];
    od;    
    C1 := Filtered(C, i -> i[2] >= c);
    return C1;
end;



GraficaDePuntosYTriangulos := function(g)
    local triang,verts,ady,act,g2,TrivialAction;
    TrivialAction:= function(x,g) return x; end;
    ady := function(u,v)
        if not(IsList(u)) and IsList(v) then
            return u in v;
        else
            return false;
        fi;
    end;
    g2 := NewGroupGraph(Group(()),g);
    triang := Cliques(g2);
    return
      UnderlyingGraph(Graph(
              Group(()),
              Union(triang,Vertices(g)),
              TrivialAction,
              ady,
              true));
end;

TsParaCuelloDado:= function(g,c,a)
    local L, LG, i, GG, BG;
    LG := [];
    L := ExaminaGrupo(g,c,a);    
    for i in [1..Length(L)] do
        GG := CayleyGraph(g,L[i][1]);
        BG := Girth(GraficaDePuntosYTriangulos(GG));
        if BG>=2*c then
            Add(LG,[L[i][1],BG]);
        fi;
    od; 
    return LG;
end;


Prueba:= function(r1,r2,c,a)
    local i, j, k, A, L, LL;
    L := [];
    k := 0;
    for i in [r1..r2] do
        A := AllSmallGroups(i);
        for j in [1..Length(A)] do
            if IsAbelian(A[j])=false then
                LL := ExaminaGrupo(A[j],c,a);
                if LL<>[] then
                    k := k+1;
                    L[k] := [LL,i,j];
                    Print("\n k ", k );
                fi;                
            fi;            
        od;
        A := [];
    od;
    return L;    
end;

# M es una matriz de ceros y unos,
# cuyas filas representan los vertices y sus columnas las aristas
# Se coloca un uno en la entrada i,j si el vértice i esta en la arista j.
CuelloHG:= function( M )
    local Ciclo, ciclo , n, m, x, XX, EXX, C, cuello, cot, k;
    ciclo := [];
    cuello := infinity;
    cot := infinity;    
    XX := [];
    C := [];
    m := Length(M);    
    n := Length( M[1] );    
    Ciclo := function( l, v )
        local i, j, Posicion;
        i := 1;
        EXX := ShallowCopy(Length(XX)+1);        
        C[EXX]:=[];
        if l=1 then
            for j in [1..n] do
                C[1][j] := [0,j];
            od;            
        else
            while i <= m do
                if M[i][XX[l-1]] <> 0 and i <> v then
                    j := 1;
                    while j <= n do
                        if M[i][j] <> 0 and j <> XX[l-1] then
                            if j in XX then
                                Posicion :=  Positions(XX,j);
                                cuello := l - Posicion[1];
                                ciclo := XX{[Posicion[1]..l-1]};
                                cot := ShallowCopy(cuello);
                                i := m+1;
                                j := n+1;
                                C[EXX] := [];
                            else
                                Add( C[EXX], [i,j] );
                            fi;
                        fi;
                        j := j+1;
                    od;
                fi;
                i := i+1;
            od;
        fi;
#        Info(Info3k2,2,"C[",EXX,"]= ",C[EXX]);
        for x in C[EXX] do
            if l < cot  and cuello > 2 then
                XX := XX{[1..l-1]};
                XX[l] := x[2];
#               Info(Info3k2,1,"XX = ",XX);
                Ciclo( l+1, x[1]);
            fi;        
        od;
    end;    
    
    Ciclo(1, 0);
    
    if cuello = infinity then
        Print("La hipergŕafica es un hiperárbol y no tiene cuello \n");
    else
        Print("El cuello es ", cuello ," y se forma con las aristas ",(ciclo)," \n");
    fi;        
    return;
end;

# M es una matriz de ceros y unos,
# cuyas filas representan los vertices y sus columnas las aristas
# Se coloca un uno en la entrada i,j si el vértice i esta en la arista j.
# 
ExaminaCuelloHG:= function( M, CUELLO )
    local Ciclo, ciclo , n, m, x, XX, EXX, C, cuello, cot, k;
    ciclo := [];
    cuello := infinity;
    cot := infinity;    
    XX := [];
    C := [];
    m := Length(M);    
    n := Length( M[1] );    
    Ciclo := function( l, v )
        local i, j, Posicion;
        i := 1;
        EXX := Length(XX)+1;        
        C[EXX]:=[];
        if l=1 then
            for j in [1..n] do
                C[1][j] := [0,j];
            od;            
        else
            while i <= m do
                if M[i][XX[l-1]] <> 0 and i <> v then
                    j := 1;
                    while j <= n do
                        if M[i][j] <> 0 and j <> XX[l-1] then
                            if j in XX then
                                Posicion :=  Positions(XX,j);
                                cuello := l - Posicion[1];
                                if Posicion[1] = 1 then
                                    ciclo := XX;
                                else
                                    ciclo := Filtered (XX, x -> (x in XX{[1..(Posicion[1]-1)]}) = false);
                                fi;
                                cot := ShallowCopy(cuello);
                                i := m+1;
                                j := n+1;
                                C[EXX] := [];
                            else
                                Add( C[EXX], [i,j] );
                            fi;
                        fi;
                        j := j+1;
                    od;
                fi;
                i := i+1;
            od;
        fi;
        for x in C[EXX] do
            if l < cot  and cuello > CUELLO -1 then
                XX := XX{[1..l-1]};
                XX[l] := x[2];
                Ciclo( l+1, x[1]);
            fi;        
        od;
    end;    
    Ciclo(1, 0);
    if cuello > CUELLO - 1 then
        if cuello = infinity then
            Print("La hipergŕafica es un hiperárbol por lo cual no tiene cuello \n");
        else
            Print("El cuello es ", cuello ," y se forma con las aristas ",(ciclo)," \n");
        fi;        
    else
        Print("La gráfica tiene un ciclo de longitud ", cuello ," y se forma con las aristas ",(ciclo)," \n");
    fi;
    
    return;
end;


# Es una función que llena aleatoriamente una matriz de <M>(m) x (n)</M>
# donde las columnas representan las aristas de una gráfica y las filas
# sus vértices. La matriz es llenada en la entrada <M>ij</M> con un uno si
# el vértice <M>i</M> pertenece a la arista <M>j</M>.
# La función requiere dos argumentos, el numero de filas y el numero de
# columnas, en ese orden.
MatrizDeIncidencia := function( m , n )
    local M, i, j;
    M := [];
    for i in [1..m] do
        M[i] := [];
        for j in [1..n] do
            M[i][j] := Random(0,1);
        od;
    od;
    return M;
end;


# Es una función que llena aleatoriamente una matriz de <M>(m) x (n)</M>
# donde las columnas representan las aristas de una gráfica regular y 
# las filas sus vértices. Con gráfica regular me refiero a que
# cada vértice esta la misma cantidad de aristas y cada arista esta en la
# misma cantidad de vertices. 
# La matriz es llenada en la entrada <M>ij</M> con un uno si
# el vértice <M>i</M> pertenece a la arista <M>j</M> y cero si no.
# La función requiere tres argumentos: el numero de filas, el numero de
# columnas y el grado de los vértices, en ese orden.
MatrizDeIncidenciaGraficaRegular := function( m , n , g)
    local M, i, j;
    M := [];
    for i in [1..m] do
        M[i] := [];
        for j in [1..n] do
            M[i][j] := Random(0,1);
        od;
    od;
    return M;
end;


Aristas := function (M, L)
    local A, i, j;
    A := List([1..Length(L)], x -> []);
    for i in [1..Length(M)] do
        for j in [1..Length(L)] do
            Add(A[j],M[i][L[j]]);
        od;
    od;
    return A;
end;

# Jaula cuello 6, M3:=[ [ 1, 1, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 1, 1, 0, 0 ], [ 1, 0, 0, 0, 0, 1, 1 ], [ 0, 1, 0, 1, 0, 1, 0 ], [ 0, 1, 0, 0, 1, 0, 1 ], [ 0, 0, 1, 1, 0, 0, 1 ],  [ 0, 0, 1, 0, 1, 1, 0 ] ] ;


VerificicaModulo:=function(m)
    local n,i,L;
    L:=[];
    i:=1;
    for n in [1..m] do
        if RemInt(3*[2^(n-1)-1]*[2^n],n) <> 0 then
            L[i]:=[n,RemInt(3*[2^(n-1)-1]*[2^n],n)];
            i:=i+1;
        fi;
    od;
    Print(i);
    
    return L;
end;

        

ArbolMatriz:=function(cuello)
    local L,x,y,i,k,n;
    n := 2^(cuello)-1;    
    L:=List([1..n], y -> List([1..n], x -> 0));
    L[1][1]:=1;
    k:=2;    
    i:=1;
    while k < n do
        L[i][k] := 1;
        L[i][k+1] := 1;
        L[k][i] := 1;
        L[k+1][i]:= 1;
        k := k+2;
        i := i+1;            
    od;
    return L;
end;


# en lugar de matriz oy las aristas de la grafica como lista de listas
ArbolVector := function(n)
    local  L, i, j, arbol, st, st1;
    #    M:=List([1..n], y -> List([1..n], x -> 0));
    st := 2^(n)-1;
    L:=[[1,2,3]];
    arbol := function(l)
        local x;
        x:=l*4;
        if st>=x+3 then
            Append(L,[[l,x,x+1],[l,x+2,x+3]]);                       
            arbol(l+1);
        else
            return;
        fi;
    end;
    arbol(1);
    i := L[Length(L)][1]+1;
    st1 := 2^(n-1)-1;    
    for j in [i..st1] do
        Append(L,[[j],[j]]);
    od;            
    return L;
end;



# M es una matriz mxm que por un lado tine vertices y por otro lado aristas
# N es el cuello
# tt es la permanencia de cada vertice en T=la lista que no permite que salga tan pronto
HCGraficaImpar:=function(M,N,tt,max)
    local k,i,j,x,VV,AV,AV1,VV1,CV,Vivos,n,m,T,t;
    M:=StructuralCopy(M);
    
    VV := [];
    AV := [];
    AV1 := [];
    VV1 := [];
    CV := [];
    m := Length(M[1]);
    n := Length(M);
    Vivos := function(M)
        for i in [1..m] do
            VV[i] := 3-Sum(M[i]);
            if VV[i]>0 then
                Add(VV1,i);
            fi;
            AV[i] := 0;
            for j in [1..n] do
                AV[i] := AV[i]+M[j][i];
            od;
            AV[i] := 3-AV[i];
            if AV[i]>0 then
                Add(AV1,i);
            fi;
        od;
        return;
    end;
    Vivos(M);
    
#    Info(Info3k2,2,"Vértices vivos",VV1);
#    Info(Info3k2,2,"Aristas vivas",AV1);
#    Info(Info3k2,3,"No. conjuntos que faltan a los vértices vivos",VV);
#    Info(Info3k2,3,"No. vértices que faltan a aristas vivas",AV);
#    Print("\n Vértices vivos",VV1);
#    Print("\n Aristas vivas",AV1);
#    Print("\n No. conjuntos que faltan a los vértices vivos",VV);
    #    Print("\n No. vértices que faltan a aristas vivas",AV);
    
    CV[1] := [];
    CV[2] := [];
    CV[3] := [];
    CV[1] := VV1{[1..2^(N-2)]};
    CV[2] := VV1{[2^(N-2)+1..2^(N-1)]};
    CV[3] := VV1{[2^(N-1)+1..Length(VV1)]};
    T:=List([1..tt],x->0);
    
    while AV1 <> [] do
        k := RandomList(AV1);
        j := 1;   
        t := 0;
        
        while AV[k]>0 do
            i := RandomList(CV[j]);
            if not(i in T) then
                AV[k] := AV[k]-1;
                VV[i] := VV[i]-1;
                if VV[i]=0 then
                    CV[j] := Filtered(CV[j], x -> x<>i);
                fi;
                Append(T,[i]);
                Remove(T,1);     
                j := j+1;
                M[i][k] := 1;
            fi;            
            t:=t+1;
            if t > max then
                Print("Se cicló \n");
                
                return M;
            fi;                
        od;
        AV1 := Filtered(AV1, x -> x<>k);
#        Print(" AV1",AV1,"\n");
#        Print(" VV1",VV1,"\n");        
#        Print(" AV",AV,"\n");
#        Print(" VV",VV,"\n");
    od;
    return M;
end;


# Para prueba y error                          
PruebaError:=function(M,N,tt,max,k)
    local i;
    for i in [1..k] do
        CuelloHG(HCGraficaImpar(M,N,tt,max));
    od;    
end;

ListaAleatoriaDeElementosDeGrupo := function(G, n)
    local i, l;
    l := [];
    for i in [1..n] do
        Add(l, Random(G));
    od;
    return l;
end;

CCNewEliminaInversos := function( l )
    local pos, i, j;
    i := 1;
    while i <= Length(l) do
        pos := Positions(l, l[i]);
        if l[i] <> l[i]^(-1) then
            pos := Set(Concatenation(pos, Positions(l, l[i]^-1)));
        fi;
        Remove(pos, 1);
        j := 1;
        while j <= Length(pos) do
            Remove(l, pos[j]-j+1);
            j := j+1;
        od;
        i := i+1;
    od;
end;

#
# n es el cuello de la hipergráfica
# La función pretende llenar la submatriz con unos para asignar
# nuevos vertices a agunas aristas
# Vector es una funcion que llena un vector que me indica como asignar
# las aristas faltantes, forman siete ciclos con las aristas del arbol
# pero aun no se si forma cicls mas pequeños con las nuevas aristas
SubMatriz:=function(n)
    local N, M, i, j, Vector, L, n1, n2; 
    N := 2^(n-1);
    n1 := N/4;
    n2 := N/2;
    M := List( [1..N], i -> List( [1..N], j -> 0 ) );   
    Vector := function(l)
        local x, L1, aux;
        L1 := [];
        aux:= 2^(n-4-l);
        for x in L do
            Add (L1, x+aux);
        od;
        Append (L, L1);
        if aux > 1 then
            Vector (l+1);
        else
            return;
        fi;
    end;
    L := [1];
    Vector(0);
    Print(L);
    for i in [1..Length(L)] do
        M[i][2*i - 1] := 1;
        M[i + n1][2*i] := 1;
        M[i + n2][2*i - 1] := 1;
        M[i + n2 + n1][2*i] := 1;
        M[i][2*i - 1 + n2] := 1;
        M[i + n1][2*i + n2] := 1;
#        M[i + n2][2*i - 1 + n2] := 1;
#        M[i + n2 + n1][2*i + n2] := 1;
    od;    
    return M;
end;


VectorSubGrafica:=function(n)
    local N, Vector, L; 
    N := 2^(n-1);
#    n1 := N/4;
#    n2 := N/2;
    Vector := function(l)
        local x, L1, aux;
        L1 := [];
        aux:= 2^(n-4-l);
        for x in L do
            Add (L1, x+aux);
        od;
        Append (L, L1);
        if aux > 1 then
            Vector (l+1);
        else
            return;
        fi;
    end;
    L := [1];
    Vector(0);
    return L;
end;

#LA función crea una hipergráfica representada como lista de aristas
# Cada sublista "i" de la lista contiene los vertices que pertenecen
# a dicha arista.
# La funcion no es aleatoria, primero crea las aristas correspondientes
# al arbol necesario para formar una jaula (el de la cota de  Moore).
# y despues llena ciertas aristas que no forman ciclos pequeños.
# Recive como argumento al cuello.


GraficaAristas := function(n)
    local L1, L2, i, m1, m2, m3;
    L1 := ArbolVector(n);    
    L2 := VectorSubGrafica(n);
    m1 := 2^(n-1);
    m2 := 2^(n-2);
    m3 := 2^(n-3);
    for i in [1..Length(L2)] do
        Add(L1[ m1 + 2*(L2[i]-1) ], m1 + i - 1);
        Add(L1[ m1 + 2*(L2[i]-1) + 1 ], m1 + m3 + i - 1);
        Add(L1[ m1 + 2*(L2[i]-1) + m2], m1 + i - 1+m2);
        Add(L1[ m1 + 2*(L2[i]-1) + 1+ m2], m1 + m3 + i - 1+m2);
    od;
    return L1;
end;


#La funcion recuce una hipergráfica representada por su lista de aristas
#y devuelve una hipergráfica representada por su lista de vertices 
AristasAVertices:=function(LA)
    local LV, i,j,k, aux,n;
    k := Length(LA);
    aux := Set(Concatenation(LA));
    RemoveSet(aux,0);   
    n := Length(aux);                       
    LV := List ([1..n], i -> []);
    for i in [1..k] do
        for j in [1..Length(LA[i])] do
            Add(LV[LA[i][j]],i);
        od;
    od;
    return LV;
end;

                       
                       
#La funcion calcula el ciclo más pequeño en el que se encuentra la arista
# recive como argumento una hipergráfica representada como la lista de aristas
# i.e. cada sublista "i" de la lista contiene los vertices que pertenecen
# a dicha arista.
# recive la arista y graafica representada por sus aristas;

CicloMenorConLaAristaFallido := function (arista , LA)
    local LV, XX, C, ciclo, X, cot, Ciclo,i, Vo;
    LV := AristasAVertices(LA);
    cot := infinity;    
    XX := [[PositionSet(LA,arista),0]];
    if XX[1][1] = fail then
        Print("La arista no pertenece a la gráfica \n");
        return fail;
    fi;
    ciclo:=[];
    C:=[];   
    Vo:=[0];
    
    C[1] := [XX[1]];
    Ciclo:= function(l)
        local x,y,p;
        C[l]:=[];              
        for x in LA[XX[l-1][1]] do
            if (x in Vo)=false then
                for y in LV[x] do
                    if y <> XX[l-1][1] then
                        p := PositionSet(XX,[y,x]);
                        if  p = fail or p=1 then
                            if y=XX[1][1] then
                                cot := l-1;
                                Add(XX,[y,x]);
                                ciclo :=StructuralCopy(XX);
                                C[l] := [];
                            else
                                Add(C[l],[y,x]);
                            fi;
                        fi;
                    fi;
                od;
            fi;
        od;
        for x in C[l] do
            if l < cot then
                XX := XX{[1..l-1]};
                Add(XX,x);
                Vo := Vo{[1..l-1]};
                Add(Vo,x[2]);                
                Ciclo( l+1);
            fi;        
        od;
    end;    
    Ciclo(2);
    if cot = infinity then
        Print("La hiperarista no pertenece a algún ciclo \n");
        return fail;
    else
        X:=[];
        for i in [2..cot+1] do
            Add(X,ciclo[i][2]);
        od;
        Add(X,ciclo[2][2]);
        Print("La longitud del ciclo es ", cot ," y es ",X," \n");
        return ciclo;
    fi;        
end;



CicloMenorConLaArista := function (arista , LA)
    local LV, XX, C, ciclo, X, cot, Ciclo,i, Vo;
    LV := AristasAVertices(LA);
    cot := infinity;    
    XX := [[PositionSet(LA,arista),0]];
    if XX[1][1] = fail then
        Print("La arista no pertenece a la gráfica \n");
        return fail;
    fi;
    ciclo:=[];
    C:=[];   
    Vo:=[0];
    C[1] := [XX[1]];
    Ciclo:= function(l)
        local x,y,p;
        C[l]:=[];              
        for x in LA[XX[l-1][1]] do
            if (x in Vo)=false then
                for y in LV[x] do
                    if y <> XX[l-1][1] then
                        p := PositionSet(XX,[y,x]);
                        if  p = fail or p=1 then
                            if y=XX[1][1] then
                                cot := l-1;
                                Add(XX,[y,x]);
                                ciclo :=StructuralCopy(XX);
                                C[l] := [];
                            else
                                Add(C[l],[y,x]);
                            fi;
                        fi;
                    fi;
                od;
            fi;
        od;
        for x in C[l] do
            if l < cot then
                XX := XX{[1..l-1]};
                Add(XX,x);
                Vo := Vo{[1..l-1]};
                Add(Vo,x[2]);                
                Ciclo( l+1);
            fi;        
        od;
    end;    
    Ciclo(2);
    if cot = infinity then
        Print("La hiperarista no pertenece a algún ciclo \n");
        return fail;
    else
        X:=[];
        for i in [2..cot+1] do
            Add(X,ciclo[i][2]);
        od;
        Add(X,ciclo[2][2]);
        Print("La longitud del ciclo es ", cot ," y es ",X," \n");
        return ciclo;
    fi;        
end;




