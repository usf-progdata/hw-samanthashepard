hw01\_exercise2
================
Sam Shepard
1/25/2021

## R Markdown

**View first few rows of dataset:**

``` r
head(penguins)
```

    ## # A tibble: 6 x 8
    ##   species island bill_length_mm bill_depth_mm flipper_length_~ body_mass_g sex  
    ##   <fct>   <fct>           <dbl>         <dbl>            <int>       <int> <fct>
    ## 1 Adelie  Torge~           39.1          18.7              181        3750 male 
    ## 2 Adelie  Torge~           39.5          17.4              186        3800 fema~
    ## 3 Adelie  Torge~           40.3          18                195        3250 fema~
    ## 4 Adelie  Torge~           NA            NA                 NA          NA <NA> 
    ## 5 Adelie  Torge~           36.7          19.3              193        3450 fema~
    ## 6 Adelie  Torge~           39.3          20.6              190        3650 male 
    ## # ... with 1 more variable: year <int>

**Number of rows in dataset:**

``` r
nrow(penguins)
```

    ## [1] 344

**Frequencies of penguin species:**

``` r
library(summarytools)
```

    ## Registered S3 method overwritten by 'pryr':
    ##   method      from
    ##   print.bytes Rcpp

    ## For best results, restart R session and update pander using devtools:: or remotes::install_github('rapporter/pander')

    ## 
    ## Attaching package: 'summarytools'

    ## The following objects are masked from 'package:descr':
    ## 
    ##     descr, freq

``` r
freq(penguins$species, report.nas = FALSE, totals = FALSE, 
     cumul = FALSE, headings = FALSE)
```

    ## 
    ##                   Freq       %
    ## --------------- ------ -------
    ##          Adelie    152   44.19
    ##       Chinstrap     68   19.77
    ##          Gentoo    124   36.05

**Descriptive statistics of numerical variables in dataset:**

``` r
descr(penguins[ , 3:6])
```

    ## Descriptive Statistics  
    ## penguins  
    ## N: 344  
    ## 
    ##                     bill_depth_mm   bill_length_mm   body_mass_g   flipper_length_mm
    ## ----------------- --------------- ---------------- ------------- -------------------
    ##              Mean           17.15            43.92       4201.75              200.92
    ##           Std.Dev            1.97             5.46        801.95               14.06
    ##               Min           13.10            32.10       2700.00              172.00
    ##                Q1           15.60            39.20       3550.00              190.00
    ##            Median           17.30            44.45       4050.00              197.00
    ##                Q3           18.70            48.50       4750.00              213.00
    ##               Max           21.50            59.60       6300.00              231.00
    ##               MAD            2.22             7.04        889.56               16.31
    ##               IQR            3.10             9.27       1200.00               23.00
    ##                CV            0.12             0.12          0.19                0.07
    ##          Skewness           -0.14             0.05          0.47                0.34
    ##       SE.Skewness            0.13             0.13          0.13                0.13
    ##          Kurtosis           -0.92            -0.89         -0.74               -1.00
    ##           N.Valid          342.00           342.00        342.00              342.00
    ##         Pct.Valid           99.42            99.42         99.42               99.42
