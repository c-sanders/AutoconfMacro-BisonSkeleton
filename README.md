Filename : README.md


### 1) Introduction

The 

The sole reason this package exists, is because it contains a file called ```ax_bison_skeleton.m4```.
This file implements a GNU Autoconf macro which can be used for specifying the Skeleton file which
GNU Bison should use to build its parser. The macro is called
```AX_BISON_SKELETON``` and in order for a GNU Autotools package to use it properly, it must be
invoked from within the package's ```configure.ac``` file as follows;

```
AX_BISON_SKELETON()
```

If the GNU Autotools are able to successfully process a project which uses this macro, then they
should generate a file which is called ```configure```. This file is referred to as the configure
script for the project which it was generated for, and if the ```AX_BISON_SKELETON``` macro was able
to be successfully incorporated into this configure script by the GNU Autotools, then the
following configure script option should be available when this configure script is invoked with
the ```--help``` option;

```
--with-bison-skeleton=[bison_skeleton]
                        instruct GNU Bison to use the specified Skeleton
                        file
                        (ARG=lalr1.cc)
```


### 2) Implementation of the macro

The macro is implemented in a rather basic fashion. It does not do anything too complex, and most of
the work is offloaded onto the GNU Autoconf macro ```AC_CHECK_PROG```.

As at 12 April 2022, the macro was implemented as follows;

```
01 # -----------------------------------------------------------------------------
02 # Macro : AX_BISON_SKELETON
03 # =========================
04 #
05 # This macro can be used to tell the GNU Autotools which Skeleton file GNU
06 # Bison should use.
07 # -----------------------------------------------------------------------------
08
09
10 AC_DEFUN(
11
12   [AX_BISON_SKELETON],
13
14   [
15    AC_ARG_WITH(
16 	  [bison-skeleton],
17 	  [
18     AS_HELP_STRING(
19 [--with-bison-skeleton=@<:@bison_skeleton@:>@],
20 [instruct GNU Bison to use the specified Skeleton file]
21 )
22    ],
	  [BISON_SKELETON=${withval}],
	  [BISON_SKELETON=""]
	)
	AS_CASE(
	  [${withval}],
	  [yes], [BISON_SKELETON="lalr1.cc",
	  [no],  [BISON_SKELETON="lalr1.cc"],
	  [BISON_SKELETON="${withval}"]
	)
	AC_SUBST(BISON_SKELETON)
  ]
)
```

- ```AC_DEFUN```

This is what is actually responsible for the definition of the macro.

The first argument on line 12 declares the name of the macro which is being defined, i.e.
```AX_BISON_ROOTDIR```.

The second argument on lines 14-33, define the body of the macro.


- ```AC_ARG_WITH```

This defines the variable which is associated with this macro.

The first argument on line 16 declares the name of the variable, i.e.```bison_rootdir``.

The second argument on lines 17-22 defines how the macro is presented to the user of the configure
script.

The third argument on line 23 specifies what to set the environment variable to if found.

The fourth argument on line 24 specifies what to set the environment variable to if not found.


- ```AS_CASE```



















