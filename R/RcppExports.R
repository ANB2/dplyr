# This file was generated by Rcpp::compileAttributes
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

semi_join_impl <- function(x, y, by) {
    .Call('dplyr_semi_join_impl', PACKAGE = 'dplyr', x, y, by)
}

anti_join_impl <- function(x, y, by) {
    .Call('dplyr_anti_join_impl', PACKAGE = 'dplyr', x, y, by)
}

inner_join_impl <- function(x, y, by) {
    .Call('dplyr_inner_join_impl', PACKAGE = 'dplyr', x, y, by)
}

left_join_impl <- function(x, y, by) {
    .Call('dplyr_left_join_impl', PACKAGE = 'dplyr', x, y, by)
}

right_join_impl <- function(x, y, by) {
    .Call('dplyr_right_join_impl', PACKAGE = 'dplyr', x, y, by)
}

compatible_data_frame <- function(x, y, ignore_col_order = TRUE, convert = FALSE) {
    .Call('dplyr_compatible_data_frame', PACKAGE = 'dplyr', x, y, ignore_col_order, convert)
}

equal_data_frame <- function(x, y, ignore_col_order = TRUE, ignore_row_order = TRUE, convert = FALSE) {
    .Call('dplyr_equal_data_frame', PACKAGE = 'dplyr', x, y, ignore_col_order, ignore_row_order, convert)
}

all_equal_data_frame <- function(args, env) {
    .Call('dplyr_all_equal_data_frame', PACKAGE = 'dplyr', args, env)
}

union_data_frame <- function(x, y) {
    .Call('dplyr_union_data_frame', PACKAGE = 'dplyr', x, y)
}

intersect_data_frame <- function(x, y) {
    .Call('dplyr_intersect_data_frame', PACKAGE = 'dplyr', x, y)
}

setdiff_data_frame <- function(x, y) {
    .Call('dplyr_setdiff_data_frame', PACKAGE = 'dplyr', x, y)
}

match_data_frame <- function(x, y) {
    .Call('dplyr_match_data_frame', PACKAGE = 'dplyr', x, y)
}

build_index_cpp <- function(data) {
    .Call('dplyr_build_index_cpp', PACKAGE = 'dplyr', data)
}

filter_impl <- function(df, args, env) {
    .Call('dplyr_filter_impl', PACKAGE = 'dplyr', df, args, env)
}

mutate_impl <- function(df, args, env) {
    .Call('dplyr_mutate_impl', PACKAGE = 'dplyr', df, args, env)
}

order_impl <- function(args, env) {
    .Call('dplyr_order_impl', PACKAGE = 'dplyr', args, env)
}

arrange_impl <- function(data, args, dots) {
    .Call('dplyr_arrange_impl', PACKAGE = 'dplyr', data, args, dots)
}

sort_impl <- function(data) {
    .Call('dplyr_sort_impl', PACKAGE = 'dplyr', data)
}

group_size_grouped_cpp <- function(gdf) {
    .Call('dplyr_group_size_grouped_cpp', PACKAGE = 'dplyr', gdf)
}

summarise_impl <- function(df, args, env) {
    .Call('dplyr_summarise_impl', PACKAGE = 'dplyr', df, args, env)
}

#' Efficiently count the number of unique values in a vector.
#' 
#' This is a faster and more concise equivalent of \code{length(unique(x))}
#' 
#' @param x a vector of values
#' @export
#' @examples
#' x <- sample(1:10, 1e5, rep = TRUE)
#' length(unique(x))
#' count_distinct(x)
count_distinct <- function(x) {
    .Call('dplyr_count_distinct', PACKAGE = 'dplyr', x)
}

#' @export
#' @rdname rbind
rbind_all <- function(dots) {
    .Call('dplyr_rbind_all', PACKAGE = 'dplyr', dots)
}

split_indices <- function(group, groups) {
    .Call('dplyr_split_indices', PACKAGE = 'dplyr', group, groups)
}

#' Cumulativate versions of any, all, and mean
#' 
#' dplyr adds \code{cumall}, \code{cumany}, and \code{cummean} to complete
#' R's set of cumulate functions to match the aggregation functions available
#' in most databases
#' 
#' @param x For \code{cumall} & \code{cumany}, a logical vector; for
#'   \code{cummean} an integer or numeric vector
#' @export
cumall <- function(x) {
    .Call('dplyr_cumall', PACKAGE = 'dplyr', x)
}

#' @export
#' @rdname cumall
cumany <- function(x) {
    .Call('dplyr_cumany', PACKAGE = 'dplyr', x)
}

#' @export
#' @rdname cumall
cummean <- function(x) {
    .Call('dplyr_cummean', PACKAGE = 'dplyr', x)
}

