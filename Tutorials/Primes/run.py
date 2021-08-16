import timeit

version = ["Python", "Compiled Python", "Cython", "C++ Cython"]
names = ["pyPrimes", "pyPrimes_Compiled", "cyPrimes", "CppPrimes"]

for i in range(len(names)):
    setup = f"from {names[i]} import primes"
    time = timeit.timeit(setup=setup, stmt="primes(1000)", number=100)
    print(f"{version[i]} code time = {time:.04e} s")
