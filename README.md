shiny-examples
==============

"rfannot" version ... i.e. with rafalcode annotations
note, code will be changed a bit

### 001-hello
Now uses a local sourced version of the old faithful data. Would be good to be able to choose.
Not ethat the readme is rendered and is better seen if
In the end, this is just an exercise how a histogram changes when
you vary the number of buckets, because that is what the interaction allows you to do.
Essentially this allows exploratpory visual gauging of the data.

### 001b
is my riff on 001-hello. I created a www subdirectory in it wiht a file 
called some.js which stands for "(just) some javascript". Note how this javascritp is then 
invoked in the app itself.

### 002-text, no graph here, just a table display of a dataset, plus a selector
to choose 1 of 3 datasets, and a second selector to determine number of rows to show.
"rocks " is the biggest one with 4 variables. If we get rid of code display, perhaps some
possible 8 different variables could be shown here, but prob. no more at this font size.
Does not use fluidRow.

### 003-reactivity almost exactly the same as 002-text,
except allows text input into a box which is then reproduced in the title
without reloading page. Could have some games with that ... like
replacing certain words that are input.

### 004-mpg uses mtcars to show a boxplot
which should not be reviled as the are the simplest to use the tilde
to indicate (or better said, test) dpendence of one vairable (LHS of tilde)
on another (RHS of tilde).

### 005-sliders,
Just shows how to use sliders ... I am not a fan, but Shiny certainly seems to think they are great
and perhaps some decent use cases for them can be found.

### 006-tabsets (aka. tabpanels)
Another showcase for a basic interaction device, tabs that allow subpanel to be selected.
In this way various graphs (pages) are accessible by the user wishing to see more.
Not too many extra mind you. Less than 10 most probs.

### 007-widgets
Only a small thing being shown here -it's the same as 002-text, but there's no auto update
and the user has to update the view to see changes. This could act as some sort of confirmation.

### 008-html
the shiny view can take on a pure HTML view, so that it starts to look like a CGI thing.
I.e. the shiny controls look like the typical CGI controls.

### 009-upload
How to allow user to upload a CSV file. No security concerns here, for the moment. There are
validation exercises further on.

### 010-download
An altogether less hzadous task - simply allows a user to download a table, very similar to write.csv().

### 011-timer:
v. simple, just outputs sys.time() to a H2 header text
it updates every second.

### 012-datatables
uses 3 tab panels for 3 different datasets that allow some customization
i.e. each table allows you to dosmething differnt, 1) only show some of the columns
2) ordering a certain column (you have to click its header) 3) and then varying the amount of rows you can see)
PS. YOu sholuld show total number of rows and columns for these datasets.

### 013-selectize
A bit hard to understand. Even the -ize after select, There must be subtle differences.
the selectize.js library is behind it.

### 014-onflushed
Also not easy to understand, delays in reactivity?

### 015-navbar
So this really looks like a template, with a higher level tabset, but actually
does nothing (unlike previous examples)

### 015-layout-sidebar
(note has the same number as above in original repo)
like 001, just has faithful data in hist() form, except slider is on right.

### 016-knitr-pdf
Use mtcars for a linear model of mpg (with a choice of independent variables)
and generates a quick report with a red line for the regression in the scatter graph.
The report can be Word, HTML or pdf 




### original README.md text:

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
