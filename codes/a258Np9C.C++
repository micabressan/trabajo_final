double golden_section(cd BEGIN, cd END)
{
    cd REFERENCE_POINT = (END - BEGIN) / Const::PHI;
 
    if(abs(END - BEGIN) <= Const::EPS)
        return (BEGIN + END) / 2;
 
    cd X1 = END - REFERENCE_POINT;
    cd X2 = BEGIN + REFERENCE_POINT;
 
    if(func_value(X1) >= func_value(X2))
        return golden_section(X1, END);
    else
        return golden_section(BEGIN, X2);
}