install.packages("DBI")
install.packages("reshape")
library("sqldf")
library("DBI")
library("RPostgreSQL")
library("reshape")

# pgdrv = dbDriver("PostgreSQL")
# postgre_PW = "zpdltprfoq1!"
# con = dbConnect(
#   pgdrv,
#   dbname="twin",
#   port="3030",
#   user="twin",
#   password=postgre_PW,
#   host="ksec.synology.me"
# )



# help(sqldf)

# mst_users = dbGetQuery(con, "SELECT * FROM pnd_code;")
# dbListTables(con)



drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname='twin',host='ksec.synology.me',port=3030 ,user='twin',password='zpdltprfoq1!')

options(sqldf.RPostgreSQL.user = 'twin'
        , sqldf.RPostgreSQL.password = 'zpdltprfoq1!'
        , sqldf.RPostgreSQL.dbname = 'twin'
        , sqldf.RPostgreSQL.host = 'ksec.synology.me'
        , sqldf.RPostgreSQL.port = 3030 )
query <- "SELECT * FROM pnd_code;"
df <- sqldf(query)
str(df)
# View(df)
write.csv(df, file = "sql_result.csv", fileEncoding = "UTF-8")

sql_df <- read.csv("sql_result.csv", header = TRUE, stringsAsFactors = FALSE, fileEncoding = "UTF-8")
sql_sub <- subset(sql_df, select = -c(X))
View(sql_sub)
