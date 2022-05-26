# -----------------------------------------------------------------------------
# Macro : AX_BISON_SKELETON
# =========================
#
# This macro can be used to instruct the GNU Autotools as to which Skeleton file
# GNU Bison should use.
# -----------------------------------------------------------------------------
# Explanation of this macro's --with-bison-skeleton option values.
#
#   yes : This value indicates that the Package configurer wants to use a Bison
#         Skeleton file. Since the Package configurer hasn't specified an exact
#         Bison Skeleton file to use, use the default Bison Skeleton file which
#         has been specified by the Package maintainer in the package's
#         configure.ac file.
#
#   no  : This value indicates that the Package configurer does not want to use
#         a Bison Skeleton file. There is a problem with this, and that is that
#         the package needs to use a Bison Skeleton file. As a result, this
#         macro will exit with a failure, informing the Package configurer of
#         the problem.
#
#   Any other value : This macro will assume that any value other than yes or
#                     no is the name of a Bison Skeleton file.
#
# Note : This macro does not check to see if the Bison Skeleton file which is
#        ultimately selected by this macro, actually exists.
# -----------------------------------------------------------------------------


AC_DEFUN(

  [AX_BISON_SKELETON],

  [
    # Save the value which was passed to this macro's $1 variable.
    #
    # The reason for doing this is because other code within the body of this
    # macro uses this same variable and overwrites its value.

    BISON_SKELETON_DEFAULT=$1


    # Enable and setup this macro's --with option.

    AC_ARG_WITH(
      [bison-skeleton],
      [
AS_HELP_STRING(
[--with-bison-skeleton=@<:@yes|no|FILENAME@:>@],
[instruct GNU Bison which Skeleton file to use (ARG=bison_skeleton)]
)
      ],
      [BISON_SKELETON=${withval}]
    )

    # Set the value of the variable BISON_SKELETON.
    #
    # Exactly what it is set to, will depend upon the value which was passed to
    # this macro's --with option.

    AS_CASE(
      [${with_bison_skeleton}],
      [yes],
      [BISON_SKELETON=${BISON_SKELETON_DEFAULT}],
      [no],
      [
        AC_MSG_FAILURE(["You have to specify a Bison Skeleton file to use!"])
      ],
      [BISON_SKELETON=${with_bison_skeleton}]
    )

    # Instruct Autoconf to register the variable BISON_SKELETON.
    #
    # This registers the variable - along with its value, with the configure
    # script. By doing this, it allows the rest of the configure script to see
    # and thus use this variable.

    AC_SUBST(BISON_SKELETON)

    AC_MSG_NOTICE([BISON_SKELETON = ${BISON_SKELETON}])
  ]
)
