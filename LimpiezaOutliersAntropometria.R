setwd("C:/Users/52222/Documents/Itesm/Concentracion26")
df <- read.csv(file="CN_ANTROPOMETRIA_LIMPIO2.csv", header=TRUE, sep=",")
#límites superior e inferior de estatura
summary(df$ESTATURA)

boxplot(df$ESTATURA,horizontal=TRUE,notch=TRUE,main="Estatura datos originales")

media_e <- mean(df$ESTATURA,na.rm=TRUE)
desv_e <- sd(df$ESTATURA,na.rm = TRUE)

lim_inf <- media_e - 2*desv_e
lim_sup <- media_e + 2*desv_e

df2 <- df[df$ESTATURA>=lim_inf & df$ESTATURA<=lim_sup,]
boxplot(df2$ESTATURA,horizontal=TRUE,notch=TRUE,main="Estaturas sin outliers")
hist(df2$CINTURA)
scatter.smooth(df2$CINTURA,df2$IMC,color="magenta",main="Relación cintura  Imc")

#cintura
Q1_c <- quantile(df2$CINTURA,0.25,na.rm=TRUE)
Q3_c <- quantile(df2$CINTURA,0.75,na.rm=TRUE)
IQR <- Q3_c - Q1_c
lim_inf <- Q1_c -1.5*IQR
lim_sup <- Q3_c +1.5*IQR

df3 <- df2[df2$CINTURA >= lim_inf & df2$CINTURA<=lim_sup,]
boxplot(df3$CINTURA,horizontal=TRUE)

table(df2$SEXO)

df_mujeres<- df3[df3$SEXO==2,]
df_hombres<- df3[df3$SEXO==1,]


library(ggplot2)

df_mujeres$SEXO <- "Mujeres"
df_hombres$SEXO <- "Hombres"

df_imc <- rbind(
  df_mujeres[, c("IMC", "SEXO")],
  df_hombres[, c("IMC", "SEXO")]
)

ggplot(df_imc, aes(x = IMC, fill = SEXO)) +
  geom_histogram(
    binwidth = 1,
    alpha = 0.5,
    position = "identity"
  ) +
  labs(
    title = "Distribución del IMC por sexo",
    x = "IMC",
    y = "Frecuencia",
    fill = "SEXO"
  ) +
  theme_minimal()






# estas son otras cosas
summary(df3$CINTURA)#peso
media_p <- mean(df3$PESO,na.rm=TRUE)
desv_p <- sd(df3$PESO,na.rm=TRUE)
lim_inf <- media_p - 3*desv_p
lim_sup <- media_p + 3*desv_p
df4 <- df3[df3$PESO>= lim_inf & df3$PESO <= lim_sup,]
colSums(is.na(df4))
df5 <- df4[!is.na(df4$PESO) & !is.na(df4$ESTATURA),]
colSums(is.na(df5))
df5 <- df5[,-5]
plot(df5$PESO,df5$CINTURA,col="green")
write.csv(df5,"CN_ANTROPOMETRIA_LIMPIO3.csv")

