# -----------------------------------------------------------------------------
# Macro : AX_BISON_SKELETON
# =========================
#
# This macro can be used to instruct the GNU Autotools as to which Skeleton file
# GNU Bison should use.
# -----------------------------------------------------------------------------
# Explanation of the --with-bison-skeleton option values.
#
#   yes : This value indicates that the Package configurer wants to use a Bison
#         Skeleton file. Since the Package configurer hasn't specified the exact
#         Bison Skeleton file to use, the configuration and build systems should
#         instead use the default Bison Skeleton file which has been specified
#         by the Package maintainer in the package's configure.ac file.
#
#   no  : This value indicates that the Package configurer does not want to use
#         a Bison Skeleton file. The problem with this, is that the package
#         needs to use a Bison Skeleton file. As a result, this macro will exit
#         with an error. informing the Package configurer of the problem.
#
#   Any other value : This macro will assume that any value other than yes or
#                     no is the name of the Bison Skeleton file which should be
#                     used by the configuration and build systems.
#
# Note : This macro does not check to see if the Bison Skeleton file which is
#        ultimately selected by this macro, actually exists.
# -----------------------------------------------------------------------------


AC_DEFUN(

  [AX_BISON_SKELETON],

  [
	AC_ARG_WITH(
	  [bison-skeleton],
	  [
AS_HELP_STRING(
[--with-bison-skeleton=@<:@ARG@:>@],
[instruct GNU Bison which Skeleton file to use (ARG=bison_skeleton)]
)
	  ],
	  [BISON_SKELETON=${withval}]
	)
	AS_CASE(
	  [${withval}],
	  [yes],
	  [BISON_SKELETON=$1],
	  [no],
	  [
	    AC_MSG_ERROR(["You have to specify a Bison Skeleton file to use!"])
	  ],
	  [BISON_SKELETON=${withval}]
	)
AC_SUBST(BISON_SKELETON)

	AC_MSG_NOTICE(["BISON_SKELETON = ${BISON_SKELETON}"])
  ]
)
