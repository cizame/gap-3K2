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
   l1:=[];  
    
    for i in [1..Length(l)] do
        if not (l[i] in l1) and not (l[i]^-1 in l1) then 
            l1:=Union(l1,[l[i]]);
        fi;  
    od;
    
    return l1;
end);

#F  CCConjuntoT1( a,b,c ) 
##
InstallGlobalFunction( CCConjuntoT1, function( a,b,c )
        local l;
    l := [a,a^-1,b,b^-1,c,c^-1];

    if Length(Set(l)) <> 6 then
        return fail;
    elif
        Order(a)<>1 or Order(b) or Order(c) then
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

#F  CCCantidadDeGrupos( a,b ) 
##
InstallGlobalFunction( CCCantidadDeGrupos, function( a,b )
    local i,j,G;
    for i in [a..b] do
        PrintTo("/dev/tty","cardinalidad del grupo = ",i,"   \n");
        G:=AllGroups(i);
        PrintTo("/dev/tty","cantidad de grupos = ",Length(G),"   \n");
    od; 
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
        SubtractSet(Set(TT),Set(aux));
        XX := Set(TT);
        Print("medida tt= ",Length(XX));
        
        if Length(XX) = 6*4^(l+1) then
            Multipli(l+1);
        else
            k := l;
        fi;
    end;
    if Length(XX) <> 6 then
        return fail;
    else
        Multipli(1);
        Print("El cuello de la gráfica generada por",T," es ", 2*k ," o ", 2*k+1," .\n");
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
            if a=3 then
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
