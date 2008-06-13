# Dimensions
# Number of dimensions of an array or vector
# 
# @arguments array 
# @keyword internal
dims <- function(x) length(amv_dim(x))

# Dimensions
# Compute dimensions for a vector similarly to arrays
# 
# @arguments array or vector
# @keyword internal 
amv_dim <- function(x) if (is.vector(x)) length(x) else dim(x)

# Reduce dimensions
# Remove extraneous dimensions
# 
# @arguments array
# @keyword internal 
reduce <- function(x) {
  do.call("[", c(list(x), lapply(dim(x), function(x) if (x==1) 1 else T), drop=TRUE))  
}

amv_dimnames <- function(x) {
  d <- if (is.vector(x)) list(names(x)) else dimnames(x)
  
  if (is.null(d)) d <- rep(list(NULL), dims(x))
  null_names <- which(unlist(llply(d, is.null)))
  d[null_names] <- llply(null_names, function(i) seq.int(amv_dim(x)[i]))
  
  # if (is.null(names(d))) names(d) <- paste("X", 1:length(d), sep="")
  d
}