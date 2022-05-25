Filename : README_GNU_Autotools.md


## 1) Introduction.

  - Non configurable and configurable macros.

GNU Autoconf macros can be classified as being either non configurable or configurable. But what does this mean exactly? To help try and explain the difference between the two categories, the next section will discuss each of them in turn.

  - Package maintainers, Package installers, and Package users.

The definition of a Package maintainer is somewhat obvious, while the definition of a Package user is a bit more complex. The trouble is that Package users can derive from anyone of a number of different subclasses, e.g. Package configurers, Package builders, Package installers, etc.


## 2) Non configurable and configurable macros.

Let us first consider non configurable macros. After we are done discussing them, we will then turn
our attention to configurable macros.


### 2.1) Non configurable macros.

Consider the definition of the following non configurable GNU Autoconf macro. It implements a hypothetical macro which can be used to inform a configuration/build system, of the programming language which any plugins will be implemented in.

```
01 AC_DEFUN(
02
03  [AX_TEST_MACRO],
04
05   [
06     # Set the value of the variable PLUGIN_LANGUAGE and then instruct GNU
07     # Autoconf to register it with the configure script which GNU Autoconf
08     # will generate.
09     #
10     # If the variable isn't registered, then it won't be able to be seen and
11     # thus be used by any other code outside of this macro.
12
13     PLUGIN_LANGUAGE="python"
14
15     AC_SUBST([PLUGIN_LANGUAGE])
16   ]
17 )
```
> Code listing no. 1

This GNU Autoconf macro - which from now onwards will simply be referred to as a macro, is very basic in its nature.  It doesn't do anything more than what its comments state; and that is to set the value of the variable named ```PLUGIN_LANGUAGE``` and then register it. This second task is important, because if the variable isn't registered, then it won't be able to be seen and thus be used by any other code outside of the macro.

As was stated above, the macro which is defined in Code listing no. 1 implements a non configurable macro. This shouldn't come as a massive surprise, as there isn't really anything in the body of the macro code for any potential user of the macro to configure! The macro itself sets the value of the variable, and then registers that same variable with GNU Autoconf. It could be argued that a user of the macro could portentially  set the value of the variable ```PLUGIN_LANGUAGE```. However, as this macro exists currently, there is no way for a user to set the value of the variable; be the user a Package maintainer or a Package user. Not only that, there is no way to pass configuration information into this macro in the first place, because the macro doesn't contain any functionality which allows it to do so. So this is what is meant, when the macro is referred to as being non configurable.

Since this macro is non configurable, it doesn't provide any command line information on how to use it; afterall, it doesn't need to. That is, if a package uses this macro, and a user of this same package invokes its configure script with the ```--help``` command line option, then the user won't receive any information on how to use this macro. 

Consider the following simple ```configure.ac``` file. Note that it invokes the ```AX_TEST_MACRO``` macro. 

```
01 # Process this file with GNU Autoconf to produce a configure script.
02
03
04 AC_INIT(
05         [SimpleAutotoolsProject],
06         [0.0.1]
07 )
08
09 AC_CONFIG_SRCDIR([src/main.cpp])
10
11 m4_include([m4/ax_test_macro.m4])
12
13 AC_CONFIG_AUX_DIR(config)
14
15 AM_INIT_AUTOMAKE([subdir-objects])
16
17 AC_CONFIG_MACRO_DIR([m4])
18
19 AC_PROG_CC
20
21 AC_PROG_CXX([${CXX}])
22
23 AX_TEST_MACRO()
24
25 AC_OUTPUT([Makefile])
```
> Example configure.ac file

If this ```configure.ac``` file were to be used to generate a configure script, and this resulting configure script were to be invoked with the ```--help``` command line option, then the output would look something like the following.

```
001 `configure' configures SimpleAutotoolsProject 0.0.1 to adapt to many kinds of systems.
002
003 Usage: ./configure [OPTION]... [VAR=VALUE]...
004
005 To assign environment variables (e.g., CC, CFLAGS...), specify them as
006 VAR=VALUE.  See below for descriptions of some of the useful variables.
007
008 Defaults for the options are specified in brackets.
009
010 Configuration:
011   -h, --help              display this help and exit
012       --help=short        display options specific to this package
013       --help=recursive    display the short help of all the included packages
014   -V, --version           display version information and exit
015   -q, --quiet, --silent   do not print `checking ...' messages
016       --cache-file=FILE   cache test results in FILE [disabled]
017   -C, --config-cache      alias for `--cache-file=config.cache'
018   -n, --no-create         do not create output files
019       --srcdir=DIR        find the sources in DIR [configure dir or `..']
020
021 Installation directories:
022   --prefix=PREFIX         install architecture-independent files in PREFIX
023                           [/usr/local]
024   --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
025                           [PREFIX]
026
027 By default, `make install' will install all the files in
028 `/usr/local/bin', `/usr/local/lib' etc.  You can specify
029 an installation prefix other than `/usr/local' using `--prefix',
030 for instance `--prefix=$HOME'.
031
032 For better control, use the options below.
033
034 Fine tuning of the installation directories:
035   --bindir=DIR            user executables [EPREFIX/bin]
036   --sbindir=DIR           system admin executables [EPREFIX/sbin]
037   --libexecdir=DIR        program executables [EPREFIX/libexec]
038   --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
039   --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
040   --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
041   --runstatedir=DIR       modifiable per-process data [LOCALSTATEDIR/run]
042   --libdir=DIR            object code libraries [EPREFIX/lib]
043   --includedir=DIR        C header files [PREFIX/include]
044   --oldincludedir=DIR     C header files for non-gcc [/usr/include]
045   --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
046   --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
047   --infodir=DIR           info documentation [DATAROOTDIR/info]
048   --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
049   --mandir=DIR            man documentation [DATAROOTDIR/man]
050   --docdir=DIR            documentation root [DATAROOTDIR/doc/simpleautotoolsproject]
051   --htmldir=DIR           html documentation [DOCDIR]
052   --dvidir=DIR            dvi documentation [DOCDIR]
053   --pdfdir=DIR            pdf documentation [DOCDIR]
054   --psdir=DIR             ps documentation [DOCDIR]
055
056 Program names:
057   --program-prefix=PREFIX            prepend PREFIX to installed program names
058   --program-suffix=SUFFIX            append SUFFIX to installed program names
059   --program-transform-name=PROGRAM   run sed PROGRAM on installed program names
060
061 System types:
062   --build=BUILD     configure for building on BUILD [guessed]
063   --host=HOST       cross-compile to build programs to run on HOST [BUILD]
064
065 Optional Features:
066   --disable-option-checking  ignore unrecognized --enable/--with options
067   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
068   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
069   --enable-silent-rules   less verbose build output (undo: "make V=1")
070   --disable-silent-rules  fGoodbyeverbose build output (undo: "make V=0")
071   --enable-dependency-tracking
072                           do not reject slow dependency extractors
073   --disable-dependency-tracking
074                           speeds up one-time build
075   --enable-shared[=PKGS]  build shared libraries [default=yes]
076   --enable-static[=PKGS]  build static libraries [default=yes]
077   --enable-fast-install[=PKGS]
078                           optimize for fast installation [default=yes]
079   --disable-libtool-lock  avoid locking (might break parallel builds)
080
081 Optional Packages:
082   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
083   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
084   --with-pic[=PKGS]       try to use only PIC/non-PIC objects [default=use
085                           both]
086   --with-aix-soname=aix|svr4|both
087                           shared library versioning (aka "SONAME") variant to
088                           provide on AIX, [default=aix].
089   --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
090   --with-sysroot[=DIR]    Search for dependent libraries within DIR (or the
091                           compiler's sysroot if not specified).
092
093 Some influential environment variables:
094   CC          C compiler command
095   CFLAGS      C compiler flags
096   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
097               nonstandard directory <lib dir>
098   LIBS        libraries to pass to the linker, e.g. -l<library>
099   CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
100               you have headers in a nonstandard directory <include dir>
101   CXX         C++ compiler command
102   CXXFLAGS    C++ compiler flags
103   YACC        The `Yet Another Compiler Compiler' implementation to use.
104               Defaults to the first program found out of: `bison -y', `byacc',
105               `yacc'.
106   YFLAGS      The list of arguments that will be passed by default to $YACC.
107               This script will default YFLAGS to the empty string to avoid a
108               default value of `-d' given by some make applications.
109   LT_SYS_LIBRARY_PATH
110               User-defined run-time library search path.
111   CPP         C preprocessor
112   CXXCPP      C++ preprocessor
113
114 Use these variables to override the choices made by `configure' or to help
115 it to find libraries and programs with nonstandard names/locations.
116
117 Report bugs to the package provider.
```
> configure --help output no. 1

Note in the ```Optional Features:``` section of the output on lines 66 -> 79, and also the ```Optional Packages:``` section of the output on lines 82 -> 91, that there is no mention of how to use the ```AX_TEST_MACRO``` macro. 

### 2.2) Configurable macros.

Configuration information can be passed into a macro in one of two different ways;

  - by the Package maintainer
  - by the Package user

#### 2.2.1) Package maintainer.

Recall from Code listing no. 1 that the plugin language was set to python. Now consider what would happen if a Package maintainer wanted to change it to another language; say ```java``` for example. They would need to edit the body of the macro and replace ```python``` with ```java```. But what if the Package maintainer could pass the desired plugin language as an argument to the macro, when they invoked it from the ```configure.ac``` file? That is, something like the following;

```
AX_TEST_MACRO(["java"])
```

As it happens, this can indeed be done! If we take the code from Code listing no. 1 and make the slightest of changes to it, then we will get the code which is shown below in Code listing no. 2. Unlike the macro which was defined in Code listing no. 1, this macro is now configurable. But just how does it achieve its configurability? The desired plugin language should be passed to this macro as an argument - as was demonstrated just above. This argument is then referred to within the body of the macro as ```$1```, as can be seen below; and this is how the macro achieves its configurability. It means that the macro can be configured with a different language every time it is invoked.

```
01 AC_DEFUN(
02
03  [AX_TEST_MACRO],
04
05   [
06     # Set the value of the variable PLUGIN_LANGUAGE and then instruct GNU
07     # Autoconf to register it with the configure script which GNU Autoconf
08     # will generate.
09     #
10     # If the variable isn't registered, then it won't be able to be seen and
11     # thus be used by any other code outside of this macro.
12
13     PLUGIN_LANGUAGE=$1
14
15     AC_SUBST([PLUGIN_LANGUAGE])
16   ]
17 )
```
> Code listing no. 2


#### 2.2.2) Package configurer.

Now imagine a scenario, where the Package configurer wants to select a plugin language which is different to the one which has been set by the Package maintainer. In order to accomplish this, the Package user would somehow need to inform the configuration system of this fact. In the context of the GNU Autotools system, this means passing information - in the form of a command line option and associated value, to the package's configure script. To be able to do this however, the configure script would first need to be altered, so that it could support having such information passed to it in the first place.

Looking through the output from the --configure --help command which was displayed earlier, we can see that there are a number of options which are listed under the ```Optional Packages:``` section. It would be nice if the configure script supplied an option which would allow it to support the specification of a plugin language. That is, it would be nice if the configuration script provided an option which was akin to the following;

```
--with-plugin-language=PLUGIN_LANG
```

To get the configure script to support such an option, we need to go about it in a roundabout kind of way. First, we need to add additional functionality to the ```AX_TEST_MACRO```, which will support this desired behaviour. Recall that GNU Autoconf creates a configure script for a given package, by copying and expanding the contents of a series of macros - which are initially defined in the package's configure.ac file, into a configure script. Since a package's configure script is created in this fashion, it means that this additional functionality which will be implemented in the ```AX_TEST_MACRO```, will ultimately end up in the package's configure script. At a bare minimum, this additional code should invoke the GNU Autoconf ```AC_ARG_WITH``` macro, in a manner which is similar to that shown in lines 6 -> 16 below. You can probably guess from the name of the ```AC_ARG_WITH``` macro, that it is used to provide a ```--with``` option to other GNU Autoconf macros. The reason that the name of this macro starts with ```AC_```, is to inform users of this macro, that it is a GNU Autoconf macro - hence the AC in the prefix of the macro name.

```
01 AC_DEFUN(
02
03  [AX_TEST_MACRO],
04
05  [
06     AC_ARG_WITH(
07       [test-macro],
08       [
09 AS_HELP_STRING(
10 [--with-plugin-language=PLUGIN_LANG],
11 [inform the system of the plugin language]
12 )
13       ],
14       [PLUGIN_LANGUAGE=${withval}],
15       [PLUGIN_LANGUAGE="python"]
16     )
17
18     # The call to AC_ARG_WITH will have set the value of the variable
19     # TEST_MACRO_VARIABLE.
20
21     # Instruct GNU Autoconf to register the variable with the configure script.
22     #
23     # If the variable isn't registered, then it won't be able to be seen or be
24     # used by other code outside of this macro.
25
26     AC_SUBST([PLUGIN_LANGUAGE])
27   ]
28 )
```
> Code listing no. 3

A few points need to be made about the the code which is listed above.

The first is with regard to the alignment of the ```AS_HELP_STRING``` macro. Notice how the call to this macro does not lineup with the surrounding code in respect to indentation; that is, it is not preceded by any whitespace. If it were, then the configure script help string which is associated with the ```AX_TEST_MACRO``` would appear out of alignment when a user invokes ```configure --help``` on any package which uses this macro.

The second point pertains to the ```AC_ARG_WITH``` macro which is used by ```AX_TEST_MACRO```. ```AC_ARG_WITH``` is comprised of four parameters.

1. : A name to associate with this macro's --with option.
2. : A help string to associate with this macro's --with option.
3. : What action to take if the Package configurer passes a value to this macro's --with option.
4. : What action to take if the Package configurer doesn't pass a value to this macro's --with option.

From line 15 of Code listing no. 3, you can see that if the Package configurer doesn't supply a value to the --with option of the ```AX_TEST_MACRO``` option, then the plugin language will be configured by default to be python. That is, if the Package configurer invokes the package's configure script 

```
configure ... --with-plugin-language
```

```
001 `configure' configures SimpleAutotoolsProject 0.0.1 to adapt to many kinds of systems.
002
003 Usage: ./configure [OPTION]... [VAR=VALUE]...
004
005 To assign environment variables (e.g., CC, CFLAGS...), specify them as
006 VAR=VALUE.  See below for descriptions of some of the useful variables.
007
008 Defaults for the options are specified in brackets.
009
010 Configuration:
011   -h, --help              display this help and exit
012       --help=short        display options specific to this package
013       --help=recursive    display the short help of all the included packages
014   -V, --version           display version information and exit
015   -q, --quiet, --silent   do not print `checking ...' messages
016       --cache-file=FILE   cache test results in FILE [disabled]
017   -C, --config-cache      alias for `--cache-file=config.cache'
018   -n, --no-create         do not create output files
019       --srcdir=DIR        find the sources in DIR [configure dir or `..']
020
021 Installation directories:
022   --prefix=PREFIX         install architecture-independent files in PREFIX
023                           [/usr/local]
024   --exec-prefix=EPREFIX   install architecture-dependent files in EPREFIX
025                           [PREFIX]
026
027 By default, `make install' will install all the files in
028 `/usr/local/bin', `/usr/local/lib' etc.  You can specify
029 an installation prefix other than `/usr/local' using `--prefix',
030 for instance `--prefix=$HOME'.
031
032 For better control, use the options below.
033
034 Fine tuning of the installation directories:
035   --bindir=DIR            user executables [EPREFIX/bin]
036   --sbindir=DIR           system admin executables [EPREFIX/sbin]
037   --libexecdir=DIR        program executables [EPREFIX/libexec]
038   --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
039   --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
040   --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
041   --runstatedir=DIR       modifiable per-process data [LOCALSTATEDIR/run]
042   --libdir=DIR            object code libraries [EPREFIX/lib]
043   --includedir=DIR        C header files [PREFIX/include]
044   --oldincludedir=DIR     C header files for non-gcc [/usr/include]
045   --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
046   --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
047   --infodir=DIR           info documentation [DATAROOTDIR/info]
048   --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
049   --mandir=DIR            man documentation [DATAROOTDIR/man]
050   --docdir=DIR            documentation root [DATAROOTDIR/doc/simpleautotoolsproject]
051   --htmldir=DIR           html documentation [DOCDIR]
052   --dvidir=DIR            dvi documentation [DOCDIR]
053   --pdfdir=DIR            pdf documentation [DOCDIR]
054   --psdir=DIR             ps documentation [DOCDIR]
055
056 Program names:
057   --program-prefix=PREFIX            prepend PREFIX to installed program names
058   --program-suffix=SUFFIX            append SUFFIX to installed program names
059   --program-transform-name=PROGRAM   run sed PROGRAM on installed program names
060
061 System types:
062   --build=BUILD     configure for building on BUILD [guessed]
063   --host=HOST       cross-compile to build programs to run on HOST [BUILD]
064
065 Optional Features:
066   --disable-option-checking  ignore unrecognized --enable/--with options
067   --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
068   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
069   --enable-silent-rules   less verbose build output (undo: "make V=1")
070   --disable-silent-rules  verbose build output (undo: "make V=0")
071   --enable-dependency-tracking
072                           do not reject slow dependency extractors
073   --disable-dependency-tracking
074                           speeds up one-time build
075   --enable-shared[=PKGS]  build shared libraries [default=yes]
076   --enable-static[=PKGS]  build static libraries [default=yes]
077   --enable-fast-install[=PKGS]
078                           optimize for fast installation [default=yes]
079   --disable-libtool-lock  avoid locking (might break parallel builds)
080
081 Optional Packages:
082   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
083   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
084   --with-pic[=PKGS]       try to use only PIC/non-PIC objects [default=use
085                           both]
086   --with-aix-soname=aix|svr4|both
087                           shared library versioning (aka "SONAME") variant to
088                           provide on AIX, [default=aix].
089   --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
090   --with-sysroot[=DIR]    Search for dependent libraries within DIR (or the
091                           compiler's sysroot if not specified).
092
093   --with-value[=ARG]      instruct the macro to set the variable to the
094                           specified value
095
096 Some influential environment variables:
097   CC          C compiler command
098   CFLAGS      C compiler flags
099   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
100               nonstandard directory <lib dir>
101   LIBS        libraries to pass to the linker, e.g. -l<library>
102   CPPFLAGS    (Objective) C/C++ preprocessor flags, e.g. -I<include dir> if
103               you have headers in a nonstandard directory <include dir>
104   CXX         C++ compiler command
105   CXXFLAGS    C++ compiler flags
106   YACC        The `Yet Another Compiler Compiler' implementation to use.
107               Defaults to the first program found out of: `bison -y', `byacc',
108               `yacc'.
109   YFLAGS      The list of arguments that will be passed by default to $YACC.
110               This script will default YFLAGS to the empty string to avoid a
111               default value of `-d' given by some make applications.
112   LT_SYS_LIBRARY_PATH
113               User-defined run-time library search path.
114   CPP         C preprocessor
115   CXXCPP      C++ preprocessor
116
117 Use these variables to override the choices made by `configure' or to help
118 it to find libraries and programs with nonstandard names/locations.
119
120 Report bugs to the package provider.
```
> configure --help output no. 2

Note in the ```Optional Packages:``` section of the output on line 93, that there is now a mention of how to use the AX_TEST_MACRO macro.

## 3) Using the macro.

Broadly speaking, people who will use this macro - or any GNU Autoconf macro for that matter, can be divided up into two categories, depending upon how they use the macros. They can be categorised as using macros either indirectly or directly.

  1) Indirect users of macros -> Package maintainers
  2) Direct users of macros   -> Package users

#### Package maintainers.

Package maintainers can be thought of as using macros in an indirect sense. What this means is that they don't actually execute or run the macros - rather, they just reference them in the ```configure.ac``` files that they write for their package. Even when a Package maintainer uses GNU Autoconf to generate a configure script for their package, they are still not executing or running the macros. All that GNU Autoconf is actually doing is copying the code for the macros into the package's resulting configure script.

#### Package users.

Package users on the other hand, can be thought of as using macros in a direct sense. What this means is that they do actually execute or run the macos. When a Package user runs a package's configure script, they will be directly executing any macros that have been referenced by that package's ```configure.ac``` file.


### 3.1) Package maintainers : The people who reference this macro.

If a Package maintainer wanted to use the ```AX_TEST_MACRO``` macro in their particular package, then the macro will need to be referenced from within their package's ```configure.ac``` file. This can be done in a manner which is similar to the following;

```
AX_TEST_MACRO()
```

Once a package's ```configure.ac``` file has been finalised, the Package maintainer should generate a configure script for the package, using the GNU Autotools ```autoreconf``` command to do so.

When a Package maintainer is ready to distribute their package to users, all of the files which are to form the package should be "rolled up" into an archive file for ease of distribution. It is these archive files which form the actual package for the project, and a key file in any package should be its configure script.


### 3.2) Package users : The people who execute this macro.

#### 3.2.1) Macros that can't be configured.

When the user of this package executes its configure script with the ```--help``` command line option, the user won't see any information on how to use this macro.


#### 3.2.2) Macros that can be configured.