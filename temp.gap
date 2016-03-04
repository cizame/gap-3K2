CCPosibleCuello := function ( T )
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
end;


CCPosiblesT := function ( l,a )    
    local i, j, k, m, L;
    L := [];
    if a=3 then
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
end;



# ExaminaGrupoCondicionUno := function (g,grupo,CUELLO)  # Recibe un grupo
#     local i,c,c1,l,l1,t,t1,tbuena,seis,aut,orbs,reps,reps1,OrdendeG,GrupoGenerado,Orden,g1,sinc,AUX,numdegraf,Cay;
#     aut := AutomorphismGroup(g);
#       numdegraf:=[];
#     g1:=Filtered(Elements(g), x-> not x in Centre(g) and Order(x)=3);
#     l1:=EliminaInversos(g1);
#     l:=[];
#     g1:=[];
#     if Length(l1)>2 then
#     c1:=CombinacionesDe3(l1,g);
#     l1:=[];
#     if Length(c1)>0 then
#         OrdendeG:=Order(g);
#         c:=[];
#         orbs := Orbits(aut,c1,OnSets);
#         c1 := List(orbs,x->x[1]);
#         for i in [1..Length(c1)] do 
#             GrupoGenerado:=Group(c1[i]);    
#             Orden:=Order(GrupoGenerado); 
#             if Orden = OrdendeG then   
#                 c:=Union(c,[c1[i]]);
#             fi;
#         od;
#         c1:=[];
#         if Length(c)>0 then
#            tbuena :=[];
#             orbs:=[];
#             reps:=c;
#             c:=[];
#             for i in [1..Length(reps)] do
#                 t := reps[i];
#                 if Length(t)=3 then   
#                     seis := ConjuntoTPrimero(t[1],t[2],t[3]);
#                     if seis <> fail then
#                         tbuena:=Union(tbuena,[seis]);
#                     fi;
#                 fi;
#             od;
#             reps:=[];
#             tbuena := Set(tbuena,Set);
#             orbs := Orbits(aut,tbuena,OnSets);
#             reps := List(orbs,x->x[1]);
#             Print("Hay  ", Length(reps[1]) ," trios buenos.\n");
#             orbs:=[];
#             Cay:= List(reps,x->CayleyGraph(g,x));
#             AUX:=Filtered(Cay,x->Adyacencia(x,CUELLO/2)<>fail);
#             Print("Despues de usar adyacencias hay ",Length(AUX)," graficas posibles para verificar el cuello\n");
#             numdegraf:=ListadeGraficas(AUX,grupo,CUELLO);
#             Cay:=[];
#             if Length(numdegraf)>0 then
#                 Print("Ahy ",Length(numdegraf)," graficas con el cuello que deseas \n");
#                 Print("La mas chica tiene orden = ", OrderGraph(numdegraf[1]) ,"\n");
#             fi;
#             reps1:=[];
#             AUX:=[];
#             c:=[];
#         fi;
#      fi;
#  fi;

#     aut:=[];

#     return numdegraf;

# end;
