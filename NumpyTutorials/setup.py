from setuptools import setup
from distutils.core import Extension as Ext
from Cython.Build import cythonize

setup(ext_modules=cythonize(["compute_cy.py", "compute_cy_typed.pyx", "compute_cy_memview.pyx", "compute_cy_contiguous.pyx", "compute_cy_fusetype.pyx", "compute_cy_parallel.pyx"], annotate=True))
