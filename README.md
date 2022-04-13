Filename : README.md


### 1) Introduction

This package implements a GNU Autoconf macro which is called ```AX_BISON_SKELETON```. This macro can
be used to specify the Skeleton file which GNU Bison should use to build its Parser.

The macro is implemented in the file ```ax_bison_skeleton.m4```, which resides within the m4
sub-directory of this package.

It might be worth mentioning that this macro is the sole reason for this package's existence - that
is, this package wouldn't exist if it wasn't for this macro.


### 2) GNU Bison Skeleton files

When GNU Bison creates a Parser, it doesn't do it from scratch. Instead, it uses as a starting
point, one of the Skeleton files that are distributed with the GNU Bison package. Depending upon how
GNU Bison has been installed on any particular system, one may be able to find these Skeleton files
within the following sub-directory of the location into which GNU Bison has been installed;

```
bison/skeletons
```

For GNU Bison 3.8, the Skeleton files which are available are;

- glr.cc
- glr2.cc
- lalr1.cc
- location.cc

### 3) Invoking the macro

In order for a GNU Autotools package to use this macro properly, the package must invoke the macro
from within its ```configure.ac``` file as follows;

```
AX_BISON_SKELETON()
```

If the GNU Autotools are able to successfully process a project which uses this macro, then they
should generate a file which is called ```configure```. This file is referred to as the configure
script for the project which it was generated for, and if the ```AX_BISON_SKELETON``` macro was able
to be successfully incorporated into this configure script by the GNU Autotools, then the
following configure script option should show up when this configure script is invoked with the
```--help``` option;

```
--with-bison-skeleton=[bison_skeleton]
                        instruct GNU Bison to use the specified Skeleton
                        file
                        (ARG=lalr1.cc)
```


### 3) Implementation of the macro

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
15     AC_ARG_WITH(
16       [bison-skeleton],
17       [
18         AS_HELP_STRING(
19           [--with-bison-skeleton=@<:@bison-skeleton@:>@],
20           [instruct GNU Bison as to which Skeleton file to use (ARG=bison_skeleton_file)]
21         )
22       ],
23       [BISON_SKELETON=${withval}],
24       [BISON_SKELETON=""]
25     )
26     AS_CASE(
27       [${withval}],
28       [yes], [BISON_SKELETON="lalr1.c"],
29       [no],  [BISON_SKELETON="lalr1.c"],
30       [BISON_SKELETON="${withval}"]
31     )
32     AC_SUBST(BISON_SKELETON)
33   ]
34 )
```

- ```AC_DEFUN```

This is what is actually responsible for the definition of the macro.

1) The first argument on line 12 declares the name of the macro which is being defined, i.e.
```AX_BISON_SKELETON```.

2) The second argument on lines 14-33, define the body of the macro.


- ```AC_ARG_WITH```

This informs GNU Autoconf that an external package with a specific name, may be required by the current package.

1) The first argument on line 16 declares both the specific name for the package and the ```--with``` option which will be associated with this macro. Seeing as the value specified here is ```bison-skeleton```, the resulting ```--with``` option for this macro will be ```--with-bison-skeleton```.

2) The second argument on lines 17-22 defines how the ```--with``` option for this macro will be presented to the user of the configure script.

3) The third argument on line 23 specifies what actions to take if the user of the configure script specifies a value for the ```--with-bison-skeleton``` option.

4) The fourth argument on line 24 specifies what actions to take if the user of the configure script does not specify a value for the ```--with-bison-skeleton``` option.


- ```AS_CASE```




















