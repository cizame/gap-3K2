CheckKnapsackInput:=function(P, W, M)
    if not(IsList(P) and IsList(W)) then
        Print("Error. First two arguments must be lists.\n");
        return false;
    elif not (Length(P)=Length(W)) then
        Print("Error. The first two arguments must be lists of the same length.\n");
        return false;
    elif not(IsInt(M)) then
        Print("Error. The third arguments must be an integer.\n");
        return false;
    else
        return true;
    fi;
end;

Knapsack2:=function(P, W, M)
    local knapaux, n, x, XX, OptP, OptX, C;
    XX := [];
    C := [];
    OptP := 0;
    OptX := 0;
    n := Length(P);
    knapaux := function(l,CurW)
        if l = n+1 then
            Print("Checking ",XX,"\n");
            if Sum(List([1..n], i -> P[i]*XX[i])) > OptP then
                Print("Improved profit!\n");
                OptP := Sum(List([1..n], i -> P[i]*XX[i]));
                OptX := ShallowCopy(XX);
            fi;
            C[l] := [];
        else
            if CurW + W[l] <= M then
                C[l] := [1,0];
            else
                C[l] := [0];
                Print("Pruning!\n");
            fi;
        fi;
        for x in C[l] do
            XX[l] := x;
            knapaux(l+1, CurW+W[l]*XX[l]);
        od;
    end;
    if CheckKnapsackInput(P, W, M) then
        knapaux(1,0);
        Print("Maximum profit is ",OptP," with vector ",OptX,"\n");
    fi;
    return;
end;

KSAllCliques:=function( G )
        local allcliques, C, all, V, x, N, n, B, XX;
        C := [];
        all := [];
        N := [];
        XX := [];
        V := Union( G );
        n := Length( V );
        B := List( [1..n], i -> Filtered( [1..n], x->( x>i ) ) );
        allcliques := function(l)
            if l = 0 then
                Add( all, [] );
            else
                Add( all, ShallowCopy(XX) );  
            fi;
            if l = 0 then
                N[l+1] := V;
            else
                N[l+1] := Intersection( G[XX[l]], N[l] );
            fi;
            if N[l+1] = [] then
                Print(XX," is maximal!\n");
            fi;
            if l = 0 then
                C[l+1] := V;
            else
                C[l+1] := Intersection( G[XX[l]], C[l], B[XX[l]] );
            fi;
            for x in C[l+1] do
                XX[l+1] := x;
                XX := XX{[1..l+1]};
                allcliques(l+1);
            od;
        end;
        allcliques(0);
        return all;
    end;

KSQueens:=function( n )
    local C, XX, queens,k;
    C := [];
    XX := [];
    k:=0;
    queens := function(l)
        local x,valid;
        valid := function()
            local i, j, Bad;
            Bad := [];
            for i in [1..l] do
                Append(Bad,[XX[i],XX[i]-l-1+i,XX[i]+l+1-i]);
            od;
            return Difference( [1..n], Bad );
        end;
        if l = n then
            Print(XX,"\n");    
        fi;
        C[l+1] := valid();
        for x in C[l+1] do
            XX[l+1] := x;
            XX := XX{[1..l+1]};
            k := k+1;
            queens(l+1);
        od;
    end;
    queens(0);
    return;
end;

