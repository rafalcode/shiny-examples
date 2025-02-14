shiny-examples
==============

"rfannot" version ... i.e. with rafalcode annotations
note, code will be changed a bit

>>> 001-hello
Now uses a local sourced version of the old faithful data. Would be good to be able to choose.
Not ethat the readme is rendered and is better seen if
In the end, this is just an exercise how a histogram changes when
you vary the number of buckets, because that is what the interaction allows you to do.
Essentially this allows exploratpory visual gauging of the data.



>>> original README.md text:

This is a collection of Shiny examples. You can see them in action on
`http://gallery.shinyapps.io/example-name` where `example-name` is the directory
name of an example here, e.g. http://gallery.shinyapps.io/001-hello

To run the examples locally, you can install the **shiny** package in R, and
use the function `runGitHub()`. For example, to run the example `001-hello`:

```R
if (!require('shiny')) install.packages("shiny")
shiny::runGitHub("shiny-examples", "rstudio", subdir = "001-hello")
```

Or you can clone or download this repository, and use run
`shiny::runApp("001-hello")`.

Note the examples listed below depend on the [development
version](https://github.com/rstudio/shiny) of **shiny** to show some new
features under development. Please be cautious that such features may or may
not end up in the final release, or they may also change according to the
feedback.

* [None]
