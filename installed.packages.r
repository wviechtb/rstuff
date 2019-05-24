# The installed.packages() command tells you what packages are currently
# installed on your computer. But by default it provides a lot of additional
# information that I am usually not interested in and therefore creates
# output that is not easily readable. All I want to know is the package name,
# where it is installed (this is useful to distinguish packages that are
# installed in system-wide libraries versus personal ones), the version
# number, and the package 'priority' (roughly, 'base' and 'recommended'
# packages are those that are installed by default when you install R, those
# with priority 'NA' are all other packages that you installed yourself
# afterwards). I have the following in my .Rprofile file, so running .ip()
# just gives me this information (functions/objects that start with a dot are
# not shown when running ls() and so are also not affected if you run
# rm(list=ls()) to clear your workspace).

# .ip() command for checking on installed packages
.ip <- function() installed.packages()[,c("LibPath", "Version", "Priority")]
