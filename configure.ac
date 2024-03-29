dnl Required initializer
AC_INIT(mod_auth_token, 1.0)

dnl Automake initialization
AM_INIT_AUTOMAKE

AC_PROG_MKDIR_P

dnl the debug build options adds symbols to compiler output (-g for g++) 
AC_ARG_ENABLE(debug,
[  --enable-debug          turn on debugging and compile time warnings],
[case "${enableval}" in
  yes) debug=true ;;
  no)  debug=false ;;
  *) AC_MSG_ERROR(bad value ${enableval} for --enable-debug) ;;
esac],[debug=false])
AM_CONDITIONAL(DEBUG, test x$debug = xtrue)

dnl Find APXS binary
AC_ARG_WITH(apxs,
	AS_HELP_STRING(
		[--with-apxs[=NAME]],
		[Name or full path of the apxs executable ("apxs" by default)]),
	[APXS="$withval"; test "$withval" = yes && APXS="apxs"]
)

AC_PATH_PROGS([APXS], [apxs2 apxs], [false])

if test "$APXS" = "false"; then
	AC_MSG_ERROR([APXS not found, please use --with-apxs to specify the location of the apxs binary])
fi

AC_SUBST([APXS_LIBEXECDIR], [`$APXS -q LIBEXECDIR`])

dnl Add test for a compiler.
dnl AC_CHECK_COMPILERS
AC_PROG_CC

# needed libs
PKG_CHECK_MODULES(APR, [apr-1 apr-util-1])

CXXFLAGS=""
if test x$debug = xtrue; then
   CXXDEBUGDEFINES="-D_DEBUG"
   APXS_CXX_OPTIONS="-Wc,-g"
else 
   CXXDEBUGDEFINES="-D_NDEBUG"
   APXS_CXX_OPTIONS=""
fi					  
AC_SUBST(CXXDEBUGDEFINES)
AC_SUBST(APXS_CXX_OPTIONS)

dnl Extra params for gcc
if test "$GCC"; then
   if test x$debug = xtrue; then
	  CXXFLAGS="$CXXFLAGS -g"
   else 
	  CXXFLAGS="$CXXFLAGS -O2"
   fi					  
fi
AC_SUBST(CXXFLAGS)

AC_LIBTOOL_DLOPEN
AC_LIBTOOL_WIN32_DLL
AM_PROG_LIBTOOL
AC_SUBST(LIBTOOL_DEPS)
AC_ENABLE_SHARED(yes)
AC_ENABLE_STATIC(yes)

dnl Check for functions
AC_CHECK_FUNCS([memmove])

dnl Checks for programs
AC_PROG_INSTALL

dnl Checks for header files
AC_HEADER_STDC

dnl Checks for library functions
dnl AC_ARG_PROGRAM

dnl Write config.status and the Makefile
AC_OUTPUT(Makefile)
