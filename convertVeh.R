install.packages("reshape")
library(reshape)
library('jsonlite')


veh <- read.table("20220106_000000000001_raw_VEHICLE_refine.csv", sep=",", head = TRUE, fileEncoding = "UTF-8", encoding = "CP949")

# View(veh)

# rm(veh)

#OrderID 12자리 처리
veh <- transform(veh,
                 VEHICLE_ID_S= sprintf("%010d",VEHICLE_ID),
                 CURRENT_ORDER_ID_S= sprintf("%012d",CURRENT_ORDER_ID)
                 )
# 변수 자릿수 고정
veh$VEHICLE_ID<- veh$VEHICLE_ID_S
veh$CURRENT_ORDER_ID<- ifelse(is.na(veh$CURRENT_ORDER_ID) == TRUE, NA ,veh$CURRENT_ORDER_ID_S)

#문자형 변환
veh$VEHICLE_OPTION <- as.character(veh$VEHICLE_OPTION)
veh$VEHICLE_TYPE <- as.character(veh$VEHICLE_TYPE)


#일자 변수 전처리
veh$E_WORKING_DATE <- as.character(veh$E_WORKING_DATE)
veh$S_WORKING_DATE <- as.character(veh$S_WORKING_DATE)

#좌표
veh$CURRENT_DES_X <- as.character(veh$CURRENT_DES_X)
veh$CURRENT_DES_Y <- as.character(veh$CURRENT_DES_Y)
veh$CURRENT_LOC_X <- as.character(veh$CURRENT_LOC_X)
veh$CURRENT_LOC_Y <- as.character(veh$CURRENT_LOC_Y)
veh$GARAGE_X  <- as.character(veh$GARAGE_X)
veh$GARAGE_Y  <- as.character(veh$GARAGE_Y)  

#시간변수 전처리
veh$S_WORKING_TIME <- as.character(veh$S_WORKING_TIME)
veh$E_WORKING_TIME <- as.character(veh$E_WORKING_TIME)

#디폴트값처리
veh$E_WORKING_DATE <- ifelse(veh$E_WORKING_DATE %in% c("0"), NA, veh$E_WORKING_DATE)
veh$S_WORKING_DATE <- ifelse(veh$S_WORKING_DATE %in% c("0"), NA, veh$S_WORKING_DATE)

veh$S_WORKING_TIME <- ifelse(veh$S_WORKING_TIME %in% c("0", "0:0"), NA, veh$S_WORKING_TIME)
veh$E_WORKING_TIME <- ifelse(veh$E_WORKING_TIME %in% c("0", "0:0"), NA, veh$E_WORKING_TIME)

# table(is.na(veh$CURRENT_ORDER_ID))

# veh$CURRENT_ORDER_ID <- ifelse(is.na(veh$CURRENT_ORDER_ID) == TRUE , " ", veh$CURRENT_ORDER_ID)



# 컬럼 제외
veh_sub <- subset(veh, select = -c(VEHICLE_ID_S,CUSTOMER_CD,GROUP_CD,CURRENT_ORDER_ID_S))

# View(veh_sub)



veh_rename <- rename( veh_sub,
            c("VEHICLE_ID"="vehicleId",
              "CAR_NUM"="carNum",
              "SHIPPER_CD"="shipperCd",
              "STATUS"="status",
              "VEHICLE_CLASS"="vehicleClass",
              "VEHICLE_SCALE"="vehicleScale",
              "VEHICLE_OPTION"="vehicleOption",
              "VEHICLE_TYPE"="vehicleType",
              "VOLUME_CAPA"="volCapa",
              "WEIGHT_CAPA"="wtCapa",
              "BOX_CAPA"="boxCapa",
              "COST_CAPA"="costCapa",
              "VISIT_NODE_CAPA"="visitNodeCapa",
              "DISTANCE_CAPA"="distanceCapa",
              "TIME_CAPA"="timeCapa",
              "HEIGHT"="height",
              "VOLUME_RATE"="volRate",
              "WEIGHT_RATE"="wtRate" ,
              "BOX_RATE"="boxRate" ,
              "COST_RATE" ="costRate",
              "VISIT_NODE_RATE" ="visitNodeRate",
              "DISTANCE_RATE" ="distanceRate",
              "TIME_RATE" ="timeRate",
              "CURRENT_ORDER_ID"="curOrderID",
              "CURRENT_LOC_X"="curLocX",
              "CURRENT_LOC_Y"="curLocY",
              "CURRENT_DES_X"="curDesX",
              "CURRENT_DES_Y"="curDesY",
              "GARAGE_X"="garageX",
              "GARAGE_Y"="garageY",
              "S_WORKING_TIME"="sWorkingTime",
              "E_WORKING_TIME"="eWorkingTime",
              "PREFER_PICKUP_ADDRESS"="preferPickupAddr",
              "PREFER_DELIVERY_ADDRESS"="preferDeliveryAddr",
              "S_WORKING_DATE"="sWorkingDate",
              "E_WORKING_DATE"="eWorkingDate"))


# veh_rename <- rename( veh_sub,
#                       c(
#                         "vehicleId"="VEHICLE_ID",
#                         "carNum"="CAR_NUM",
#                         "shipperCd"="SHIPPER_CD",
#                         "vehicleClass"="VEHICLE_CLASS",
#                         "vehicleScale"="VEHICLE_SCALE",
#                         "vehicleOption"="VEHICLE_OPTION",
#                         "vehicleType"="VEHICLE_TYPE",
#                         "volCapa"="VOLUME_CAPA",
#                         "wtCapa"="WEIGHT_CAPA",
#                         "boxCapa"="BOX_CAPA",
#                         "costCapa"="COST_CAPA",
#                         "visitNodeCapa"="VISIT_NODE_CAPA",
#                         "distanceCapa"="DISTANCE_CAPA",
#                         "timeCapa"="TIME_CAPA",
#                         "height"="HEIGHT",
#                         "volRate"="VOLUME_RATE",
#                         "wtRate"="WEIGHT_RATE",
#                         "boxRate"="BOX_RATE",
#                         "costRate"="COST_RATE",
#                         "visitNodeRate"="VISIT_NODE_RATE",
#                         "distanceRate"="DISTANCE_RATE",
#                         "timeRate"="TIME_RATE",
#                         "curOrderId"="CURRENT_ORDER_ID",
#                         "curLocX"="CURRENT_LOC_X",
#                         "curLocY"="CURRENT_LOC_Y",
#                         "curDesX"="CURRENT_DES_X",
#                         "curDesY"="CURRENT_DES_Y",
#                         "garageX"="GARAGE_X",
#                         "garageY"="GARAGE_Y",
#                         "sWorkingDate"="S_WORKING_DATE",
#                         "eWorkingDate"="E_WORKING_DATE",
#                         "preferPickupAddr"="PREFER_PICKUP_ADDRESS",
#                         "preferDeliveryAddr"="PREFER_DELIVERY_ADDRESS",
#                         "sWorkingTime"="S_WORKING_TIME",
#                         "eWorkingTime"="E_WORKING_TIME" )
#               )

View(veh_rename)



exportJson <- toJSON(veh_rename)

write(exportJson, file = 'pdVehicle_full.json')
