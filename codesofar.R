library(tidyverse)
library(dplyr)
library(plyr)


mlbdata = read.csv("game_log.csv", TRUE)

head(mlbdata,5)

nrow(mlbdata)

### perfect games ---- didnt use it

class(mlbdata$date)
mlbdata$seasonYear = as.character(mlbdata$date)
mlbdata$seasonYear = substring(mlbdata$seasonYear,1,4)

mlbdata$seasonYear = as.numeric(mlbdata$seasonYear)

homePerfectGameData = mlbdata %>%
  filter(v_at_bats == 27,
         v_hits == 0,
         v_left_on_base == 0,
         h_errors == 0,
         v_walks == 0) %>% 
  select(seasonYear)
homePerfectGameData


awayPerfectGameData = mlbdata %>% 
  filter(h_at_bats == 27,
         h_hits == 0,
         h_left_on_base == 0,
         v_errors == 0,
         h_walks == 0) %>% 
  select(seasonYear)
awayPerfectGameData

# mlbdata %>% group_by(seasonYear) %>% filter(seasonYear > 1970) %>% 
  # count()

#### no hitters

homeNoHitter = mlbdata %>% 
  filter(v_hits == 0,
         v_rbi == 0) %>% 
  select(seasonYear) %>% 
  group_by(seasonYear) %>% 
  mutate(count=n()) %>% 
  distinct(seasonYear,count) %>% 
  rename(NoHitters = count)
homeNoHitter
homeNoHitter$seasonYear

awayNoHitter = mlbdata %>% 
  filter(h_hits == 0,
         h_rbi == 0) %>% 
  select(seasonYear) %>% 
  group_by(seasonYear) %>% 
  mutate(count=n()) %>% 
  distinct(seasonYear, count) %>% 
  rename(NoHitters = count)
awayNoHitter

awayNoHitter$seasonYear = as.numeric(awayNoHitter$seasonYear)
homeNoHitter$seasonYear = as.numeric(homeNoHitter$seasonYear)

noHitters = rbind(awayNoHitter,homeNoHitter)

noHitters = ddply(noHitters,"seasonYear",numcolwise(sum))
noHitters
######
write.csv(noHitters, file = "noHitters.csv")
######



##### strikeouts by year

strikeoutsHomePitchers = mlbdata %>% group_by(seasonYear) %>% 
  summarise(avgKsperGameBySeason = mean(v_strikeouts))

strikeoutsHomePitchers$avgKsperGameBySeason
  
ksvec1 = c(strikeoutsHomePitchers$avgKsperGameBySeason)
ksvec1
ksvec2 = ksvec1[!is.na(ksvec1)]
ksvec2
class(ksvec1)
sd(ksvec1)

strikeoutsAwayPitchers = mlbdata %>% group_by(seasonYear) %>% 
  summarise(avgKsperGameBySeason = mean(h_strikeouts))

strikeoutsAwayPitchers$avgKsperGameBySeason
ksvec3 = c(strikeoutsAwayPitchers$avgKsperGameBySeason)
ksvec4 = ksvec3[!is.na(ksvec3)]

ksvec5 = (ksvec2 + ksvec4)/ 2
ksvec5
## missing 1914, 1937, 1954
vecforKs = c(1910:1913,1915:1936,1938:1953,1955:1969,1980:1989,2000:2016)
vecforKs
yearstitle = "year"
avgkstitle = "KsPerGame"

avgKsDF = data.frame(vecforKs,ksvec5)
names(avgKsDF) = c(yearstitle,avgkstitle)
######
avgKsDF
write.csv(avgKsDF, file = "avgKsDF.csv")
##### 



#### winning pitchers index
mlbdata$winning_pitcher_name = as.character(mlbdata$winning_pitcher_name)


pitchers = mlbdata %>% mutate(wins = c(1,nrow(mlbdata$winning_pitcher_name),each =1)) %>% select(winning_pitcher_name,wins)
pitchers[1:5,]

pitcherWins = ddply(pitchers,"winning_pitcher_name",numcolwise(sum))
class(pitcherWins)
pitcherWins = pitcherWins[-1,]
pitcherWins

#####
write.csv(pitcherWins, file = "pitcherWins.csv")
#####


##### second pitchers index
pitchers = mlbdata %>% mutate(wins = c(1,nrow(mlbdata$winning_pitcher_name),each =1)) %>% select(winning_pitcher_name,wins,seasonYear)
pitchers %>% group_by(.,seasonYear,winning_pitcher_name)

counts <- ddply(pitchers, .(pitchers$winning_pitcher_name, pitchers$seasonYear), nrow)
N <- 75
seasonWins = counts[-(1:75),]

#####
write.csv(seasonWins, file = "seasonWins.csv")
#####


###### home run per rbi -- teams and years

vhomerun = mlbdata %>% select(.,v_score,v_homeruns, v_name, seasonYear)

vhomerun1 = ddply(vhomerun, .(v_name,seasonYear),numcolwise(sum))
vhomerun1

hhomerun = mlbdata %>% select(., h_score,h_homeruns, h_name, seasonYear)

hhomerun1 = ddply(hhomerun, .(h_name,seasonYear), numcolwise(sum))
hhomerun1 = hhomerun1 %>% dplyr::rename(v_name = h_name)

scores = hhomerun1$v_score + vhomerun1$v_score
homeruns = hhomerun1$v_homeruns + vhomerun1$v_homeruns
homerunsRbis <- subset(homerunsRbis, select = -c(v_score, v_homeruns))

battingdata = cbind(homerunsRbis,scores,homeruns)
battingdata = battingdata %>% mutate(ratio = (homeruns)/(scores))

battingdata2 = subset(battingdata, select = -c(scores,homeruns,v_name))

ratioByYear = ddply(battingdata2,"seasonYear",numcolwise(mean))

leagueName = as.character(rep("MLB",nrow(ratioByYear)))
ratioByYear$v_name = leagueName

battingdata3 = subset(battingdata, select = -c(scores,homeruns))

finalbatting = rbind(battingdata3, ratioByYear)

###### 
write.csv(finalbatting, file = "finalbatting.csv")
######

