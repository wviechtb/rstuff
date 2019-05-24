# An 'improved' library() command that, if necessary, first installs a
# package before trying to load it. It can also take multiple package names
# at once (and requires no quotes), that is, your code could start with:
#
# library(pkg1, pkg2, pkg3).
#
# and all packages will be installed (if necessary) and then loaded.
#
# If you put this into your .Rprofile file, library(pkg) will call this
# command instead of base::library(pkg). You can still use base::library(pkg)
# if you want to make use of the 'base' package library() command.
#
# Note that if you share code with others that uses this command, you should
# stick to:
#
# library(pkg1)
# library(pkg2)
# library(pkg3)
# ...
#
# at the beginning of your code so it remains runnable for those who do not
# have this command (of course, they would have to manually install the
# packages first if they are not already installed).

library <- function(...) {
   ### install.packages() gives a warning if it fails; upgrade warnings to errors so try() works as intended
   wopt <- options(warn=2)
   on.exit(options(warn=wopt$warn)) # on exit, set 'warn' back to previous setting
   pkgs <- as.character(substitute(list(...)))[-1L] # -1L to remove 'list'
   apkgs <- .packages()
   cat("\n")
   for (i in seq_along(pkgs)) {
      cat("********************", pkgs[i], "********************\n")
      if (pkgs[i] %in% apkgs) {
         cat("Package is already loaded.\n")
      } else {
         cat("Trying to load package ...\n")
         if (!suppressWarnings(require(pkgs[i], quietly=TRUE, character.only=TRUE))) {
            cat("Package not installed.\n")
            cat("Trying to install it ...\n")
            z <- try(install.packages(pkgs[i]), silent=TRUE)
            if (!inherits(z, "try-error")) {
               cat("Package successfully installed.\n")
               cat("Now trying again to load package ...\n")
               if (suppressWarnings(require(pkgs[i], quietly=TRUE, character.only=TRUE))) {
                  cat("Package successfully loaded.\n")
               } else {
                  cat("Package loading not successful.\n")
               }
            } else {
               cat("Could not install package :( \n")
            }
         } else {
            cat("Package successfully loaded.\n")
         }
      }
      cat("\n")
   }
}
