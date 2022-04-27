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

This GNU Autoconf macro - which from now onwards will simply be referred to as a macro, is very basic in its nature. It doesn't do anything more than what its comments state; and that is to set the value of a variable and then register it, so that the variable can be seen and used by other code outside of the macro.


## 2) Using the macro.

Broadly speaking, two sets of people will use this macro.

  1) Package maintainers
  2) Package users

Package maintainers deal more directly with the 


## 3) Package maintainers : Invoking this macro.

If a Package maintainer wants to use this macro in their particular package, then the macro will need to be invoked from within the package's ```configure.ac``` file. This can be done in a manner which is similar to the following invocation;

```
AX_TEST_MACRO()
```

Once the package's ```configure.ac``` file has been finalised, the Package maintainer should generate a configure script for their package, using the GNU Autotools ```autoreconf``` command to do so.

When a package is ready for distribution to users, all of the files which are to form the package should be "rolled up" into either a ```.tar.gz``` or ```.tar.bz2``` file. It is these ```.tar.gz``` or ```.tar.bz2``` files which form the actual package for the project. A key file which 


## 3) Executing this macro by a Package user.

When the user of this package executes its configure script with the ```--help``` command line option, the user won't see any information on how to use this macro.
```