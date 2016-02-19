#############################################################################
##
##
#W  cayley-cages.gi       cayley-cages Package             
##
##  Installation file for cayley-cages functions
##
#############################################################################

#F  CheckKnapsackInput( <P>, <W>, <M> )
##
InstallGlobalFunction(
    CheckKnapsackInput, function(P, W, M)
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
end);

#F  IsCayleyCage( <s> ) 
##
InstallGlobalFunction( IsCayleyCage, function( s )
                         Print(" Primera funcion solo imprime el numero ",s );
                         
end);

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
