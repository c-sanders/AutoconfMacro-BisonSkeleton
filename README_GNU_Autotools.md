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
  - Code listing no. 1

This GNU Autoconf macro - which from now onwards will simply be referred to as a macro, is very basic in its nature. It doesn't do anything more than what its comments state; and that is to set the value of the variable named ```TEST_MACRO_VARIABLE``` and then register it, so that the variable can be seen and used by other code outside of the macro.


### 1.1) Non configurable and configurable macros.

  - Non configurable macros.

The macro which was listed above, is a non configurable macros. That is, neither a Package maintainer nor a Package user is able to configure this macro. By this, it is meant that configuration information cannot be passed to this macro, and it is for this reason that this macro doesn't provide any command line information on how to use it. That is, if a package uses this macro, and a user of this package invokes its configure script with the ```--help``` command line option, then they won't get any information on how to use this macro. The reason for this, is because the macro doesn't provide any configuration options, and because it doesn't provide any configuration options, it doesn't need to inform any Package user of them.


  - Configurable macros.

If the macro which was listed above, might require configuration information to be passed to it, then it should have additional code added to it which can facilitate this functionality. The body of the macro would need to invoke the GNU Autoconf ```AC_ARG_WITH``` macro.

```
AC_DEFUN(

  [AX_TEST_MACRO],

  [
    AC_ARG_WITH(
      [test-macro],
      [
AS_HELP_STRING(
[--with-value=@<:@variable_value@:>@],
[instruct the macro to set the variable to the specified value]
)
      ],
      [TEST_MACRO_VARIABLE=${withval}],
      [TEST_MACRO_VARIABLE=""]
    )

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
  - Code listing no. 2


## 2) Using the macro.

Broadly speaking, two sets of people will use this macro.

  1) Package maintainers
  2) Package users

Package maintainers don't actually use the macro in the sense that they don't actually execute it - they simly reference it within their package's ```configure.ac``` file.

On the other hand, Package users do actually use the macro in the sense that was stated previously. When the run a package's configure script, they will execute the code that forms the macro.


## 3) Package maintainers : The people who reference this macro.

If a Package maintainer wants to use this macro in their particular package, then the macro will need to be referenced from within the package's ```configure.ac``` file. This can be done in a manner which is similar to the following;

```
AX_TEST_MACRO()
```

Once a package's ```configure.ac``` file has been finalised, the Package maintainer should generate a configure script for the package, using the GNU Autotools ```autoreconf``` command to do so.

When a Package maintainer is ready to distribute their package to users, all of the files which are to form the package should be "rolled up" into an archive file for ease of distribution. It is these archive files which form the actual package for the project, and a key file in any package should be its configure script.


## 3) Package users : The people who execute this macro.

### 3.1) Macros that can't be configured.

When the user of this package executes its configure script with the ```--help``` command line option, the user won't see any information on how to use this macro.


### 3.2) Macros that can be configured.