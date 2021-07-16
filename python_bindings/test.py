# Basic operations with Python bindings interfacing COBOL
import pathlib
from ctypes import byref, c_float, c_double, c_char_p, c_char, c_int, CDLL

if __name__ == "__main__":
    # load the shared library
    libname = pathlib.Path().absolute() / "libtest.so"
    libcob = CDLL(libname)

    print('###### INTEGER FROM COBOL ######')
    # 1 - get an integer from cobol
    x = libcob.ret_integer()
    print("Integer", x, type(x))

    #################################
    # 2 - float arguments
    print('########### FLOAT ##############')
    libcob.ret_float_pointer.restype = c_float
    x = c_float(1.1)
    print('input ', byref(x), x.value)
    libcob.ret_float_pointer(byref(x))
    print('output ', x, x.value, type(x))

    #################################
    # 2 - double argument
    print('########### DOUBLE #############')
    libcob.ret_double_pointer.restype = c_double
    x = c_double(1.1)
    print('input ', byref(x), x.value)
    libcob.ret_double_pointer(byref(x))
    print('output ', x, x.value, type(x))

    #################################
    # 3 - This shows how to change a string passed by python as pointer
    print('########### STRING #############')
    s = "Hello from Python!"
    p = c_char_p(s.encode('utf8'))
    libcob.change_string.argtypes = [c_char_p]
    libcob.change_string(p)
    print('COBOL  said:', p.value.decode())

    #################################
    print('######### STRING ARGS ##########')
    # 4 - String arguments
    print("String Arguments")
    s = b'World'
    p = c_char_p(s)
    libcob.string_arguments.argtypes = [c_char_p]
    x = libcob.string_arguments(p)

    #################################
    print('####### NUMBER ARGS (str) ##########')
    # 5 - numeric_arguments
    #    pass numbers as string arguments.
    libcob.string_arguments.argtypes = [c_int, c_float ]
    libcob.numeric_arguments.restype = c_int
    a, b = "4", "2"
    x = libcob.numeric_arguments(a, b)
    print("Numeric Arguments", x, type(x), "called with", a, b)
