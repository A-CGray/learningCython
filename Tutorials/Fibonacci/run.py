import timeit

pySetup = "from pyFib import pyFib"
time = timeit.timeit(setup=pySetup, stmt="pyFib(10000)", number=10000)
print(f"\nPython code time = {time:.04e} s")

cySetup = "from fib import fib"
time = timeit.timeit(setup=cySetup, stmt="fib(10000)", number=10000)
print(f"\nCython code time = {time:.04e} s")