Filename : README_GNU_Autotools.md


## 1) Introduction.

GNU Autoconf macros can be classified as being either non configurable or configurable. But what does this mean exactly? To help try and explain the difference between the two categories, the next two sections will discuss each of them in turn.


### 1.1) Non configurable macros.

Consider the definition of the following non configurable GNU Autoconf macro.

```
01 AC_DEFUN(
02
03  [AX_TEST_MACRO],
04
05   [
06     # Set the variable and then instruct GNU Autoconf to register it with the
07     # configure script which GNU Autoconf will generate.
08     #
09     # If the variable isn't registered, then it won't be able to be seen or be
10     # used by other code outside of this macro.
11
12     TEST_MACRO_VARIABLE="Hello, World!"
13
14     AC_SUBST([TEST_MACRO_VARIABLE])
15   ]
16 )
```
> Code listing no. 1

This GNU Autoconf macro - which from now onwards will simply be referred to as a macro, is very basic in its nature. It doesn't do anything more than what its comments state; and that is to set the value of the variable named ```TEST_MACRO_VARIABLE``` and then register it, so that the variable can be seen and used by other code outside of the macro.

As was stated above, the macro which is defined in Code listing no. 1 implements a non configurable macro. This shouldn't come as a massive surprise, as there isn't anything in the body of the macro code for a potential user of the macro to configure! The macro itself sets the value of the variable, and then registers that same variable with GNU Autoconf. There is no way for a user of this macro to set the value of the variable ```TEST_MACRO_VARIABLE```, whether it be a Package maintainer or a Package user. Not only that, there is no way to pass configuration information into this macro in the first place, because the macro doesn't contain any functionality which allows it to do so. So this is what is meant, when the macro is referred to as being non configurable.

Since this macro is non configurable, it doesn't provide any command line information on how to use it; afterall, it doesn't need to. That is, if a package uses this macro, and a user of this same package invokes its configure script with the ```--help``` command line option, then the user won't receive any information on how to use this macro.


### 1.2) Configurable macros.

If the macro which is listed above in Code listing no. 1, might require configuration information to be passed to it, then it should have additional code added to it which will allow it to facilitate this functionality. At a bare minimum, this additional code should invoke the GNU Autoconf ```AC_ARG_WITH``` macro, in a manner which is similar to the following;

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
> Code listing no. 2


## 2) Using the macro.

Broadly speaking, people who will use this macro - or any GNU Autoconf macro for that matter, can be divided up into two categories, depending upon how they use the macros. They can be classified as using macros either indirectly or directly.

  1) Package maintainers - Indirect users of macros
  2) Package users - Direct users of macros

Package maintainers can be thought of as using macros in an indirect sense. What this means is that they don't actually execute or run the macros - rather, they just reference them in the ```configure.ac``` files that they write for their package.

Package users on the other hand, can be thought of as using macros in a direct sense. What this means is that they do actually execute or run the macos. When a Package user runs a package's configure script, they will be directly executing any macros that have been referenced by that package's ```configure.ac``` file.


## 3) Package maintainers : The people who reference this macro.

If a Package maintainer wanted to use the ```AX_TEST_MACRO``` macro in their particular package, then the macro will need to be referenced from within their package's ```configure.ac``` file. This can be done in a manner which is similar to the following;

```
AX_TEST_MACRO()
```

Once a package's ```configure.ac``` file has been finalised, the Package maintainer should generate a configure script for the package, using the GNU Autotools ```autoreconf``` command to do so.

When a Package maintainer is ready to distribute their package to users, all of the files which are to form the package should be "rolled up" into an archive file for ease of distribution. It is these archive files which form the actual package for the project, and a key file in any package should be its configure script.


## 3) Package users : The people who execute this macro.

### 3.1) Macros that can't be configured.

When the user of this package executes its configure script with the ```--help``` command line option, the user won't see any information on how to use this macro.


### 3.2) Macros that can be configured.