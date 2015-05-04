# Added #
  * Vectors multiplication
  * Cosine similarity between two vectors

# About #
Pumice is a sparse vector and sparse matrix library for the
[Lua](http://www.lua.org) programming language. Pumice can efficiently
store vectors and matrices containing a large number of zero
elements. While it can be used as a general purpose matrix library,
emphasis is placed on being able to efficiently handle and perform
calculations with large sparse structures.

All code is written entirely in Lua, with vectors and
matrices being Lua tables "under the hood." While Lua is widely
considered to be one of the fastest dynamic languages, performance
will never be in the same ballpark as that of a highly optimized
sparse matrix library written in Fortran or C. Still, Lua presents a
simple, accessible platform for exploration and experimentation.

Pumice currently has support for basic matrix operations, LU, QR, and
Cholesky decompositions, and for solving Ax = b using Gaussian
elimination.  There are also utility functions for importing and exporting matrices in
[Matrix Market](http://math.nist.gov/MatrixMarket/formats.html)
format. While some care has been taken to use numerically stable algorithms, functions do not always take great advantage of sparse-ness. Additional features will be added as time and knowledge permit. The library is released as free software under the terms of the MIT
open source license in the hopes that others will find it useful. Pumice's principal author is [Lars Rosengreen](http://www.google.com/profiles/lrosengreen).  Thanks for stopping by :)

# modules #
## vector ##

  * sparse vectors
  * basic vector operations such as addition, subtraction, scalar multiplication and dot products
  * vector norms (1, 2, infinity, other induced norms)

## matrix ##

  * sparse matrices
  * creating a matrix from a string such as `[1 2 3; 4 5 6]`
  * basic matrix operations such as addition, subtraction, scalar multiplication, matrix -  vector multiplication, and matrix - matrix multiplication
  * transposing a matrix
  * inverting a matrix<sup>1</sup>
  * solving Ax = b with Gaussian elimination (with partial pivoting)<sup>1</sup>
  * LU decomposition<sup>1</sup>
  * QR decomposition<sup>1</sup>
  * Cholesky decomposition<sup>1</sup>
  * mapping a function over the nonzero elements of a matrix

## mm ##

  * importing and exporting matrices in Matrix Market coordinate format

## vis ##

  * creating graphical images from matrices

## isolv ##

  * conjugate gradients<sup>1</sup>


<sup>1</sup> may not be fully sparse

[vanHeukelum\cage10](http://www.cise.ufl.edu/research/sparse/matrices/vanHeukelum/cage10.html) from the [University of Florida Sparse Matrix Collection](http://www.cise.ufl.edu/research/sparse/matrices/), rendered with pumice's `vis.fc` function
