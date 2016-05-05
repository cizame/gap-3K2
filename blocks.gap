LoadPackage("kreher-stinson");

BloquesDeTres := function (v)
    local B, b, Switch, LiveVertices,NumLiveVertices, BlocksContainingVertex, i;
    B := [];
    b := 0;
    LiveVertices := List([1..v], x -> 3);
    NumLiveVertices := v;
    Switch := function (B)
        local x, I, j, P;
        if LiveVertices[i] > 0 then
            P := [i];
            while (i in P) do
                I := KSRandomkSubset(2,NumLiveVertices);
                Print("Indices: ",I,"\n");
                P := Filtered([1..v], i->LiveVertices[i]<>0){I};
                Print("P: ",P,"\n");
            od;
            Add(P,i);
            P := Set(P);
            if not(P in B) then
                b := b+1;
                Add(B,P);
                Print("Adding ",B,"\n");
                for j in P do
                    LiveVertices[j] := LiveVertices[j] - 1;
                    if LiveVertices[j] = 0 then
                        NumLiveVertices := NumLiveVertices - 1;
                    fi;
                od;
            fi;
        else
            i := i+1;
        fi;
    end;
    i := 1;
    while b < v do
        Switch(B);
    od;
    return B;
end;

