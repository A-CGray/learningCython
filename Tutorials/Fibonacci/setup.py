from setuptools import setup
from distutils.core import Extension as Ext
from Cython.Build import cythonize

setup(ext_modules = cythonize("fib.pyx"))