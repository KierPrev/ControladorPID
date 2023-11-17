setwd("/home/ale/Escritorio/")
data <- read.csv("Final", header = F, sep = "", dec = ",")

colnames(data) <- c("Base","Resis","t","e","P","I","D", "TR", "dT")

data$t <- (data$t - data$t[1]) / 1000 / 60


#### Plot viejo, sucio y confiable ##############
plot(data$t, data$Resis, cex = 0.6, pch = 18, ylim = c(35,55),
     lwd = 0.5)
points(data$t, data$Base, col = "salmon", cex = 0.6, pch = 18)
abline(h=47, col = "darkcyan", lwd = 2)
abline(h=45, col ="darkgreen", lwd =2)

# Veamos el dT
plot(data$t/60, data$dT, col = "red", cex = 0.7, pch = 18, type  ="o", lwd = 0.5, xlab = "Tiempo(min)", ylab = "Delta Temperatura(?C)", main = "Diferencia de temperaturas entre la base y las resistencias")
abline(h=6.15, col = "darkcyan", lwd = 2)
legend(40, 9, c("6.15 ?C"), fill = c("darkcyan"))

# Error respecto al tset original (45)
plot(data$t, data$e,
     cex = 0.7, pch = 19)

# Vemos P I D actuando unas con las otras para el tiempo de retardo
plot(data$t, data$I, ylim = c(-85000, 290000),cex = 0.4, pch = 19, col = "darkcyan", type = "o", lwd = 0.2)
points(data$t, data$D,
       cex = 0.4, pch = 19, col = "darkolivegreen3", type = "o", lwd = 0.3)
points(data$t, data$P,
       cex = 0.4, pch = 19, col = "red2", type = "o", lwd = 0.2)


## Grafico plotly
library(plotly)
base <- as.vector(t(data[1]))
resis <-  as.vector(t(data[2]))
tiempo <- as.vector(t(data[3]))
datos <- data.frame(tiempo, base, resis)

#### Dos temperaturas ##########################
plot_ly(type = 'scatter', mode = 'markers') %>%
  
  # Datos sensor resistencia
  add_trace(x = ~tiempo, y = ~resis, name = '<b>Resist.</b>',
                                  # El ultimo rgba es la opacidad
            marker = list(color = 'rgba(255,0,0,0.25', size = 9)) %>%
  # Datos sensor base
  add_trace(x = ~tiempo,y = ~base, name = '<b>Base</b>',
            marker = list(color = 'rgba(0,0,255,.25)', size = 9)) %>%
  
  # Linea tset                    Un poco mas grande que los datos en Y
  add_segments(x = 40, xend = 40, y = min(base)-2, yend = max(resis) + 2,
               line = list(color = 'rgba(10,10,10,.4)'), name = "<b>Estabilización</b>") %>%
  # Linea estabilizacion
  add_segments(x = min(tiempo), xend = max(tiempo)+2,
               y = 47.06, yend = 47.06,
               line = list(color = 'rgba(255,150,0,1)'),
               name = "<b>T-Set</b>") %>%
  
  hide_colorbar() %>%    # Nos saca la barrita de color tan bonita (?)
  
  # Aca definimos el formato general del grafico
  layout(autosize = T, # Autoajusta el tamaño, sino usar width y height
         title = "<b>Dinámica térmica del recipiente bajo controlador PID</b>",
         xaxis = list(title = "<b>Tiempo (min)</b>"),
         yaxis = list(title = "<b>Temperatura (ºC)</b>"),
         font = list(size = 12), # Si le damos mucha rosca, hay que agrandar los margenes
         margin = list(t = 40, l = 100)) # Margenes por si le damos mucha rosca al tamaño de letra



#### Diferencia térmica dos sensores ########################
ediffT <- resis - base
                                  
        #Aparte de scatter hay histogram, bars, box  #Paleta   #Tamaño depende de variable
plot_ly(type = 'scatter', mode = 'markers', colors = 'YlOrRd', size = ~-tiempo) %>%
  
  add_trace(x = ~tiempo, y = ~diffT, name = '<b>Dif. temperaturas</b>',
            #Color depende del valor de variable. Wooooosh (?)
            color = ~diffT) %>%
  # Media
  add_segments(x = min(tiempo), xend = max(tiempo)+2, y = 6.15, yend = 6.15,
             line = list(color = 'rgba(200,225,0,.9)'), name = "<b>Media: 6.15</b>") %>%
  hide_colorbar() %>%
  layout(autosize = F, width = 1000, height = 690,
         title = "<b>Diferencia de temperaturas entre la base y las resistencias</b>",
         xaxis = list(title = "<b>Tiempo (min)</b>"),
         yaxis = list(title = "<b>Temperatura (ºC)</b>"),
         font = list(size = 18),
         margin = list(t = 40, l = 100))
  ### Si llego hasta aca, no lea esto, o debera reenviarlo a todos sus contactos (?)










#### ggplot ####
library("ggplot2")
data2 <- data[1:3]
   

#gr?fico
  ggplot(data2)+
  geom_point(data=data2, aes(x=data2$t/60, y=data2$Resis), size=1, shape=20, col = "blue") +
  # red plot
  geom_point(data=data2, aes(x=data2$t/60, y=data2$Base), size=1, shape=20, col = "red") +
  xlab("Tiempo (min)")+
  ylab("Temperatura (ºC)")+
  ggtitle("Dinámica térmica del recipiente bajo controlador PID")+
    theme(
      legend.position = c(.5,.5),
      legend.background = element_blank(),
      legend.title = element_blank(),
      legend.box = "vertical",
      legend.direction = "vertical",
      legend.key.height = unit(0.1,"snpc"),
      legend.key.width  = unit(0.1,"snpc"),
      legend.text = element_text(size = 10),
      axis.title.y = element_text(size = 11, vjust = 0.01),
      axis.title.x = element_text(size = 11, vjust = 1),
      plot.title = element_text(size=15, face="bold.italic", hjust = 0.5),    
      axis.text.x = element_text(size = 9, colour = "black", angle = -60, hjust = 0, vjust = 1),
      axis.text.y = element_text(size = 9, colour = "black"),
      axis.ticks = element_line(size = 1, colour = "black"),
      panel.border = element_rect(size = 1, fill = NA)
    )  +
    geom_hline(yintercept=45, 
               color = "grey", size=0.6)+
    geom_hline(yintercept=47, 
               color = "darksalmon", size=0.8)+
    geom_vline(xintercept=2540/60, 
               color = "black", size=0.8, linetype = "dotted")+
    xlim(0, 60) 
  
  
  
  ggplot(data2)+
       # red plot
    geom_point(data=data2, aes(x=data2$t/60, y=data2$Base), size=1, shape=20, col = "red") +
    xlab("Tiempo (min)")+
    ylab("Temperatura (ºC)")+
    ggtitle("Dinámica térmica del recipiente bajo controlador PID")+
    theme(
      legend.position = c(.5,.5),
      legend.background = element_blank(),
      legend.title = element_blank(),
      legend.box = "vertical",
      legend.direction = "vertical",
      legend.key.height = unit(0.1,"snpc"),
      legend.key.width  = unit(0.1,"snpc"),
      legend.text = element_text(size = 10),
      axis.title.y = element_text(size = 11, vjust = 0.01),
      axis.title.x = element_text(size = 11, vjust = 1),
      plot.title = element_text(size=15, face="bold.italic", hjust = 0.5),    
      axis.text.x = element_text(size = 9, colour = "black", angle = -60, hjust = 0, vjust = 1),
      axis.text.y = element_text(size = 9, colour = "black"),
      axis.ticks = element_line(size = 1, colour = "black"),
      panel.border = element_rect(size = 1, fill = NA)
    )  +
    
    geom_hline(yintercept=47, 
               color = "darksalmon", size=0.8)+
    geom_vline(xintercept=2540/60, 
               color = "black", size=0.8, linetype = "dotted")+
    xlim(0, 60) + ylim(35,50)
    

  
  
  