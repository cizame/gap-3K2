LoadPackage("hypergraphs");

NewBlocks := function(v,g)
    local IsAdmissibleBlock, Ind, deg, DegreeSum, B, LiveVertices, IndexLiveVertices, Switch, stop;
    deg := function(H, x)
        Ind := IndexOfEdges(H);
        return Length(Ind.(x));
    end;
    IsAdmissibleBlock := function(B , P)
        local H, pairs, p, i, isit;
        H := HHypergraph([1..v], B);
        i := 0;
        isit := true;
        while isit and i < Length(P) do
            i := i+1;
            isit := deg(H, P[i]) < Length(P);
        od;
        pairs := Combinations(P, 2);
        i := 0;
        while isit and i < Length(pairs) do
            i := i+1;
            p := pairs[i];
            isit := (HDistance(H, p[1], p[2]) >= g-1);
        od;
        return isit;
    end;
    DegreeSum := function (H, B)
        return Sum(List(B, x -> deg(H, x)));
    end;
    LiveVertices := [1..v];
    IndexLiveVertices := List([1..v], x->3);
    Switch := function( B )
        local combs, select;
        combs := Combinations(LiveVertices, 3);
        combs := Filtered(combs, x-> IsAdmissibleBlock(B, x));
        if combs <> [] then
            H := HHypergraph([1..v], B);
            SortBy(combs, x -> DegreeSum(H, x));
            #Print(List(combs, x-> [x, DegreeSum(H, x)]),"\n");
            # if Length(combs) >= 4 then
            #     select := combs{[Length(combs)-3..Length(combs)]};
            # else
            #     select := combs;
            # fi;
            # Add(B, Random(select));
            Add(B, combs[Length(combs)]);
        fi;
        return B;
    end;
    B := [];
    stop := 0;
    while Length(B) < v and stop < v+2 do
        stop := stop+1;
        Print(B, " ", Length(B), "\n");
        B := ShallowCopy(Switch(B));
    od;
    return B;
end;
