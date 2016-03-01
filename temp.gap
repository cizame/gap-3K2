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

