from setuptools import setup
from distutils.core import Extension as Ext
from Cython.Build import cythonize

setup(ext_modules=cythonize(["pyPrimes_Compiled.py", "cyPrimes.pyx", "CppPrimes.pyx"], annotate=True))
