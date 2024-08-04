# Install and load necessary packages
install.packages("ggplot2")
install.packages("grid")
install.packages("showtext")
library(ggplot2)
library(grid)
library(showtext)

# Load a modern font
font_add_google("Orbitron", "orbitron")
showtext_auto()

# Remove margins completely
base_layer <- ggplot() +
  annotate("rect", xmin = -1, xmax = 1, ymin = -1, ymax = 1, fill = "transparent", color = NA) +
  theme_void() +
  theme(
    plot.margin = margin(0, 0, 0, 0, "cm")
  )

# Add circular gradient
draw_gradient_circle <- function() {
  grid.circle(x = 0.5, y = 0.5, r = 0.45, gp = gpar(fill = "#0d47a1", col = "#0d47a1"))  # Dark Blue
  grid.circle(x = 0.5, y = 0.5, r = 0.42, gp = gpar(fill = "#1976d2", col = "#1976d2"))  # Medium Blue
  grid.circle(x = 0.5, y = 0.5, r = 0.40, gp = gpar(fill = "#42a5f5", col = "#42a5f5"))  # Light Blue
}

# Add central graphic elements: interconnected nodes and lines
interconnected_nodes <- function() {
  nodes <- data.frame(
    x = c(0.3, 0.7, 0.5, 0.4, 0.6, 0.35, 0.65, 0.45, 0.55),
    y = c(0.5, 0.5, 0.4, 0.35, 0.35, 0.45, 0.45, 0.3, 0.3)
  )
  
  for(i in 1:nrow(nodes)) {
    grid.circle(x = nodes$x[i], y = nodes$y[i], r = 0.02, gp = gpar(fill = "#ffffff"))  # White
  }
  
  connections <- rbind(
    c(1, 3), c(2, 3), c(3, 4), c(3, 5), c(1, 6), c(2, 7),
    c(6, 8), c(7, 9), c(4, 8), c(5, 9), c(6, 9), c(7, 8)
  )
  
  for(i in 1:nrow(connections)) {
    grid.lines(x = nodes$x[connections[i,]], y = nodes$y[connections[i,]], gp = gpar(col = "#ffffff", lwd = 1.5))  # White
  }
}

# Add text in a modern font with a 3D effect
add_text <- function() {
  grid.text("QuantLab", x = 0.5, y = 0.65, gp = gpar(fontsize = 36, col = "#0d47a1", fontface = "bold", fontfamily = "orbitron"))  # Dark Blue
  grid.text("QuantLab", x = 0.502, y = 0.658, gp = gpar(fontsize = 36, col = "#ffffff", fontface = "bold", fontfamily = "orbitron"))  # White
}

# Create a custom function to draw the emblem
draw_emblem <- function() {
  grid.newpage()
  pushViewport(viewport(width = unit(1, "npc"), height = unit(1, "npc"), just = "center"))
  draw_gradient_circle()
  interconnected_nodes()
  add_text()
  popViewport()
}

# Draw the emblem
draw_emblem()
