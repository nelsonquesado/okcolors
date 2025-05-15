# okcolors <img src="figs/okcolors.logo.png?raw=true" alt="logo" align="right" height="180"/>

###### v0.1.0 {CRAN} release 2025-05-15

###### v0.1.1 {DEV}

[![Lifecycle: experimental](https://lifecycle.r-lib.org/articles/figures/lifecycle-experimental.svg)](https://lifecycle.r-lib.org/articles/stages.html)

[![CRAN/METACRAN Total downloads](https://cranlogs.r-pkg.org/badges/grand-total/okcolors?color=blue)](https://CRAN.R-project.org/package=okcolors) <br/>

`okcolors` is a collection of aesthetically appealing color palettes inspired by OK Go music videos for data visualization with 'ggplot2'. All palettes support both discrete and continuous data.

## Installation

``` r
install.packages("okcolors")
library(okcolors)

# dev version:
install.packages('remotes') # if not already installed
# wait for the installation to complete

remotes::install_github('nelsonquesado/okcolors@main')
library(okcolors)
```

## Usage

The `okcolors` package provides **three** simple functions:

1.  `okcolors()` – returns a `n` number of color hex codes from a named `palette`.
2.  `scale_color_okcolors()` – adds a custom color scale to a `ggplot2` plot.
3.  `scale_fill_okcolors()` – adds a custom fill scale to a `ggplot2` plot.
4.  `valid_palettes()` - lists available palettes in the okcolors Package.

``` r
library(ggplot2)
library(okcolors)

ggplot(mpg, aes(displ, hwy, color = class)) +
  geom_point(size = 3) +
  scale_color_okcolors()  # Just add it like any ggplot scale
```

<img src="figs/example1.ok.png?raw=true" height="450"/>

``` r
library(ggplot2)
library(okcolors)

ggplot(mpg, aes(class, fill = class)) +
  geom_bar() +
  scale_fill_okcolors("skyscrapers")  # Again, just add it like any ggplot scale
```

<img src="figs/example2.ok.png?raw=true" height="450"/>

There are 5 different collor palettes, which are descibed in the next section.

``` r
valid_palettes()

[1] "it" "stone" "skyscrapers" "obsession" "moment" 

```

Although the palettes are made of 5 basic colors, the package interpolates any number of colors to match the palette.

```r
okcolors('obsession', 12)
 [1] "#45924C" "#83A744" "#C1BC3C" "#EFC344" "#ECA07C" "#EA7DB5"
 [7] "#EB66B9" "#EF5C87" "#F35155" "#C4536D" "#845A9E" "#4561CF"
```

## Palettes

### it - Here it goes again

<img src="figs/it.jpeg?raw=true" height="250"/>

<img src="figs/pal.it.jpeg?raw=true" height="250"/>

```r
library(tidyverse); library(okcolors); library(aopdata); library(sf)

read_landuse('fortaleza', geometry = T) %>% 
  group_by(id_hex, geometry) %>% 
  reframe(`Low-income individuals` = P001 * (R003 <= 4) %>% if_else(is.na(.), 0, .),
          `Low-complexity job psitions` = T002) %>% 
  pivot_longer(cols = 3:4) %>% 
  mutate(value = value/sum(value)) %>% 
  st_as_sf() %>% 
  ggplot() +
  geom_sf(aes(fill = value), color = NA) +
  facet_grid(.~name) + 
  scale_fill_okcolors('it',
                      discrete = F,
                      transform = 'log',
                      na.value = okcolors('it', n = 1, direction = 1),
                      breaks = c(.000001, .0001, .005),
                      labels = c('0.0001%', '0.01%', '0.5%'),
                      name = 'Proportion\n',
                      direction = 1) +
  theme_linedraw() +
  labs(title = 'Spatial misatch between low-complexity job positions\nand low-income individuals in Fortaleza, Brazil.') +
  theme(legend.position = 'bottom')
```
<img src="figs/example.it.png?raw=true" height="320"/>

Source: Pereira, Rafael H. M. et al. (2022) _Distribuição espacial de características sociodemográficas e localização de empregos e serviços públicos das vinte maiores cidades do Brasil._ Texto para Discussão 2772. Ipea - Instituto de Pesquisa Econômica Aplicada. http://dx.doi.org/10.38116/td2772

### stone - A stone only rolls downhill

<img src="figs/stone.jpeg?raw=true" height="250"/>

<img src="figs/pal.stone.jpeg?raw=true" height="250"/>

```r
library(tidyverse); library(okcolors)
library(GTFSwizard); library(hrbrthemes)

for_bus_gtfs %>% 
  get_fleet('by.hour') %>% 
  ggplot +
  geom_line(aes(x = hour, y = fleet, color = service_pattern, group = service_pattern), linewidth = 2) +
  scale_color_okcolors('stone',
                       discrete = T,
                       direction = -1,
                       name = 'Service Pattern',
                       labels = c('Business days', 'Sundays', 'Saturdays')) +
  theme_linedraw() +
  scale_y_comma(big.mark = '.') +
  labs(title = 'Bus fleet variation during the day in Fortaleza, Brazil.',
       x = 'Time of the day', y = 'Fleet (veh)') +
  theme(legend.position = 'bottom')
```

<img src="figs/example.stone.png?raw=true" height="320"/>

Source: Quesado Filho, N. de O., Guimarães, C. G. C. (2024). _GTFSwizard: Exploring and Manipulating 'GTFS' Files_. R package version 1.1.0, <https://github.com/OPATP/GTFSwizard>.

### skyscrapers - Skyscrapers

<img src="figs/skyscrapers.jpeg?raw=true" height="250"/>

<img src="figs/pal.skyscrapers.jpeg?raw=true" height="250"/>

```r
library(tidyverse); library(okcolors); library(aopdata); library(hrbrthemes)

read_population('all') %>% 
  mutate(`Proportion of white individuals` = (P002/P001) %>% round(1)) %>% 
  group_by(`Proportion of white individuals`, name_muni) %>% 
  reframe(`Average per capita household income` = mean(R001, na.rm = T)) %>% 
  ggplot +
  geom_line(aes(`Proportion of white individuals`,
                `Average per capita household income`,
                color = `Average per capita household income`)) +
  geom_point(aes(`Proportion of white individuals`,
                 `Average per capita household income`,
                 color = `Average per capita household income`),
             size = 4) +
  facet_wrap(name_muni~.) +
  scale_color_okcolors('skyscrapers', guide = 'none', discrete = F) +
  scale_x_percent(breaks = c(0, 0.2, .4, .6, .8)) +
  scale_y_comma(big.mark = '.', prefix = 'R$ ', breaks = c(1000, 3000, 5000)) +
  labs(title = 'Average income for different racial contexts') +
  theme_linedraw()
```

<img src="figs/example.skyscrapers.png?raw=true" height="400"/>

Source: Pereira, Rafael H. M. et al. (2022) _Distribuição espacial de características sociodemográficas e localização de empregos e serviços públicos das vinte maiores cidades do Brasil._ Texto para Discussão 2772. Ipea - Instituto de Pesquisa Econômica Aplicada. http://dx.doi.org/10.38116/td2772

### obsession - Obsession

<img src="figs/obsession.jpeg?raw=true" height="250"/>

<img src="figs/pal.obsession.jpeg?raw=true" height="250"/>

``` r
library(tidyverse); library(okcolors)

mpg %>% 
  ggplot() +
  geom_boxplot(aes(x = class, y = hwy, fill = class)) +
  labs(title = "Highway MPG by Car Class",
       x = "Car Class",
       y = "Highway MPG") +
  theme_linedraw() +
  theme(legend.position = "none") +
  scale_fill_okcolors()
```

<img src="figs/example.obsession.png?raw=true" height="320"/>

Wickham H, Averick M, Bryan J, Chang W, McGowan LD, François R, Grolemund G, Hayes A, Henry L, Hester J, Kuhn M, Pedersen TL, Miller E, Bache SM, Müller K, Ooms J, Robinson D, Seidel DP, Spinu V, Takahashi K, Vaughan D, Wilke C, Woo K, Yutani H (2019). “Welcome to the tidyverse.” _Journal of Open Source Software_, *4*(43), 1686. doi:10.21105/joss.01686 <https://doi.org/10.21105/joss.01686>.

### moment - The one moment

<img src="figs/moment.jpeg?raw=true" height="250"/>

<img src="figs/pal.moment.jpeg?raw=true" height="250"/>

```r
library(okcolors); library(tidyverse)

diamonds %>% 
  ggplot(aes(x = cut, fill = clarity)) +
  geom_bar(position = "fill") +
  labs(title = "Proportion of Clarity Within Diamond Cuts",
       x = "Cut",
       y = "Proportion",
       fill = "Clarity") +
  theme_linedraw() +
  scale_fill_okcolors('moment', direction = -1)
```

<img src="figs/example.moment.png?raw=true" height="400"/>

H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.

## Contributing

Contributions are welcome! To report a bug, suggest a feature, or contribute code, please use the repository’s [Issues](https://github.com/nelsonquesado/okcolors/issues).

## Related Packages

`okcolors` mainly relies on [ggplot2](https://ggplot2.tidyverse.org/).

## Citation

To cite package ‘okcolors’ in publications use:

-   Quesado Filho, N. O. de, & Silveira, A. F. T. (2025). *okcolors: A Set of Color Palettes Inspired by OK Go Music Videos for 'ggplot2' in R.* R package version 0.1.0. [DOI: 10.32614/CRAN.package.okcolors](https://cran.r-project.org/package=okcolors).

A BibTeX entry for LaTeX users is

``` tex
  @Manual{quesado.silveira.2025,
    title = {okcolors: A Set of Color Palettes Inspired by OK Go Music Videos for ggplot2 in R.},
    author = {Nelson de O. {Quesado Filho} and Ana Flávia T. {Silveira},
    year = {2025},
    note = {R package version 0.1.0},
    url = {https://cran.r-project.org/package=okcolors},
    doi = {10.32614/CRAN.package.okcolors}}
```

## Acknowledgement

**okcolors** is developed by [Nelson Quesado](https://github.com/nelsonquesado/) and [Ana Flávia Teles](https://www.behance.net/anvie).
