using cd = const double

namespace Const {
cd DELTA = 0.00000000000001;
cd EPS = 0.00000000000001;
 
constexpr cd PHI = (1 + sqrt(5)) / 2;
}

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