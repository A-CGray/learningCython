import numpy as np

DTYPE = np.intc

# use cdef to define this as a plain c function which can be called with zero overhead, we can do this because we don't
# want to import and use this function ourselves, it's just used by the compute function
cdef int clip(int a, int min_value, int max_value):
    return min(max(a, min_value), max_value)

# In this version we type the arrays as memory views, which I won't attempt to explain better than the cython tutorial:
#
# In short, memoryviews are C structures that can hold a pointer to the data of a NumPy array and all the necessary buffer
# metadata to provide efficient and safe access: dimensions, strides, item size, item type information, etc… They also
# support slices, so they work even if the NumPy array isn’t contiguous in memory. They can be indexed by C integers,
# thus allowing fast access to the NumPy array data.
#
# So basically, the C-friendly equivalent of a numpy array.

# Because we never use negative indexing in this function, and we're pretty sure we never ask for an index out of the
# array bounds, we can turn off some checks to get some extra performance

cimport cython
@cython.boundscheck(False)  # Deactivate bounds checking
@cython.wraparound(False)   # Deactivate negative indexing.
def compute(int[:,:] array_1, int[:,:] array_2, int a, int b, int c):
    """
    This function must implement the formula
    np.clip(array_1, 2, 10) * a + array_2 * b + c

    array_1 and array_2 are 2D.
    """

    cdef int x_max = array_1.shape[0]
    cdef int y_max = array_1.shape[1]

    # Since the array's are now memory views, their shapes are C arrays that can be compared with a simple '==',
    # so we need to convert them back to tuples first
    x_max = array_1.shape[0]
    y_max = array_1.shape[1]

    assert tuple(array_1.shape) == tuple(array_2.shape)

    result = np.zeros((x_max, y_max), dtype=DTYPE)
    cdef int[:,:] result_view = result

    # Now define the remainder of the variables used in the function
    cdef int x, y

    # tmp should be an int, to match the dtype of the arrays
    # NB! An important side-effect of this is that if "tmp" overflows its
    # datatype size, it will simply wrap around like in C, rather than raise
    # an error like in Python.
    cdef int tmp

    for x in range(x_max):
        for y in range(y_max):
            tmp = clip(array_1[x, y], 2, 10)
            tmp = tmp * a + array_2[x, y] * b
            result_view[x, y] = tmp + c

    return result