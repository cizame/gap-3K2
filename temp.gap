KSQueens:=function( n )
    local C, X, queens,k;
    C := [];
    X:=1;
    return X;
end;

CCCantidadDeGrupos1:= function(a,b)
    local i,G;
    i:=1;
    for i in [a..b] do
        PrintTo("/dev/tty","Cardinalidad del grupo = ",i,"   \n");
        G:=AllGroups(i);
        PrintTo("/dev/tty","Cantidad de grupos = ",Length(G),"   \n");
    od;
end;

CCPosibleCuello := function ( T )
    local XX,T1,k, Multipli;
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
        XX := TT;
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
end;
