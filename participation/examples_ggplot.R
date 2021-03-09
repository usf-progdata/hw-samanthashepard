library(palmerpenguins)
library(ggplot2)
theme_set(theme_classic())

# Bar chart
ggplot(penguins) +
  aes(x = species) +
  geom_bar()

# Candybar chart
ggplot(penguins) +
  aes(y = 1,
      color = species,
      fill = species,
      label = species) +
  stat_count(orientation = "y") +
  guides(y = guide_none(),
         color = guide_none(),
         fill = guide_none()) +
  ylab(NULL) +
  stat_count(geom = "label",
             color = "white")

# Pie chart
ggplot(penguins) +
  aes(x = factor(1),
      fill = species,
      label = species) +
  geom_bar(width = 1) +
  stat_count(geom = "text",
             size = 5,
             color = "white",
             position = position_stack(vjust = .5)
  ) +
  guides(y = guide_none(),
         x = guide_none(),
         fill = guide_none()) +
  xlab(NULL) + 
  ylab(NULL) +
  coord_polar(theta = "y") +
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

# Histogram
ggplot(penguins) +
  aes(x = bill_length_mm) +
  geom_histogram(binwidth = 1)

# Density
ggplot(penguins) +
  aes(x = bill_length_mm) +
  geom_density()

# Dotplot
ggplot(penguins) +
  aes(x = bill_length_mm) +
  geom_dotplot(binwidth = 1,
               dotsize = .5) +
  guides(y = guide_none())

# Scatterplot 1
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm) +
  geom_point()

# Scatterplot 2
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species,
      shape = species) +
  geom_point()


#NOTES:
#Geoms require dif aesthetics
#Get help:
?geom_point
#Scroll down to aesthetics
#bold - required
#others - optional
#GGplot website - helpful examples etc.
#GGplot help pages - most relevant thing you'd want to look at = aesthetics

#CHANGE APPEARANCE - change dots to blue or black
#don't want color to map to specific variable - put directly in geom
#if you want it to map to a variable = put in aesthetics.
# transparent = fill
#Example:
# Scatterplot 2
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species,
      shape = species) +
  geom_point(fill = "blue", color = "blue", alpha = .5)
  scale_fill_viridis_d()
  scale_color_viridis_d()
#color = outline of shape
#fill = inside fill of shape
#just like geom pages, each scale page will describe the arguments: scale_color_discrete()
#viridis = color blind
  ggplot(penguins) +
    aes(x = bill_length_mm,
        y = flipper_length_mm,
        fill = species,
        color = species,
        shape = species) +
    geom_point() +
  scale_fill_viridis_d() +
  scale_color_viridis_d()

#Palette:
#on viridis - color options
#scale color brewer - palette argument
#google search "ggplot color palettes"

  
# Scatterplot 3
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species,
      shape = sex,
      size = body_mass_g) +
  geom_point()

# Scatterplot 4
ggplot(round(alr4::Heights)) +
  aes(x = mheight,
      y = dheight) +
  geom_point()

# Scatterplot 5
ggplot(round(alr4::Heights)) +
  aes(x = mheight,
      y = dheight) +
  geom_jitter()

#jitter plots points, but shifts their position so they're not overlapping each other



#Change title of scale - uppercase S in species:
# Scatterplot 6
ggplot(penguins) +
  aes(x = species,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_point() +
  scale_color_discrete("Species") +
  scale_filler_discrete("Species")
#^^^^wasn't able to get this code to work



# Scatterplot 7
ggplot(penguins) +
  aes(x = species,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_jitter(height = 0,
              width = .4)


#power of ggplot - you can put more than 1 type of plot
#scatterplot 8 - BOXPLOT + POINTS
#it matters the order you put the dif geoms in
#or you can use transparency to prevent a geom from hiding another


# Scatterplot 8
ggplot(penguins) +
  aes(x = species,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_jitter(height = 0,
              width = .4) +
  geom_boxplot(color = "black",
               alpha = .5)


#Brenton's fav display:
# Raincloud plot
ggplot(na.omit(penguins)) +
  aes(y = species,
      x = flipper_length_mm,
      fill = species,
      color = species) +
  geom_jitter(height = .15) +
  geom_boxplot(color = "black",
               alpha = .5,
               width = .1,
               size = .5) +
  ggdist::stat_slab(height = .3,
                    color = "black",
                    size = .2,
                    alpha = .5,
                    position = position_nudge(y = .2))

# Scatterplots for change
df <- data.frame(
  id = 1:30,
  before = rnorm(30),
  after = rnorm(30))
df <- tidyr::pivot_longer(
  df,
  -id,
  names_to = "time",
  values_to = "score")
ggplot(df) +
  aes(x = time,
      y = score,
      group = id) +
  geom_point() +
  geom_line()


# Denisity comparisons
df <- data.frame(
  g = c(rep("a", times = 100),
        rep("b", times = 100),
        rep("c", times = 100),
        rep("d", times = 100),
        rep("e", times = 100)),
  z = c(rnorm(100, mean = 0, sd = 1),
        rnorm(100, mean = 1, sd = 2),
        rnorm(100, mean = 2, sd = 3),
        rnorm(100, mean = 3, sd = 4),
        rnorm(100, mean = 4, sd = 5))
)

ggplot(df) +
  aes(x = z,
      group = g,
      fill = g) +
  geom_density(size = .2,
               alpha = .5)

# Ridge plot

ggplot(df) +
  aes(x = z,
      y = g,
      fill = g) +
  ggridges::geom_density_ridges(
    size = .2,
    alpha = .5,
    scale = 4
  )

# Scatterplot matrix
penguins_focal <- penguins[, c("species",
                               "bill_length_mm",
                               "flipper_length_mm",
                               "sex")]
pairs(penguins_focal)

car::scatterplotMatrix(penguins_focal)

GGally::ggpairs(penguins_focal,
                aes(color = species, alpha = .5),
                lower = list(continuous = "smooth_loess",
                             combo = "facethist",
                             discrete = "facetbar",
                             na = "na")
) + theme_classic()


# Smoother 0a
ggplot(mtcars) +
  aes(x = disp,
      y = mpg) +
  geom_point()

# Smoother 0b
ggplot(mtcars) +
  aes(x = disp,
      y = mpg) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm",
              color = "pink3",
              fill = "pink3")


#Add a regression/best fit line
# Smoother 1 - 1 line.
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_point() +
  geom_smooth(color = "black",
              fill = "black")


# Smoother 1 - lines with individual groups.
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_point() +
  geom_smooth()



# Smoother 2
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_point() +
  geom_smooth(color = "black",
              fill = "black") +
  geom_smooth(method = "lm",
              color = "orange",
              fill = "orange")

# Smoother 3
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_point() +
  geom_smooth()

# Smoother 4
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method = "lm",
              color = "black",
              linetype = "dashed")

# Smoother 5
ggplot(penguins) +
  aes(x = bill_length_mm,
      y = flipper_length_mm,
      fill = species,
      color = species) +
  geom_point() +
  geom_smooth(method = "lm",
              linetype = "dashed") +
  geom_smooth(color = "black",
              fill = "black",
              alpha = .2) +
  geom_smooth(method = "lm",
              color = "orange",
              fill = "orange",
              alpha = .2)



# Full EDA plot

ggplot(penguins) +
  aes(x = flipper_length_mm,
      y = bill_length_mm,
      color = species,
      fill = species,
      shape = species,
      linetype = species) +
  geom_point(alpha = .50) +
  geom_smooth() +
  theme(legend.position = "bottom")

