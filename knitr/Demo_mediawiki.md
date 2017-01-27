= 1 Introduction =

We can type the introduction to our report here.

= 2 Some calculations =

<pre class="r">x&lt;-4
x</pre>
<pre>## [1] 4</pre>
<pre class="r">x*2</pre>
<pre>## [1] 8</pre>
What if we just want to print the output of the R code, but not the code itself?

<pre>## [1] 16</pre>
Or perhaps we want to give some code but don't want to include the output - perhaps it is lengthy or we want students to fill in the answer.

<pre class="r">x+20</pre>
= 3 Some Plots =

Lets make a plot

<pre class="r">year&lt;-seq(1990,2015)
value&lt;-rnorm(26)
plot(year,value)</pre>
[[File:figure/unnamed-chunk-4-1.png|frame|none|alt=|caption plot of chunk unnamed-chunk-4]]

= 4 Conclusion =

Using a few relatively simple commands, we can combine text and R code and generate a report.

