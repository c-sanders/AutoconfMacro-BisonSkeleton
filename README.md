Filename : README.md


### 1) Introduction

This package implements a GNU Autoconf macro which is called ```AX_BISON_SKELETON```. This macro can
be used to specify the Skeleton file which GNU Bison should use to build its Parser.

The macro is implemented in the file ```ax_bison_skeleton.m4```, which resides within the m4
sub-directory of this package.

It might be worth mentioning that this macro is the sole reason for this package's existence - that
is, this package wouldn't exist if it wasn't for this macro.


### 2) Purpose of the macro

The purpose of this macro, is to ascertain if a GNU Bison Skeleton file should be used for the configuration and building of a particular project. In the case where a specific Skeleton file should be used, the name of the desired Skeleton file can be passed as an argument to this macro, using its ```--with``` configure script option.

If it is ascertained that a Skeleton file should indeed be used, and the name of one has been specified, then the ```AX_BISON_SKELETON``` macro will set an environment variable called ```BISON_SKELETON``` with the name of the Skeleton file which should be used by the project.


### 3) GNU Bison Skeleton files

When GNU Bison creates a Parser, it doesn't do so from scratch. Instead, it uses as a starting
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

![AutoconfMacro-BisonSkeleton macro flowchart](./images/flowchart.png)

As at 27 May 2022, the macro was implemented as follows;

```
01 # -----------------------------------------------------------------------------
02 # Macro : AX_BISON_SKELETON
03 # =========================
04 #
05 # This macro can be used to instruct the GNU Autotools as to which Skeleton file
06 # GNU Bison should use.
07 # -----------------------------------------------------------------------------
08 # Explanation of values which can be passed to this macro's --with option.
09 #
10 #   yes :
11 #
12 #   This value indicates that the Package configurer wants to use a Bison
13 #   Skeleton file. Since the Package configurer hasn't specified an exact Bison
14 #   Skeleton file to use, use the default one  which has been
15 #   specified by the Package maintainer in the package's configure.ac file.
16 #
17 #   no :
18 #
19 #   This value indicates that the Package configurer does not want to use a
20 #   Bison Skeleton file. There is a problem with this however, and that is that the
21 #   package needs to use a Bison Skeleton file. As a result, this macro will
22 #   exit with a failure, informing the Package configurer of the problem.
23 #
24 #   Any other value :
25 #
26 #   This macro will assume that any value other than yes or no is the name of a
27 #   Bison Skeleton file.
28 #
29 # Note :
30 #
31 # This macro does not check to see if the Bison Skeleton file which is
32 # ultimately selected by it, actually exists.
33 # -----------------------------------------------------------------------------
34 
35 
36 AC_DEFUN(
37 
38   [AX_BISON_SKELETON],
39 
40   [
41     # Save the value which was passed to this macro's $1 variable.
42     #
43     # The reason for doing this is because other code within the body of this
44     # macro uses this same variable and thus overwrites its value.
45 
46     BISON_SKELETON_DEFAULT=$1
47 
48 
49     # Enable and setup this macro's --with option.
50 
51     AC_ARG_WITH(
52       [bison-skeleton],
53       [
54 AS_HELP_STRING(
55 [--with-bison-skeleton=@<:@yes|no|FILENAME@:>@],
56 [instruct GNU Bison which Skeleton file to use (ARG=bison_skeleton)]
57 )
58       ],
59       [BISON_SKELETON=${withval}]
60     )
61 
62     # Set the value of the variable BISON_SKELETON.
63     #
64     # Exactly what it is set to, will depend upon the value which was passed to
65     # this macro's --with option.
66 
67     AS_CASE(
68       [${with_bison_skeleton}],
69       [yes],
70       [BISON_SKELETON=${BISON_SKELETON_DEFAULT}],
71       [no],
72       [
73         AC_MSG_FAILURE(["You have to specify a Bison Skeleton file to use!"])
74       ],
75       [BISON_SKELETON=${with_bison_skeleton}]
76     )
77 
78     # Instruct Autoconf to register the variable BISON_SKELETON.
79     #
80     # This registers the variable - along with its value, with the configure
81     # script. By doing this, it allows the rest of the configure script to see
82     # and thus use this variable.
83 
84     AC_SUBST(BISON_SKELETON)
85 
86     AC_MSG_NOTICE([BISON_SKELETON = ${BISON_SKELETON}])
87   ]
88 )
```

- ```BISON_SKELETON_DEFAULT=$1```

```$1``` holds the value of the first command line argument which was passed to this macro. The macro should save this value into the variable ```BISON_SKELETON_DEFAULT```, because other code within the body of this macro also uses the ```$1``` variable, and if it doesn't save its value, then it will be lost.

When this macro is first invoked, ```$1``` will contain the value which was passed to it, when it was invoked from a package's ```configure.ac``` file. 

- ```AC_DEFUN```

This is what is actually responsible for the definition of the macro.

1) The first argument on line 38 declares the name of the macro which is being defined, i.e.
```AX_BISON_SKELETON```.

2) The second argument on lines 40-87, defines the body of the macro.


- ```AC_ARG_WITH```

This instructs GNU Autoconf to make a ```--with``` option available for this macro. This ```--with``` option will be available from any configure script that uses this macro. For reasons that will be explained in a moment, the exact name of this macro's ```--with``` option is ```--with-bison-skeleton```.

1) The first argument on line 52 declares the specific name which will be associated with this macro. The value of this first argument is used to help form the name of the ```--with``` option which will be associated with this macro. Seeing as the value specified here is ```bison-skeleton```, the name of the resulting ```--with``` option for this macro will be ```--with-bison-skeleton```.

2) The second argument on lines 53-58 define how the usage for the ```--with-bison-skeleton``` option will be presented to the user of the configure script.

3) The third argument on line 59 specifies what actions the macro should take if the user of the configure script passes a value to the ```--with-bison-skeleton``` option.


- ```AS_CASE```

This implements a switch statement, which is based upon the value that was passed to the ```--with-bison-skeleton``` option by the user of the configure script. The actions that the macro performs, are also dependent upon this same value.
 
1) The first argument on line 68 instructs the macro as to what value it should make its decision on.

2) The second and third arguments on lines 69 and 70, state that if a value of ```yes``` was passed as an argument to the ```--with-bison-skeleton``` option, then the value of the variable ```BISON_SKELETON``` should be set to the default value of ```BISON_SKELETON_DEFAULT```.

3) The fourth and fifth arguments on lines 71-74, state that if a value of ```no``` was passed as an argument to the ```--with-bison-skeleton``` option, then a failure message should be presented to the person running the configure script. A failure message means that the configure script will display the specified message and then terminate with a failure. The reason for this is because the user of the configure script has elected not to stipulate a Skeleton file - and this is a problem, because the project which is being configured needs to use a Skeleton file.

4) The sixth argument on line 75 instructs the macro to set the environment variable ```BISON_SKELETON``` to the value which was passed to the ```--with-bison-skeleton``` option by the user of the configure script. This macro does not check to see if the value which was passed to this option is valid or not, so the user of the configure script needs to be careful as to what values they pass it!


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















