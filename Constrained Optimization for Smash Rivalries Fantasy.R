library(lpSolve)
Players=c("hbox","plup","leffen","armada","mango","m2k",
          "axe","wizzrobe", "sfat", "wes", "amsa" ,"none","zain", "hugs", "ginger", "2saint") 
Cost=c(250,rep(225,3),rep(200,2),rep(175,3),rep(150,3),rep(125,2),rep(100,2))

#Change this Place vector to meet your projections
#It goes in order of Players and their projected placing
#ie, this says hbox got 1st, plup got 2nd, leffen got 3rd, etc
Place=c(1,2,3,4,5,5,7,7,9,9,9,9,13,13,13,13)

Score=rep(0,16)
df=data.frame(Players,Cost,Place,Score)

for (i in 1:16){
  if (df$Place[i]==1) df$Score[i]=750
  else if (df$Place[i]==2) df$Score[i]=600
  else if (df$Place[i]==3) df$Score[i]=500
  else if (df$Place[i]==4) df$Score[i]=400
  else if (df$Place[i]==5) df$Score[i]=300
  else if (df$Place[i]==7) df$Score[i]=200
  else if (df$Place[i]==9) df$Score[i]=100
}

obj <- df$Score
con <- rbind(rep(1, nrow(df)), df$Cost)
dir <- c("==", "<=")
rhs <- c(8, 1400)

result <- lp("max", obj, con, dir, rhs, all.bin = TRUE)
df[result$solution == 1, ]
