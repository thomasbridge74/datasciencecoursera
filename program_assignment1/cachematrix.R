## These two functions are used to avoid repeated calculation of a matrix inversion.

## makeCacheMatrix() takes a single matrix as an argument and returns a variable

makeCacheMatrix <- function(x = matrix()) {
  # This object has two internal variables
  #      x - is the original matrix.
  #      m - is the inverse of x.    It is initially set to NULL and relies 
  #          on other functions to set it as required.
  # There are four functions that can be called:
  m <- NULL
  # This function initalises x and m.
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  # This function returns x - ie the original matrix.
  get <- function() x
  # This function sets m - ie the inverse of the original matrix.
  # As it's called "externally" there's no absolute requirement the 
  # that m actually holds the inverse of x.
  setinverse <- function(solve) m <<- solve
  # Returns the current value of m.   Note that if we have not yet calculated the 
  # inverse that we would return a NULL value.
  
  getinverse <- function() m
  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## This function manipulates the variable returned by makeCacheMatrix and returns
## the inverse stored in that variable.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  # if m is not NULL, this means we have a cached value for m and there's no need to 
  # do any more calculations, just return it.
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  # if we're here, then there is no cached value for m.    We need to calculate
  # and store it.
  data <- x$get()
  m <- solve(data)
  x$setinverse(m)
  # Having stored the calculated value, we now need to return the inverse to the 
  # caller.
  m
}
