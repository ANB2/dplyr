#ifndef dplyr_GroupedCallProxy_H
#define dplyr_GroupedCallProxy_H

namespace dplyr {
     
    class GroupedCallProxy {
    public:
        
        GroupedCallProxy( Language& call_, const LazyGroupedSubsets& subsets_, const Environment& env_) : 
            call(call_), subsets(subsets_), proxies(), env(env_), hybrid(false)
        {
            // fill proxies
            traverse_call(call);
            
            hybrid = can_simplify_call(call) ; 
        }
        
        GroupedCallProxy( Language& call_, const GroupedDataFrame& data_, const Environment& env_) : 
            call(call_), subsets(data_), proxies(), env(env_), hybrid(false)
        {
            // fill proxies
            traverse_call(call);
            
            hybrid = can_simplify_call(call) ; 
        }
        
        GroupedCallProxy( const GroupedDataFrame& data_, const Environment& env_ ) : 
            subsets(data_), proxies(), env(env_), hybrid(false)
        {}
        
        ~GroupedCallProxy(){}  
        
        template <typename Container>
        SEXP get(const Container& indices){
            subsets.clear();
            if( hybrid ) {
                GroupedHybridCall hybrid_eval( call, indices, subsets, env ) ;
                return hybrid_eval.eval() ;
            }
            
            int n = proxies.size() ;
            for( int i=0; i<n; i++){
                proxies[i].set( subsets.get(proxies[i].symbol, indices ) ) ;  
            }
            return call.fast_eval(env) ;
        }
        
        void set_call( SEXP call_ ){
            proxies.clear() ;
            call = call_ ;
            traverse_call(call) ;
            hybrid = can_simplify_call(call) ;
        }
        
        void input( Rcpp::String name, SEXP x ){
            subsets.input( as_symbol(name.get_sexp()) , x ) ;
        }
         
        inline int nsubsets(){
            return subsets.size() ;
        }   
        
        inline SEXP get_variable( Rcpp::String name ) const {
            return subsets.get_variable(as_symbol(name.get_sexp()) ) ;
        }
        
        inline bool is_constant() const {
            return TYPEOF(call) != LANGSXP && Rf_length(call) == 1 ;    
        }
        
        inline SEXP get_call() const {
            return call ;    
        }
        
        inline bool has_variable(SEXP symbol) const {
            return subsets.count(symbol);    
        }
        
        inline void set_env(SEXP env_){
            env = env_ ;    
        }
        
    private:
        
        inline bool can_simplify_call( SEXP call){
            bool res =  can_simplify(call);
            return res ;
        }
        
        void traverse_call( SEXP obj ){
            if( ! Rf_isNull(obj) ){ 
                SEXP head = CAR(obj) ;
                switch( TYPEOF( head ) ){
                case LANGSXP: 
                    traverse_call( CDR(head) ) ;
                    break ;
                case LISTSXP:
                    traverse_call( head ) ;
                    traverse_call( CDR(head) ) ;
                    break ;
                   
                case SYMSXP:
                    if( TYPEOF(obj) != LANGSXP ){
                        if( ! subsets.count(head) ){  
                            // in the Environment -> resolve
                            // TODO: handle the case where the variable is not found in env
                            Shield<SEXP> x( env.find( CHAR(PRINTNAME(head)) ) ) ;
                            SETCAR( obj, x );
                        } else {
                            // in the data frame
                            proxies.push_back( CallElementProxy( head, obj ) );
                        } 
                    }
                    break ;
                }
                traverse_call( CDR(obj) ) ;
            }    
        }
        
        Rcpp::Language call ;
        LazyGroupedSubsets subsets ;
        std::vector<CallElementProxy> proxies ;
        Environment env; 
        bool hybrid ;
    } ;

}

#endif
