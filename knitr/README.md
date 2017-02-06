You can run rstudio if you log in to spectre2 with [No Machine](http://www2.le.ac.uk/offices/itservices/ithelp/services/hpc/spectre/access/nx5)
or within command line R on alice/spectre you can use the rmarkdown package which knits and then calls [pandoc](http://pandoc.org/) to convert to html or pdf, you need to add the path for pandoc first so do:

```bash
spectre12> export PATH=${PATH}:/cm/shared/apps/R/deps/rstudio/bin/pandoc
spectre12> R
```
```r
> install.packages(“rmarkdown”)
> library(rmarkdown)
> render(“mymarkdown.Rmd”)
```
which by default creates “mymarkdown.html”, for pdf or word output do:
```r
> render(“mymarkdown.Rmd”, “pdf_document”)
> render(“mymarkdown.Rmd”, “word_document”)
```
You can specify what output format you want in the header of your rmarkdown (see [Demo.Rmd](https://raw.githubusercontent.com/legenepi/examples/master/knitr/Demo.Rmd)).
