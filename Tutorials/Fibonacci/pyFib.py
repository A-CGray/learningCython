from __future__ import print_function


def pyFib(n):
    """Print the first n terms of the fibonacci series"""
    a = 0
    b = 1
    while b < n:
        # print(b, end=" ")
        a, b = b, a + b
    return b