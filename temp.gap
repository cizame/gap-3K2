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


ExaminaGrupo:= function(g,a)
    local l, l1, orb, aut, i, C;
    l := CCListaTBuenas(g,a);
    C := [];
    # Print(Length(l),"\n");
    # aut := AutomorphismGroup(g);
    # Print(IsSet(Set(l)),"\n");
    # orb := Orbits(aut,Set(l),OnSets);
    # l := List(orb,x->x[1]);
    # orb := [];
    # Print(Length(l),"\n");
    for i in [1..Length(l)] do
        C[i] := CCPosibleCuello(l[i]);
    od;
    return C;
end;
