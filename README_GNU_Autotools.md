Filename : README_GNU_Autotools.md


## 1) Introduction.

Consider the definition of the following GNU Autotools macro.

```
AC_DEFUN(

  [AX_TEST_MACRO_A],

  [
    # Set the variable and then instruct GNU Autoconf to register it with the
    # configure script which GNU Autoconf will generate.
    #
    # If the variable isn't registered, then it won't be able to be seen or be
    # used by other code outside of this macro.

    TEST_MACRO_A_VARIABLE="Hello, World!"

    AC_SUBST([TEST_MACRO_A_VARIABLE])
  ]
)
```

This GNU Autoconf macro - which from now onwards will simply be referred to as a macro, is very basic in its nature. It doesn't do anything more than what its comments state; and that is to set the value of a variable and then register it so that it can be seen and used by other code outside of the macro.


## 2) How to process this package.

This package is designed to be processed by the GNU Autotools suite of tools, and the remainder of
this section of the document, will explain how to do just that. Processing the package in the manner
which is described below, will cause it to become a GNU Autotools project.

To begin the process of turning this package into a GNU Autotools project, change into the top-level
directory into which the package was installed. Then, execute the following two commands from within
it;

```
> libtoolize
> autoreconf
```

The ```autoreconf``` utility may complain that a number of required files cannot be found. If this
is the case, don't worry about it, because ```autoreconf``` also informs us that this problem can
be rectified by executing the following command;

```
> automake --add-missing
```