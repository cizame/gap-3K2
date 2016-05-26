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
