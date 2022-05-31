# ------------------------------------------------------------------------------
# Macro : AX_BISON_SKELETON
# =========================
#
# This macro can be used to instruct the GNU Autotools on which Skeleton file
# GNU Bison should use.
# ------------------------------------------------------------------------------
# Explanation of values which can be passed to this macro's --with option.
#
#   yes :
#
#   This value indicates that the Package configurer wants to use a Bison
#   Skeleton file. Since the Package configurer hasn't specified an exact Bison
#   Skeleton file to use, use the default Bison Skeleton file which has been
#   specified by the Package maintainer in the package's configure.ac file.
#
#   no :
#
#   This value indicates that the Package configurer does not want to use a
#   Bison Skeleton file. There is a problem with this, and that is that the
#   package needs to use a Bison Skeleton file. As a result, this macro will
#   exit with a failure, informing the Package configurer of the problem.
#
#   Any other value :
#
#   This macro will assume that any value other than yes or no is the name of a
#   Bison Skeleton file.
#
# Note :
#
# This macro does not check to see if the Bison Skeleton file which is
# ultimately selected by it, actually exists.
# ------------------------------------------------------------------------------


AC_DEFUN(

  [AX_BISON_SKELETON],

  [
    # Save the value which was passed to this macro's $1 variable.
    #
    # The reason for doing this is because other code within the body of this
    # macro uses this same variable and thus overwrites its value.
    #
    # If $1 == "", i.e. it is not set / set to an empty string, then this will
    # be a problem if the Package configurer passes a value of "yes" to this
    # macro's --with option.

    BISON_SKELETON_DEFAULT=$1


    # Enable and setup this macro's --with option.

    AC_ARG_WITH(
      [bison-skeleton],
      [
AS_HELP_STRING(
[--with-bison-skeleton=<yes|no|FILENAME>],
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
      [
        if test "x${BISON_SKELETON_DEFAULT}" == "x"
        then
          AC_MSG_WARN([================================================================================])
          AC_MSG_WARN([The configure script has encountered a problem :])
          AC_MSG_WARN([------------------------------------------------])
          AC_MSG_WARN([])
          AC_MSG_WARN([  > The Package maintainer has NOT specified a default GNU Bison Skeleton file])
          AC_MSG_WARN([    in this package's configure.ac file.])
          AC_MSG_WARN([  > The Package configurer has NOT specified a GNU Bison Skeleton file, they])
          AC_MSG_WARN([    have only specified --with-bison-skeleton=yes])
          AC_MSG_WARN([])
          AC_MSG_WARN([As a result of this shortcoming in information, the configuration system will be])
          AC_MSG_WARN([unable to tell the build system which GNU Bison Skeleton file it should use.])
          AC_MSG_WARN([])
          AC_MSG_WARN([To rectify this problem, try running the configure script again. This time])
          AC_MSG_WARN([however, consider passing the name of a valid GNU Bison Skeleton file as an])
          AC_MSG_WARN([argument to the --with-bison-skeleton configure script option. That is, invoke])
          AC_MSG_WARN([the --with-bison-skeleton configure script option in a manner which is similar])
          AC_MSG_WARN([to the following;])
          AC_MSG_WARN([])
          AC_MSG_WARN([  --with-bison-skeleton="lalr1.cc"])
          AC_MSG_WARN([])
          AC_MSG_WARN([Due to this problem which has been encountered - and hopefully explained clearly])
          AC_MSG_WARN([above, the configure script is about to exit with a failure.])
          AC_MSG_WARN([================================================================================])
          AC_MSG_FAILURE(["Exiting out of the configure script with a failure!!!"])
        else
          BISON_SKELETON=${BISON_SKELETON_DEFAULT}
        fi
      ],
      [no],
      [
        AC_MSG_FAILURE(["You have to specify a Bison Skeleton file to use!"])
      ],
      [BISON_SKELETON=${with_bison_skeleton}]
    )

    # If execution of the macro has reached this point, then the variable BISON_SKELETON
    # should be set to the name of a GNU Bison Skeleton file.
    #
    # The name of the GNU Bison Skeleton file, may or may not be fully qualified. Check
    # to see if the file actually exists.

    # Case 1 : Assume the value of BISON_SKELETON is fully qualified. 

    BISON_SKELETON_TEMP=${BISON_SKELETON}

    AC_CHECK_FILE(
      [${BISON_SKELETON_TEMP}],
      [
        AC_MSG_NOTICE([Found the GNU Bison Skeleton file : ${BISON_SKELETON_TEMP}])
      ],
      [
        AC_MSG_NOTICE([Could not find the GNU Bison Skeleton file : ${BISON_SKELETON_TEMP}])
      ]
    )

    # Case 2: Assume the value of BISON_SKELETON is not fully qualified.
    #
    # Fully qualify BISON_ROOTDIR.
    #
    # Note that it is assumed the GNU Bison Skeleton file will reside in ...

    BISON_SKELETON_TEMP=${BISON_ROOTDIR}/share/bison/skeletons/${BISON_SKELETON}

    AC_CHECK_FILE(
      [${BISON_SKELETON_TEMP}],
      [
        AC_MSG_NOTICE([Found the GNU Bison Skeleton file : ${BISON_SKELETON_TEMP}])
      ],
      [
        if test "x${BISON_ROOTDIR}" == "x"
        then
        
          # The variable BISON_ROOTDIR has NOT been set. 
        
          AC_MSG_WARN([================================================================================])
          AC_MSG_WARN([The configure script has encountered a problem :])
          AC_MSG_WARN([------------------------------------------------])
          AC_MSG_WARN([])
          AC_MSG_WARN([  > The specified GNU Bison Skeleton file could NOT be found.])
          AC_MSG_WARN([  > The variable BISON_ROOTDIR does not appear to be set. As a result of this,])
          AC_MSG_WARN([    the configure script might night not be able to find some or all of the])
          AC_MSG_WARN([    components of GNU Bison that it requires.]) 
          AC_MSG_WARN([])
          AC_MSG_WARN([As a result of this, the configuration system will be unable to tell the build])
          AC_MSG_WARN([system which GNU Bison Skeleton file it should use.])
          AC_MSG_WARN([])
          AC_MSG_WARN([To rectify this problem, try running the configure script again. This time])
          AC_MSG_WARN([however, consider passing the name of the directory into which the GNU Bison])
          AC_MSG_WARN([package has been installed, as an argument to the --with-bison-rootdir configure])
          AC_MSG_WARN([script option. That is, invoke the --with-bison-rootdir configure script option])
          AC_MSG_WARN([in a manner which is similar to the following;])
          AC_MSG_WARN([])
          AC_MSG_WARN([  --with-bison-rootdir=/home/foo/local/bison-3.8])
          AC_MSG_WARN([])
          AC_MSG_WARN([Due to this problem which has been encountered - and hopefully explained clearly])
          AC_MSG_WARN([above, the configure script is about to exit with a failure.])
          AC_MSG_WARN([================================================================================])
          AC_MSG_FAILURE(["Exiting out of the configure script with a failure!!!"])
        else
        
          # The variable BISON_ROOTDIR has been set, but has it been set to a valid value?
        
          AC_MSG_WARN([================================================================================])
          AC_MSG_WARN([The configure script has encountered a problem :])
          AC_MSG_WARN([------------------------------------------------])
          AC_MSG_WARN([])
          AC_MSG_WARN([  > The specified GNU Bison Skeleton file could NOT be found.])
          AC_MSG_WARN([  > The variable BISON_ROOTDIR appears to be set, but has it been set to a valid])
          AC_MSG_WARN([    value?])
          AC_MSG_WARN([])
          AC_MSG_WARN([As a result of this, the configuration system will be unable to tell the build])
          AC_MSG_WARN([system which GNU Bison Skeleton file it should use.])
          AC_MSG_WARN([])
          AC_MSG_WARN([To rectify this problem, try running the configure script again. This time])
          AC_MSG_WARN([however, consider performing one of the following two actions;])
          AC_MSG_WARN([])
          AC_MSG_WARN([  - passing the fully qualified name of a valid GNU Bison Skeleton])
          AC_MSG_WARN([file as an argument to the --with-bison-skeleton configure script option. That])
          AC_MSG_WARN([is, invoke the --with-bison-skeleton configure script option in a manner which])
          AC_MSG_WARN([is similar to the following;])
          AC_MSG_WARN([])
          AC_MSG_WARN([  --with-bison-skeleton=/home/foo/local/bison-3.8/share/bison/skeletons/lalr1.cc])
          AC_MSG_WARN([])
          AC_MSG_WARN([Due to this problem which has been encountered - and hopefully explained clearly])
          AC_MSG_WARN([above, the configure script is about to exit with a failure.])
          AC_MSG_WARN([================================================================================])
          AC_MSG_FAILURE(["Exiting out of the configure script with a failure!!!"])
        fir
      
        AC_MSG_FAILURE([Could not find the GNU Bison Skeleton file : ${BISON_SKELETON_TEMP}])
      ]
    )

    # Instruct GNU Autoconf to register the variable BISON_SKELETON.
    #
    # This registers the variable and its value, with the configure script. By
    # doing this, it allows the rest of the configure script to see and thus use
    # this variable.

    AC_SUBST(BISON_SKELETON)

    AC_MSG_NOTICE([BISON_SKELETON = ${BISON_SKELETON}])
  ]
)
