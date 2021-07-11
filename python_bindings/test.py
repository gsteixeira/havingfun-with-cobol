# Basic operations with Python bindings interfacing COBOL
import ctypes
import pathlib

if __name__ == "__main__":
    # Load the shared library
    libname = pathlib.Path().absolute() / "libtest.so"
    libcob = ctypes.CDLL(libname)

    # 1 - get an integer from cobol
    x = libcob.ret_integer()
    print("Integer", x, type(x))

    # 2 - numeric_arguments
    #    pass numbers as arguments. Note that due limitations of gnucobol, 
    #    numeric arguments must be passed as strings
    libcob.string_arguments.argtypes = [ctypes.c_int, ctypes.c_float ]
    libcob.numeric_arguments.restype = ctypes.c_int
    a, b = "4", "2"
    x = libcob.numeric_arguments(a, b)
    print("Numeric Arguments", x, type(x), "called with", a, b)

    # 3 - String arguments
    s = b'World'
    p = ctypes.c_char_p(s)
    libcob.string_arguments.argtypes = [ctypes.c_char_p]
    libcob.string_arguments.restype = ctypes.c_char_p

    x = libcob.string_arguments(p)
    print("String Arguments", type(x), x)
