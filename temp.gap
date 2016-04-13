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
            if l < cot - 1 and cuello > 2 then
                XX := XX{[1..l-1]};
                XX[l] := x[2];
                Ciclo( l+1, x[1]);
            fi;        
        od;
    end;    
    Ciclo(1, 0);
    Print("El cuello es ", cuello ," y se forma con las aristas ",(ciclo)," \n");
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
            if l < cot - 1 and cuello > CUELLO -1 then
                XX := XX{[1..l-1]};
                XX[l] := x[2];
                Ciclo( l+1, x[1]);
            fi;        
        od;
    end;    
    Ciclo(1, 0);
    if cuello > CUELLO - 1 then
        Print("El cuello es ", cuello ," y se forma con las aristas ",(ciclo)," \n");
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



