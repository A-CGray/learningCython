import numpy as np

DTYPE = np.intc

# use cdef to define this as a plain c function which can be called with zero overhead, we can do this because we don't
# want to import and use this function ourselves, it's just used by the compute function
cdef int clip(int a, int min_value, int max_value):
    return min(max(a, min_value), max_value)


def compute(array_1, array_2, int a, int b, int c):
    """
    This function must implement the formula
    np.clip(array_1, 2, 10) * a + array_2 * b + c

    array_1 and array_2 are 2D.
    """

    # Define variables for array sizes, Py_ssize_t is the proper C type for Python array indices.
    cdef Py_ssize_t x_max = array_1.shape[0]
    cdef Py_ssize_t y_max = array_1.shape[1]

    x_max = array_1.shape[0]
    y_max = array_1.shape[1]

    assert array_1.shape == array_2.shape
    assert array_1.dtype == DTYPE
    assert array_2.dtype == DTYPE

    result = np.zeros((x_max, y_max), dtype=DTYPE)

    # Now define the remainder of the variables used in the function
    cdef Py_ssize_t x, y

    # tmp should be an int, to match the dtype of the arrays
    # NB! An important side-effect of this is that if "tmp" overflows its
    # datatype size, it will simply wrap around like in C, rather than raise
    # an error like in Python.
    cdef int tmp

    # Still slow because x and y must be converted to python int in order to index numpy arrays which are python objects
    for x in range(x_max):
        for y in range(y_max):
            tmp = clip(array_1[x, y], 2, 10)
            tmp = tmp * a + array_2[x, y] * b
            result[x, y] = tmp + c

    return result