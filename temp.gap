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



ListaTBuenas := function ( g, a )
    local aut, l, l1, l2, i, orb, t;
    aut := AutomorphismGroup(g);
    l2 := [];
    if a=1 then
        l := Filtered(Elements(g), x-> Order(x)=3);
    else
        l := Filtered(Elements(g), x-> not Order(x)=3);
    fi;
        Print(l,"\n");
    l1 := ShallowCopy(CCEliminaInversos(l));
    l := Set(CCPosiblesT(l1,a));
    orb := Orbits(aut,Set(l),OnSets);
    l := List(orb,x->x[1]);
    orb := [];
        Print(Length(l),"\n");

    if a=1 then
        for i in [1..Length(l)] do
                Print(l[i],"\n");

            t := CCConjuntoT1(l[i][1],l[i][2],l[i][3]);
             Print("t=",t,"\n");
            if t<>fail then
                Add(l2,t);
            fi;
        od;
    else
        for i in [1..Length(l)] do
            t := CCConjuntoT2(l[i][1],l[i][2]);
            Print("t=",t,"\n");
            
            if t<>fail then
                Add(l2,t);
                Print(l2,"\n");
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
    l := CCListaTBuenas(g,a);
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
    L := CCExaminaGrupo(g,c,a);    
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
                LL := CCExaminaGrupo(A[j],c,a);
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
    
