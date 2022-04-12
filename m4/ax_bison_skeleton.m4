# -----------------------------------------------------------------------------
# Macro : AX_BISON_SKELETON
# =========================
#
# This macro can be used to tell the GNU Autotools which Skeleton file GNU
# Bison should use.
# -----------------------------------------------------------------------------


AC_DEFUN(

  [AX_BISON_SKELETON],

  [
	AC_ARG_WITH(
	  [bison-skeleton],
	  [
AS_HELP_STRING(
[--with-bison-skeleton=@<:@bison-skeleton@:>@],
[Have the build process either; 1) use the first instance of flex which is found within the user's PATH (ARG=yes), ii) not use an instance of bison at all (ARG=no), or iii) use the instance of bison which resides at a specific loction (ARG=path_to_bison)]
)
	  ],
	  [BISON_SKELETON=${withval}],
	  [BISON_SKELETON=""]
	)
	AS_CASE(
	  [${withval}],
	  [yes], [BISON_SKELETON="lalr1.c",
	  [no],  [BISON_SKELETON="lalr1.c"],
	  [BISON_SKELETON="${withval}"]
	)
	AC_SUBST(BISON_SKELETON)
  ]
)