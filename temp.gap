
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

