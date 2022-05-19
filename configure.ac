# ------------------------------------------------------------------------------
# Filename : configure.ac
# =======================
#
# Process this file with autoconf to produce a configure script.
# ------------------------------------------------------------------------------


# AC_INIT(
#		[Simple Scanner generated using GNU Flex],
#		[0.0.1],
#		[support@gravitas.com],
#		[SimpleScanner],
#		[http://www.gravitas-toolworks.com])

AC_INIT(
        [SimpleScanner],
		[0.0.1])

AC_CONFIG_SRCDIR([cpp/src/SimpleScanner.l])

m4_include([m4/ax_flex_rootdir.m4])
m4_include([m4/ax_bison_rootdir.m4])
m4_include([m4/ax_bison_skeleton.m4])

AC_CONFIG_AUX_DIR(config)

AM_INIT_AUTOMAKE([subdir-objects])

AC_CONFIG_MACRO_DIR([m4])

AC_PROG_CC

AC_PROG_CXX(
			[${CXX}]
		   )

AM_PROG_LEX

AC_PROG_YACC

AC_PROG_LIBTOOL

AX_FLEX_ROOTDIR()
AX_BISON_ROOTDIR()
AX_BISON_SKELETON(["glr2.cc"])

# LT_INIT([preserve-dup-deps])

AC_OUTPUT([
           Makefile
           c/Makefile
           c/src/Makefile
           c/src/SimpleParser.y
           cpp/Makefile
           cpp/src/Makefile
           cpp/src/SimpleParser.y
])
