LoadPackage("kreher-stinson");
LoadPackage("hypergraphs");

BloquesDeTres := function (v, g)
    local B, b, Switch, LiveVertices, LiveIndexVertices, NumLiveVertices, BlocksContainingVertex, i, H,
          IsAdmissibleBlock;
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
    B := [];
    b := 0;
    LiveIndexVertices := List([1..v], x->3);
    LiveVertices := [1..v];
    NumLiveVertices := v;
    Switch := function (B)
        local x, I, j, P, all;
        all := Difference(Combinations(LiveVertices, 3), B);
        P := Random(all);
        if IsAdmissibleBlock(B, P) then 
            Add(B, P);
            b := b+1;
            Print("Adding ", B, "\n");
            for j in P do
                LiveIndexVertices[j] := LiveIndexVertices[j] - 1;
                if LiveIndexVertices[j] = 0 then
                    NumLiveVertices := NumLiveVertices - 1;
                    LiveVertices := RemovedSet@hypergraphs(LiveVertices, j);
                fi;
            od;
        fi;
        return;
    end;

    while b < v do
        if NumLiveVertices in [1,2] then
            Print("Unable to finish.\n");
            return fail;
        fi;
        if (NumLiveVertices = 3) and not(IsAdmissibleBlock(B, LiveVertices)) 
        then
            Print("Unable to finish.\n");
            return fail;
        fi;
        Switch(B);
    od;
    return B;
end;

