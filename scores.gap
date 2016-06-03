LoadPackage("hypergraphs");

Arbol := function(n)
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
    return L;
end;

    
HipergraficaIntento:= function (cuello)
    local i,j,k,ii,B1,B2,B3,HG,particion,bandera,a;
    HG := HHypergraph(Arbol(cuello));
    particion := 2^(cuello-2);
#    B1 := [particion..2*particion-1];
#    B2 := [2*particion..3*particion-1];
#    B3 := [3*particion..4*particion-1];
    i:=particion;
    j:=2*particion;
    k:=3*particion;
    for ii in [1,2] do
        while i < 2*particion do
            bandera := 1;
            while j < 3*particion and bandera = 1 do
                if HDistance(HG,i,j) >= cuello-1 then
                    while k < 4*particion and bandera = 1 do
                        a := HDistance(HG,j,k);
                        if a >= cuello-1 and HDistance(HG,i,k) >= cuello-1 then
                            HG:=HHypergraph(Union(Edges(HG),[[i,j,k]]));
                            bandera:=0;
                        fi;
                        k:=k+1;
                    od;
                    k:=3*particion;
                fi;
                j:=j+1;
            od;
            j:=2*particion;
            i:=i+1;
        od;
        i:=particion;
    od;
    return (HG);
end;

    
        

:=function(HG,cuello)
    local posicion,Distancias,Ind,L1,L2,L3;
    Ind := IndexOfEdges(HG);;
    posicion := 2^(cuello-2);
    L1 := Filtered([posicion..4*posicion],x->Length(In.(x))=1);
    L2 := Filtered([posicion..4*posicion],x->Length(In.(x))=2);
    L3 := Filtered([posicion..4*posicion],x->Length(In.(x))=3);
    
    
    
    
    
    
        
