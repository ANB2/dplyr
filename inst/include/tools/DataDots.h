#ifndef dplyr__DataDots_h
#define dplyr__DataDots_h

namespace Rcpp {
    
    class DataDots {
    public:
        
        DataDots( Environment env ) : environments() {                
          SEXP dots = env.find( "..." );
          
          while( dots != R_NilValue ){
            Promise prom = CAR(dots) ;
            
            while(true){
              SEXP code = PRCODE(prom) ;
              if( TYPEOF(code) != PROMSXP ){
                break ;  
              }
              prom = code ;
            }
            environments.push_back(prom.environment()) ;
            
            dots = CDR(dots) ;
          }
        }
            
        inline const Environment& envir(int i) const {
            return environments[i] ;
        }
        
        inline int size() const{ 
            return environments.size(); 
        } 
        
    private:
        std::vector<Environment> environments ;
    } ;
          
}    
#endif
