ord <- read.table("20220106_000000000001_raw_ORDER2.csv", sep=",",header = TRUE)

View(ord)

# rm(veh)

# veh2 <- read.table("20220106_000000000001_raw_VEHICLE.csv", sep=",", head = TRUE, encoding = "UTF-8")



# row_1 <- veh[c(1,2,3),]

#특정열 제거
ord_sub <- subset(ord, select = -c(CUSTOMER_CD,GROUP_CD))

View(ord_sub)

install.packages("reshape")
library(reshape)


row_rename <-     rename( veh_sub, 
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
                            "S_WORKING_TIME"="sWorkingDate",
                            "E_WORKING_TIME"="eWorkingDate",
                            "PREFER_PICKUP_ADDRESS"="preferPickupAddr",
                            "PREFER_DELIVERY_ADDRESS"="preferDeliveryAddr",
                            "S_WORKING_DATE"="sWorkingTime",
                            "E_WORKING_DATE"="eWorkingTime"))

View(row_rename)

library('jsonlite')

exportJson <- toJSON(row_rename)

write(exportJson, file = 'pdVehicle.json')