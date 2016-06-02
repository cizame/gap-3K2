LoadPackage("hypergraphs");

Blocks := function(v,g)
    local IsAdmissibleBlock, Ind, deg, DegreeSum, B, LiveVertices, IndexLiveVertices;
    IsAdmissibleBlock := function(B , P)
        local H, pairs, p, isit;
        H := HHypergraph(B);
        pairs := Combinations(P, 2);
        isit := true;
        i := 0;
        while isit and i < Length(pairs) do
            i := i+1;
            p := pairs[i];
            isit := (HDistance(H, p[1], p[2]) >= g-1);
        od;
        return isit;
    end;
    deg := function(H, x)
        Ind := IndexOfEdges(H);
        return Length(Ind.(x));
    end;
    DegreeSum := function (H,B)
        return Sum(List(B, x -> deg(H,x)));
    end;
    LiveVertices := [1..v];
    IndexLiveVertices := List([1..v], x->3);
    Switch := function( B )
        local combs;
        combs := Combinations(LiveVertices, 3);
        combs := Filtered(combs, x-> IsAdmissibleBlock(B,x));
        H := HHypergraph(B);
        
    end;
    
    
    
    
    
    
        
