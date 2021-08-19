import timeit

version = ["Python", "Compiled Python", "Typed Cython", "Memview Cython", "Contiguous Cython", "Fused Type Cython", "Parallel Cython", "numpy"]
names = ["compute_py", "compute_cy", "compute_cy_typed", "compute_cy_memview", "compute_cy_contiguous", "compute_cy_fusetype", "compute_cy_parallel", "compute_numpy"]

for i in range(len(names)):
    setup = f"from {names[i]} import compute"
    setup += """
import numpy as np
array_1 = np.random.uniform(0, 1000, size=(300, 200)).astype(np.intc)
array_2 = np.random.uniform(0, 1000, size=(300, 200)).astype(np.intc)
a = 4
b = 3
c = 9"""
    time = timeit.timeit(setup=setup, stmt="compute(array_1, array_2, a, b, c)", number=1)
    print(f"{version[i]} code time = {time:.04e} s")
