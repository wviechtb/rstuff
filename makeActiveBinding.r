# If you look at help(makeActiveBinding), you will read that:
#
# "makeActiveBinding installs 'fun' in environment 'env' so that getting the
# value of 'sym' calls 'fun' with no arguments, and assigning to 'sym' calls
# 'fun' with one argument, the value to be assigned."
#
# Riiight, that's perfectly clear. Okay, so what can you do with this? Things
# like what I show below. For example, you can create commands that require
# no opening and closing parentheses. The stuff below is in my .Rprofile
# file, so it is always available when I run R.

# cls for clear screen
#
# Simply use as:
#
# cls
#
# and it will clear your screen. This makes use of escape sequences
# (https://en.wikipedia.org/wiki/ANSI_escape_code), which may not be
# supported on your platform.

makeActiveBinding("cls", function() cat(c("\033[2J","\033[0;0H")), env=.GlobalEnv)

# . for last value
#
# Simply use as:
#
# .
#
# and it will give you the "value of the internal evaluation of a top-level R
# expression" (see ?.Last.value). This is nothing different than just calling
# .Last.value, but much shorter. Useful if you forgot to assign a result to
# an object. For example:
#
# mean(rnorm(1000))
# .

makeActiveBinding(".", function() .Last.value, env=.GlobalEnv)
