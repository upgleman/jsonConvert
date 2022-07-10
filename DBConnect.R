install.packages("DBI")

library("sqldf")
library("DBI")
library("RPostgreSQL")


pgdrv = dbDriver("PostgreSQL")
postgre_PW = "zpdltprfoq1!"
con = dbConnect(
  pgdrv,
  dbname="twin",
  port="3030",
  user="twin",
  password=postgre_PW,
  host="ksec.synology.me"
)

# drv <- dbDriver("PostgreSQL")
# con <- dbConnect(drv, dbname='twin',host='ksec.synology.me',port=3030 ,user='twin',password='zpdltprfoq1!')
# 
# 
# options(sqldf.RPostgreSQL.user = 'name'
#         , sqldf.RPostgreSQL.password = 'pw'
#         , sqldf.RPostgreSQL.dbname = 'dbname'
#         , sqldf.RPostgreSQL.host = 'adress'
#         , sqldf.RPostgreSQL.port = xxxx )
# 
# count.no <- "select count(*)  from pnd_code;"
# count.p<- sqldf(count.no)
# count.p
# 
# install.packages("odbc")
# library("odbc")
# require("RPostgreSQL")
# 
# con<-dbConnect(dbDriver("PostgreSQL"), dbname='twin', host='ksec.synology.me', port=3030, user='twin',password='zpdltprfoq1!')

dbListTables(con)

# help(sqldf)

mst_users = dbGetQuery(con, "SELECT * FROM pnd_code;")
print(mst_users)



drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname='twin',host='ksec.synology.me',port=3030 ,user='twin',password='zpdltprfoq1!')

options(sqldf.RPostgreSQL.user = 'twin'
        , sqldf.RPostgreSQL.password = 'zpdltprfoq1!'
        , sqldf.RPostgreSQL.dbname = 'twin'
        , sqldf.RPostgreSQL.host = 'ksec.synology.me'
        , sqldf.RPostgreSQL.port = 3030 )
query <- "SELECT * FROM pnd_code;"
df <- sqldf(query)

df <- df[,-1]
View(df)
write.csv(df, file = "sql_result.csv")
