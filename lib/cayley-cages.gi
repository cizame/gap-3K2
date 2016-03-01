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

