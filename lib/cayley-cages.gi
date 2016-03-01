#############################################################################
##
##
#W  cayley-cages.gi       cayley-cages Package             
##
##  Installation file for cayley-cages functions
##
#############################################################################

#F  CCEliminaInversos( <l> ) 
##
InstallGlobalFunction( CCEliminaInversos, function( l )
   local l1,i;
   l1:=[];  
    
    for i in [1..Length(l)] do
        if not (l[i] in l1) and not (l[i]^-1 in l1) then 
            l1:=Union(l1,[l[i]]);
        fi;  
    od;
    
    return l1;
end);

#F  CCConjuntoT1( a,b,c ) 
##
InstallGlobalFunction( CCConjuntoT1, function( a,b,c )
        local l;
    l := [a,a^-1,b,b^-1,c,c^-1];

    if Length(Set(l)) <> 6 then
        return fail;
    elif
        Order(a)<>1 or Order(b) or Order(c) then
        return fail;        
    elif
      a*b = c^-1 then
        return fail;
    elif
      a*b = c then
        return fail;
    elif
      a*b^-1 = c then
        return fail;
    elif
      a*b^-1 = c^-1 then
        return fail;
    elif
      a*c = b then
        return fail;
    elif
      a*c = b^-1 then
        return fail;
    elif
      a*c^-1 = b then
        return fail;
    elif
      a*c^-1 = b^-1 then
        return fail;
    else
        return l;
    fi;
end);
