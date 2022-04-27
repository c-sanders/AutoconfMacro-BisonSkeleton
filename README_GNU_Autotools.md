Filename : README_GNU_Autotools.md


## 1) Introduction.

Consider the definition of the following GNU Autoconf macro.

```
AC_DEFUN(

  [AX_TEST_MACRO],

  [
    # Set the variable and then instruct GNU Autoconf to register it with the
    # configure script which GNU Autoconf will generate.
    #
    # If the variable isn't registered, then it won't be able to be seen or be
    # used by other code outside of this macro.

    TEST_MACRO_VARIABLE="Hello, World!"

    AC_SUBST([TEST_MACRO_VARIABLE])
  ]
)
```

This GNU Autoconf macro - which from now onwards will simply be referred to as a macro, is very basic in its nature. It doesn't do anything more than what its comments state; and that is to set the value of a variable and then register it so that it can be seen and used by other code outside of the macro.


## 2) Invoking this macro by a Package maintainer.

If the maintainer of a package wants to use this macro in their particular package, then the macro will need to be invoked from the package's ```configure.ac``` file, in a manner which is similar to the following;

```
AX_TEST_MACRO()
```

Once the package's ```configure.ac``` file has been finalised, the Package maintainer should generate a configure script for their package, using the ```autoreconf``` command to do so.


## 3) Executing this macro by the Package user.


The maintainer of the package 

When the user of this package 
```