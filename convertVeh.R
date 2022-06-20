install.packages("reshape")
library(reshape)
library('jsonlite')


veh <- read.table("20220106_000000000001_raw_VEHICLE_refine.csv", sep=",", head = TRUE, fileEncoding = "UTF-8", encoding = "CP949")

View(veh)

# rm(veh)

#OrderID 12자리 처리
veh <- transform(veh,
                 VEHICLE_ID_S= sprintf("%010d",VEHICLE_ID))

veh$VEHICLE_ID<- veh$VEHICLE_ID_S

veh$VEHICLE_OPTION <- as.character(veh$VEHICLE_OPTION)
veh$VEHICLE_TYPE <- as.character(veh$VEHICLE_TYPE)
veh$E_WORKING_DATE <- as.character(veh$E_WORKING_DATE)
veh$S_WORKING_DATE <- as.character(veh$S_WORKING_DATE)

veh_sub <- subset(veh, select = -c(VEHICLE_ID_S,CUSTOMER_CD,GROUP_CD))

View(veh_sub)



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

View(veh_rename)



exportJson <- toJSON(veh_rename)

write(exportJson, file = 'pdVehicle.json')
