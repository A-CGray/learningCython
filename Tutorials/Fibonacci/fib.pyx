from __future__ import print_function

def fib(n):
    """Print the first n terms of the fibonacci series
    """
    a = 0
    b = 1
    while b < n:
        print(b, end=' ')
        a, b = b, a+b

