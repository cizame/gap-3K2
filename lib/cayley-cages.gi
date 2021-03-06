#############################################################################
##
##
#W  cayley-cages.gi       cayley-cages Package             
##
##  Installation file for cayley-cages functions
##
#############################################################################

#F  CCEliminaInversos( <l> ) 
##
InstallGlobalFunction( CCEliminaInversos, function( l )
   local l1,i;
   l1 := [];  
    for i in [1..Length(l)] do
        if not (l[i] in l1) and not (l[i]^-1 in l1) then 
            l1 := Union(l1,[l[i]]);
        fi;  
    od;
    
    return l1;
end);

#F  CCConjuntoT1( a,b,c ) 
##
InstallGlobalFunction( CCConjuntoT1, function( a,b,c )
        local l;
    l := Set([a,a^-1,b,b^-1,c,c^-1]);
    if Length(Set(l)) <> 6 then
        return fail;
    elif
        Order(a)<>3 or Order(b)<>3 or Order(c)<>3 then
        return fail;        
    elif
      a*b = c^-1 then
        return fail;
    elif
      a*b = c then
        return fail;
    elif
      a*b^-1 = c then
        return fail;
    elif
      a*b^-1 = c^-1 then
        return fail;
    elif
      a*c = b then
        return fail;
    elif
      a*c = b^-1 then
        return fail;
    elif
      a*c^-1 = b then
        return fail;
    elif
      a*c^-1 = b^-1 then
        return fail;
    else
        return l;
    fi;
end);

#F  CCConjuntoT2( a,b ) 
##
InstallGlobalFunction( CCConjuntoT2, function( a,b )
        local l;
    if Order(a)<>3 and Order(b)<>3 and Order(a^-1*b)<>3 then 
        l :=Set([a,a^-1,b,b^-1,a^-1*b,b^-1*a]);
        if Length(l) <> 6 then
            return fail;
        elif
          Order(a^-1*b) = 3 then
            return fail;
        elif
          b = a^3 then
            return fail;
        elif
          b^-1 = a^2 then
            return fail;
        elif
          b^2 = a^-1 then
            return fail;
        elif
          a*b = b^-1*a then
            return fail;
        elif
          a^2 = b^2 then
            return fail;
        elif
          a*b = b*a then
            return fail;
        elif
          a^-1*b = a*b^-1*a then
            return fail;
        elif
          a*b = b*a^-1 then
            return fail;
        else
            return l;
        fi;
    else
        return fail;
    fi;
end);

#F  CCCantidadDeGrupos( a, b ) 
##
InstallGlobalFunction( CCCantidadDeGrupos, function( a, b )
    local i,j,G,k;
    G := [];
    k := 0;
    for i in [a..b] do
        Add(G, [i,NumberSmallGroups(i)]);
    od;    
    for i in [1..b-a+1] do
        k:= G[i][2]+k;       
    od;
    Print("La cantidad de grupos es ", k,".\n");    
    return G;    
end);

#F  CCPosibleCuello( T ) 
##
InstallGlobalFunction( CCPosibleCuello, function( T )
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
end);

#F  CCPosiblesT( l , a ) 
##
InstallGlobalFunction( CCPosiblesT, function( l, a )
    local i, j, k, m, L;
    L := [];
    if a=1 then
        m := Length(l)-2;
    else
        m := Length(l)-1;
    fi;
    for i in [1..m] do
        for j in [i+1..m+1] do
            if a=1 then
                for k in [j+1..m+2] do
                    Add(L,[l[i],l[j],l[k]]);
                od;
            else
                Add(L,[l[i],l[j]]);
            fi;
        od;
    od;
    return L;    
end);

#F  CCEsGraficaDeCayley( G ) 
##
InstallGlobalFunction( CCEsGraficaDeCayley, function( G )
    local aut,cc,reps,l,esono,i;
    aut := AutGroupGraph(G);
    if IsTransitive(aut,Vertices(G)) and Order(aut)=OrderGraph(G) then
        return true;
    else
        esono := false;
        cc := ConjugacyClassesSubgroups(aut);
        reps := List(cc,x->x[1]);
        l := List([1..Length(reps)],x->[x,Order(reps[x])]);
        l := Filtered(l,x->x[2]=OrderGraph(G));
    fi;
     for i in [1..Length(l)] do
        if  IsTransitive(reps[l[i][1]],Vertices(G))=true then
            return true;
        fi; 
    od;
    return false;
end);

#F  CCOrbitas( g ) 
##
InstallGlobalFunction( CCOrbitas, function( g )
    local orb, aut, l, x;
    aut := AutomorphismGroup(g);
    orb := Orbits(aut,Elements(g),OnPoints);
    l := List(orb,x->x[1]);
    return l;    
end);

#F  CCListaTBuenas( g, a ) 
##
InstallGlobalFunction( CCListaTBuenas, function( g, a )
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
end);

#F  CCExaminaGrupo( g, c, a ) 
##
InstallGlobalFunction( CCExaminaGrupo, function( g,c,a )
    local l, l1, orb, aut, i, C, C1;
    l := CCListaTBuenas(g,a);
    C := [];
    aut := AutomorphismGroup(g);
    orb := Orbits(aut,Set(l),OnSets);
    l := List(orb,x->x[1]);
    orb := [];
    for i in [1..Length(l)] do
        C[i] := [l[i],CCPosibleCuello(l[i])];
    od;    
    C1 := Filtered(C, i -> i[2] >= c);
    return C1;                         
end);

#F  CCGraficaDePuntosYTriangulos( g ) 
##
InstallGlobalFunction( CCGraficaDePuntosYTriangulos, function( g )
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
end);

#F  CCTsParaCuelloDado( g, c, a ) 
##
InstallGlobalFunction( CCTsParaCuelloDado, function( g, c, a )
    local L, LG, i, GG, BG;
    LG := [];
    L := CCExaminaGrupo(g,c,a);    
    for i in [1..Length(L)] do
        GG := CayleyGraph(g,L[i][1]);
        BG := Girth(CCGraficaDePuntosYTriangulos(GG));
        if BG>=2*c then
            Add(LG,[L[i][1],BG]);
        fi;
    od; 
    return LG;
end);
