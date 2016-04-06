#include <cstdio>
#include <cmath>
#include <algorithm>

#define EPS     1e-18

class CVector2
{
public:    
    double x, y;
    CVector2( double _x = 0.0f, double _y = 0.0f )  { x = _x; y = _y; }
    CVector2 operator +( const CVector2 &v ) { return CVector2( x + v.x, y + v.y ); }
    CVector2 operator -( const CVector2 &v ) { return CVector2( x - v.x, y - v.y ); }
    CVector2 operator -() { return CVector2( -x, -y ); }
    double SqrLength() { return x * x + y * y; }
    double Length() { return sqrt( x * x + y * y ); }
    void Read( FILE *fin ) { fscanf( fin, "%lf %lf", &x, &y ); }
    static double DotProduct( CVector2 v1, CVector2 v2 ) { return v1.x * v2.x + v1.y * v2.y; }
};

bool IsPointOnSegment( CVector2 v1, CVector2 v2, CVector2 p )
{
    if( CVector2::DotProduct( v2 - v1, p - v1 ) >= 0.0 &&
        CVector2::DotProduct( v1 - v2, p - v2 ) >= 0.0 )
        return true;
    return false;
}

bool GetIntersection( CVector2 v1_begin, CVector2 v1_end,
                      CVector2 v2_begin, CVector2 v2_end,
                      CVector2 *result )
{
    if( fabs( v2_begin.x - v2_end.x ) < EPS )
    {
        std::swap( v1_begin, v2_begin );
        std::swap( v1_end, v2_end );
    }
    if( fabs( v1_begin.x - v1_end.x ) < EPS )
    {
        if( fabs( v2_begin.x - v2_end.x ) < EPS )
            return false;
        
        result->x = v1_begin.x;
        result->y = v2_begin.y + ( v2_end.y - v2_begin.y ) *
                    ( ( result->x - v2_begin.x ) / ( v2_end.x - v2_begin.x ) );
                   
        return IsPointOnSegment( v1_begin, v1_end, *result ) &&
               IsPointOnSegment( v2_begin, v2_end, *result );
    }
    
    double k1 = ( v1_end.y - v1_begin.y ) / ( v1_end.x - v1_begin.x );
    double k2 = ( v2_end.y - v2_begin.y ) / ( v2_end.x - v2_begin.x );
    
    if( fabs( k1 - k2 ) < EPS )
        return false;
    
    double b1 = v1_begin.y + ( v1_end.y - v1_begin.y ) *
               ( 0 - v1_begin.x / ( v1_end.x - v1_begin.x ) );
    double b2 = v2_begin.y + ( v2_end.y - v2_begin.y ) *
               ( 0 - v2_begin.x / ( v2_end.x - v2_begin.x ) );
    
    result->x = ( b2 - b1 ) / ( k1 - k2 );
    result->y = k1 * result->x + b1;
    
    return IsPointOnSegment( v1_begin, v1_end, *result ) &&
           IsPointOnSegment( v2_begin, v2_end, *result );
}


void SolveTriangle( double &a, double &b, double &c )
{
    if( a < EPS )
        a = sqrt( c * c - b * b );
    else if( b < EPS )
        b = sqrt( c * c - a * a );
    else if( c < EPS )
        c = sqrt( a * a + b * b );
}

bool IsParallel( CVector2 v1_begin, CVector2 v1_end, CVector2 v2_begin, CVector2 v2_end )
{
    if( fabs( v1_begin.x - v1_end.x ) < EPS &&
        fabs( v2_begin.x - v2_end.x ) < EPS )
        return true;

    double k1 = ( v1_end.y - v1_begin.y ) / ( v1_end.x - v1_begin.x );
    double k2 = ( v2_end.y - v2_begin.y ) / ( v2_end.x - v2_begin.x );
    
    return fabs( k1 - k2 ) < EPS;
}


int main()
{
    FILE *fin = fopen( "input.txt", "r" );
    FILE *fout = fopen( "output.txt", "w" );
    
    CVector2 v0, v1, v2, v3;
    double H;
    
    v0.Read( fin );
    v1.Read( fin );
    v2.Read( fin );
    v3.Read( fin );
    fscanf( fin, "%lf", &H );

    double res = 0.0;
    
    
    CVector2 intersection;
    if( GetIntersection( v0, v1, v2, v3, &intersection ) && 
        ( v2 - intersection ).SqrLength() > EPS && ( v3 - intersection ).SqrLength() > EPS )
    {
        double a, b = 0.0, c = ( v1 - v0 ).Length();
        a = ( intersection - v0 ).Length();
        SolveTriangle( a, b, c );
        b = std::min( b, H );

        res = b;
    }
    else if( IsParallel( v0, v1, v2, v3 ) )
    {
        bool b2 = IsPointOnSegment( v0, v1, v2 );
        bool b3 = IsPointOnSegment( v0, v1, v3 );
        
        bool isLeft = false;
        if( ( v2 - v0 ).SqrLength() < ( v3 - v0 ).SqrLength() )
            isLeft = true;
        
        if( b2 || b3 )
        {
            double a, b, c;
            if( isLeft )
                a = ( v0 - v2 ).Length();
            else
                a = ( v0 - v3 ).Length();

            c = ( v1 - v0 ).Length();
            double alpha = 0.0;

            if( a > EPS )
            {
                SolveTriangle( a, b, c );
                alpha = atan2( b, a );
            }
            else
            {
                b = c;
                alpha = M_PI / 2.0;
            }
            

            if( b <= H )
            {
                if( b2 && b3 )
                {
                    if( !isLeft )
                        a = ( v0 - v2 ).Length();
                    else
                        a = ( v0 - v3 ).Length();

                    b = 0.0;

                    SolveTriangle( a, b, c );

                    alpha -= atan2( b, a );
                }
            }
            else
            {
                a = 0.0;
                b = H;

                SolveTriangle( a, b, c );

                alpha = atan2( b, a );

                if( b2 && b3 )
                {
                    if( !isLeft )
                        a = ( v0 - v2 ).Length();
                    else
                        a = ( v0 - v3 ).Length();

                    b = 0.0;

                    SolveTriangle( a, b, c );

                    alpha -= atan2( b, a );
                }
            }
            res = c * alpha;
        }
    }
    
    fprintf( fout, "%.3lf\n", res );
        
    fclose( fin );
    fclose( fout );
    return 0;    
}