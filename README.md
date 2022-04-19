Filename : README.md


### 1) Introduction

This package implements a GNU Autoconf macro which is called ```AX_BISON_SKELETON```. This macro can
be used to specify the Skeleton file which GNU Bison should use to build its Parser.

The macro is implemented in the file ```ax_bison_skeleton.m4```, which resides within the m4
sub-directory of this package.

It might be worth mentioning that this macro is the sole reason for this package's existence - that
is, this package wouldn't exist if it wasn't for this macro.


### 2) Purpose of the macro

The purpose of this macro, is to enable the GNU Autotools to ascertain if a GNU Bison Skeleton file should be used for the configuration and building of a particular project. In the case where a Skeleton file should be used, the name of the desired Skeleton file can be passed as an argument to this macro.

If it is ascertained that a Skeleton file should indeed be used, and the name of one has been specified, then the ```AX_BISON_SKELETON``` macro will set an environment variable called ```BISON_SKELETON``` with the name of the Skeleton file which should be used by the project.


### 3) GNU Bison Skeleton files

When GNU Bison creates a Parser, it doesn't do it from scratch. Instead, it uses as a starting
point, one of the Skeleton files that are distributed with the GNU Bison package. Depending upon how
GNU Bison has been installed on any particular system, one may be able to find these Skeleton files
within the following sub-directory of the location into which GNU Bison has been installed;

```
share/bison/skeletons
```

For GNU Bison 3.8, some of the Skeleton files which are available are;

- glr.cc
- glr2.cc
- lalr1.cc
- location.cc

### 4) Invoking the macro

In order for a GNU Autotools project to use this macro properly, the project must invoke the macro
from within its ```configure.ac``` file as follows;

```
AX_BISON_SKELETON([])
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
                        (ARG=glr.cc)
```


### 5) Implementation of the macro

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
28       [yes], [BISON_SKELETON="lalr1.cc"],
29       [no],  [BISON_SKELETON="lalr1.cc"],
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

2) The second argument on lines 14-33, defines the body of the macro.


- ```AC_ARG_WITH```

This instructs GNU Autoconf to make available to the user of the configure script, the option of specifying an external package with a specific name.

1) The first argument on line 16 declares the specific name for the external package which may be required by the user of the configure script. The value of this first argument also helps to form the name for the ```--with``` option which will be associated with this macro. Seeing as the value specified here is ```bison-skeleton```, the resulting ```--with``` option for this macro will be called ```--with-bison-skeleton```.

2) The second argument on lines 17-22 defines how the ```--with-bison-skeleton``` option for this macro will be presented to the user of the configure script.

3) The third argument on line 23 specifies what actions the macro should take if the user of the configure script specifies a value for the ```--with-bison-skeleton``` option.

4) The fourth argument on line 24 specifies what actions the macro should take if the user of the configure script does not specify a value for the ```--with-bison-skeleton``` option.


- ```AS_CASE```

This implements a switch statement which processes the value that was passed to the ```--with-bison-skeleton``` by the user of the configure script.
 
1) The first argument on line 27 instructs the macro as to what value it should make its decision on.

2) The second argument on line 28 instructs the macro to set the environment variable ```BISON_SKELETON``` to the GNU Bison Skeleton file ```lalr1.cc``` if a value of ```yes"``` was passed to the ```--with-bison-skeleton``` option by the user of the configure script.

3) The third argument on line 29 instructs the macro to set the environment variable ```BISON_SKELETON``` to the GNU Bison Skeleton file ```lalr1.cc``` if a value of ```no"``` was passed to the ```--with-bison-skeleton``` option by the user of the configure script.

4) The fourth argument on line 30 instructs the macro to set the environment variable ```BISON_SKELETON``` to the value which was passed to the ```--with-bison-skeleton``` option by the user of the configure script. This macro does not check to see if the value which was passed to this option is valid or not, so the user of the configure script needs to be careful as to what values they pass it!


### 6) Behaviour of the macro

- By the person maintaining the package

- By the person maintaining the package

### 7) Usage of the macro

- By the person maintaining the package

If the project which is to be configured by the GNU Autotools, does - or even might, need the user running the configure script to specify which GNU Bison Skeleton file should be used, then this macro will need to be invoked from within the package's ```configure.ac``` file.

It should be invoked from within the package's ```configure.ac``` file in a manner which is similar to the following;

```
AX_BISON_SKELETON(["glr.c"])
```

Notice how the macro is invoked with an argument, in this case the value ```"glr.cc"```. If such an argument is specified by the package maintainer, then this will be used by the macro as the default value for the GNU Bison Skeleton file. That is, if the user of the configure script doesn't invoke the ```--with-bison-skeleton``` configure script option, then ...

- By the person configuring the package

If the person who is configuring the package wants to explicitly set the GNU Bison Skeleton file which is to be used by the package, then they will need 

An example invocation is shown below;

```
configre ... --with-bison-skeleton=/usr/local/bison-3.8/share/bison/skeletons/glr.c
```















