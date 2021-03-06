#ifndef dplyr_Result_Processor_H
#define dplyr_Result_Processor_H

namespace dplyr{
    
    // if we derive from this instead of deriving from Result, all we have to 
    // do is implement a process_chunk method that takes a SlicingIndex& as
    // input and returns the suitable type (i.e. storage_type<OUTPUT>)
    // all the builtin result implementation (Mean, ...) use this. 
    template <int OUTPUT, typename CLASS>
    class Processor : public Result {
    public:
        typedef typename Rcpp::traits::storage_type<OUTPUT>::type STORAGE ;
         
        Processor(){}
        
        virtual SEXP process(const Rcpp::GroupedDataFrame& gdf ) {
            int n = gdf.ngroups() ; 
            Rcpp::Shield<SEXP> res( Rf_allocVector( OUTPUT, n) );
            STORAGE* ptr = Rcpp::internal::r_vector_start<OUTPUT>(res) ;
            CLASS* obj = static_cast<CLASS*>(this) ;
            GroupedDataFrame::group_iterator git = gdf.group_begin(); 
            for( int i=0; i<n; i++, ++git)
                ptr[i] = obj->process_chunk(*git) ;
            return res ;        
        }
        
        virtual SEXP process( const Rcpp::FullDataFrame& df){
            return process( df.get_index() );    
        }
        
        virtual SEXP process( const SlicingIndex& index){
            CLASS* obj = static_cast<CLASS*>(this) ;
            return Rcpp::Vector<OUTPUT>::create( obj->process_chunk(index) );    
        }
    } ;
    
    template <typename CLASS>
    class Processor<STRSXP, CLASS> : public Result {
    public:
        Processor(){}
        
        virtual SEXP process(const Rcpp::GroupedDataFrame& gdf) {
            int n = gdf.ngroups() ; 
            Rcpp::Shield<SEXP> res( Rf_allocVector( STRSXP, n) ) ;
            CLASS* obj = static_cast<CLASS*>(this) ;
            GroupedDataFrame::group_iterator git = gdf.group_begin() ;
            for( int i=0; i<n; i++, ++git)
                SET_STRING_ELT( res, i, obj->process_chunk(*git) );
            return res ;        
        }
        
        virtual SEXP process( const Rcpp::FullDataFrame& df){
            return process( df.get_index() );    
        }
        
        virtual SEXP process( const SlicingIndex& index){
            CLASS* obj = static_cast<CLASS*>(this) ;
            return Rf_mkString( obj->process_chunk(index) );    
        }
    } ;

}
#endif
