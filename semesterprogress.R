############################################################################
# A script to create tweets for a progress bar bot.
# Created by Dominic Schmitz, @dmncschmtz, www.dominicschmitz.com
# 
# This is the R version of the original scripts created by:
# Simon Meier-Vieracker, @fussballinguist, www.fussballlinguistik.de
# 
# Find the original Python and Perl implementations here: 
# https://github.com/fussballlinguist/semester_progress
############################################################################

# load packages; install if required
if(!require(lubridate)){install.packages("lubridate")}
if(!require(glue)){install.packages("glue")}
if(!require(hms)){install.packages("hms")}

# enter the start and end date and time in YMD HMS format
begin <- lubridate::ymd_hms("2022-04-01 08:30:00")
end <- lubridate::ymd_hms("2022-07-15 20:00:00")

## which type of message do you prefer?
# a = the original  '% des Semesters sind rum.'
# b = the new       '% der Vorlesungszeit sind rum.'
## below, either enter a or b as value (b is the default and already specified)
type <- "b"

# Change the name of the tsv-output-file to your liking
name <- "progress"

##############################
# No changes below this line!
# Select & run all to proceed
##############################

interjections <- c("\\o/","Mein lieber Herr Gesangsverein!","Oh Mann","Alter Schwede!","Heidewitzka!","Holla die Waldfee!","WTF!","Ach du gr�ne Neune!","Sapperlot!","Ich glaub, mein Schwein pfeift!","Heiliger Bimbam!","Prost Mahlzeit!","Da brat mir einer n Storch!","Ach du meine Nase!","H�r mir auf!","Mannometer!","Ist es zu glauben?","Oh my freaking goodness!","Lecko mio!","Alter!","Gopferdeggl!","Grundg�tiger!","Krass!","Juhuu!","Echt jetzt?","Tschakka!","Derbst, Alter!","Gimme five!","Da legst di nieda!","Eieiei!","Heiliger Strohsack!","Dat jibbet doch gar nich!","Ach du gr�ne Neune!","Schon geh�rt?","Unglaublich!","Ach du dickes Ei!","Ach du liebes bisschen!","Ach, du Schreck!","Da schau her!","Ist nicht wahr!","Oh Gottogott!","Schockschwerenot!","Schreck lass nach!","Guck an!","Teufel auch!","Wahnsinn!","Oje, ojemine!","Ich werd verr�ckt!","Da wird doch der Hund in der Pfanne verr�ckt!","Allm�chd!","Oha!","Ich glaub mich laust der Affe!","Ich glaub, mich knutscht ein Elch!","Zum Donnerkeil!","Ich glaub, mein Hamster bohnert!","Meine G�te!","Alter Falter!","Menschenskinder!","Ach du liebes Lieschen!","Ach du liebe Zeit!","Donnerlittchen!","Jesses, Maria und Joseph!","Heiliger Bimbam!","Heidewitzka!","Ich krieg die Motten!","Ich glaub, mich tritt ein Pferd!","Potz Blitz!")

x <- lubridate::interval(begin,end)
y <- x %/% lubridate::seconds(1)

sec_per_int <- y / 100

df <- data.frame()

empty <- "\U2591"
full <- "\U2593"

if(type != "a" & type != "b"){
  stop("Please specify 'type' as either 'a' or 'b'.")
}

for(i in 1:100){
  
  p <- round(i / (100 / 15))
  diff <- 15 - p
  
  dt <- begin + lubridate::seconds(sec_per_int * i)
  
  int <- sample(interjections, 1)
  
  fulls <- glue::glue_collapse(c(rep(full, p)))
  empties <- glue::glue_collapse(c(rep(empty, diff)))
  
  int_dt <- c(paste(fulls, empties, sep = ""))
  
  if(type == "a"){
    perc <- paste(i, "% des Semesters sind rum.", sep = "")
  }else if(type == "b"){
    perc <- paste(i, "% der Vorlesungszeit sind rum.", sep = "")
  }else{
    stop("Please specify 'type' as either 'a' or 'b'.")
  }
  
  msg <- paste(int, "\\n", int_dt, "\\n", perc, sep = "")
  
  df[i,1] <- lubridate::date(dt)
  df[i,2] <- hms::as_hms(dt)
  df[i,3] <- msg
  
}

Encoding(df[1:100,3]) <- "UTF-8"

write_utf8_csv <- function(df, file) {
  data <- apply(df, 1, function(x) {paste(x, sep = "", collapse = "\t")})
  writeLines(data, file , useBytes = TRUE)
}

filename <- paste(name, ".tsv", sep = "")

write_utf8_csv(df, filename)