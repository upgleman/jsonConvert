# ord <- read.table("20220106_000000000001_raw_ORDER2.csv", sep=",",header = TRUE)
install.packages("reshape")
library(reshape)
library(dplyr)
library('jsonlite')

ord <- read.table("20220106_000000000001_raw_ORDER.csv", sep=",", head = TRUE, fileEncoding = "UTF-8", encoding = "CP949")

View(ord)

# rm(ord)

str(ord$ORDER_ID)

# ord$ORDER_ID <- as.character(ord$ORDER_ID)

#OrderID 12자리 처리
ord <- transform(ord,
                 ORDER_ID_S= sprintf("%012d",ORDER_ID))

ord$ORDER_ID <-ord$ORDER_ID_S

str(ord$ORDER_ID)
# ord$ORDER_ID_S

#문자열로 변환
ord$VEHICLE_OPTION <- as.character(ord$VEHICLE_OPTION)
ord$VEHICLE_TYPE <- as.character(ord$VEHICLE_TYPE)
ord$BOX_TYPE <- as.character(ord$BOX_TYPE)
ord$ORDER_TEMPERATURE <- as.character(ord$ORDER_TEMPERATURE)
ord$ORDER_TYPE <- as.character(ord$ORDER_TYPE)
ord$LOADING_TYPE <- as.character(ord$LOADING_TYPE)
ord$UNLOADING_TYPE <- as.character(ord$UNLOADING_TYPE)
ord$ENABLE_PACKAGE <- as.character(ord$ENABLE_PACKAGE)
ord$ENABLE_REV_NEGO <- as.character(ord$ENABLE_REV_NEGO)

# str(ord$VEHICLE_OPTION)

#특정열 제거
ord_sub <- subset(ord, select = -c(ORDER_ID_S,CUSTOMER_CD,GROUP_CD))

View(ord_sub)




# row_rename <-     rename(ord_sub,
#                           c("ORDER_ID"="orderId",
#                             "ORDER_CLASS"="orderClass",
#                             "VEHICLE_CLASS"="vehicleClass",
#                             "VEHICLE_OPTION"="vehicleOption",
#                             "VEHICLE_TYPE"="vehicleType",
#                             "VEHICLE_SCALE"="vehicleScale",
#                             "SHIPPER_CD"="shipperCd",
#                             "BOX_TYPE"="boxType",
#                             "BOX_SIZE"="boxSize",
#                             "ORDER_TEMPERATURE"="orderTemp",
#                             "ORDER_TYPE"="orderType",
#                             "ORDER_VOLUME"="orderVol",
#                             "ORDER_WEIGHT"="orderWt",
#                             "ORDER_BOX"="orderBox",
#                             "ORDER_COST"="orderCost",
#                             "P_X"="pX",
#                             "P_Y"="pY",
#                             "P_LOCATION_NM"="pLocationNm",
#                             "P_ADDRESS"="pAddress",
#                             "P_SUB_ADDRESS"="pSubAddress",
#                             "P_ZIP_CODE"="pZipCode",
#                             "P_PNU"="pPnu",
#                             "D_X"="dX",
#                             "D_Y"="dY",
#                             "D_LOCATION_NM"="dLocationNm",
#                             "D_ADDRESS"="dAddress",
#                             "D_SUB_ADDRESS"="dSubAddress",
#                             "D_ZIP_CODE"="dZipCode",
#                             "D_PNU"="dPnu",
#                             "P_ORDER_DATE"="pOrderDate",
#                             "P_SLA_TIME"="pSlaTime",
#                             "P_OPEN_TIME"="pOpenTime",
#                             "P_CLOSE_TIME"="pCloseTime",
#                             "D_ORDER_DATE"="dOrderDate",
#                             "D_SLA_TIME"="dSlaTime",
#                             "D_OPEN_TIME"="dOpenTime",
#                             "D_CLOSE_TIME"="dCloseTime",
#                             "LOADING_TYPE"="loadingType",
#                             "P_EST_PROC_TIME"="pEstProcTime",
#                             "P_MGR_NM"="pMgrNm",
#                             "P_CONTACT"="pContact",
#                             "UNLOADING_TYPE"="unloadingType",
#                             "D_EST_PROC_TIME"="dEstProcTime",
#                             "D_MGR_NM"="dMgrNm",
#                             "D_CONTACT"="dContact",
#                             "ENABLE_PACKAGE"="enablePack",
#                             "ENABLE_REV_NEGO"="enableRevNego",
#                             "REMARK"="remark"))

row_rename <-     rename(ord_sub,
                         c(
                           "orderId"="ORDER_ID",
                           "orderClass"="ORDER_CLASS",
                           "vehicleClass"="VEHICLE_CLASS",
                           "vehicleOption"="VEHICLE_OPTION",
                           "vehicleType"="VEHICLE_TYPE",
                           "vehicleScale"="VEHICLE_SCALE",
                           "shipperCd"="SHIPPER_CD",
                           "boxType"="BOX_TYPE",
                           "boxSize"="BOX_SIZE",
                           "orderTemp"="ORDER_TEMPERATURE",
                           "orderType"="ORDER_TYPE",
                           "orderVol"="ORDER_VOLUME",
                           "orderWt"="ORDER_WEIGHT",
                           "orderBox"="ORDER_BOX",
                           "orderCost"="ORDER_COST",
                           "pX"="P_X",
                           "pY"="P_Y",
                           "pLocationNm"="P_LOCATION_NM",
                           "pAddress"="P_ADDRESS",
                           "pSubAddress"="P_SUB_ADDRESS",
                           "pZipCode"="P_ZIP_CODE",
                           "pPnu"="P_PNU",
                           "dX"="D_X",
                           "dY"="D_Y",
                           "dLocationNm"="D_LOCATION_NM",
                           "dAddress"="D_ADDRESS",
                           "dSubAddress"="D_SUB_ADDRESS",
                           "dZipCode"="D_ZIP_CODE",
                           "dPnu"="D_PNU",
                           "pOrderDate"="P_ORDER_DATE",
                           "pSlaTime"="P_SLA_TIME",
                           "pOpenTime"="P_OPEN_TIME",
                           "pCloseTime"="P_CLOSE_TIME",
                           "dOrderDate"="D_ORDER_DATE",
                           "dSlaTime"="D_SLA_TIME",
                           "dOpenTime"="D_OPEN_TIME",
                           "dCloseTime"="D_CLOSE_TIME",
                           "loadingType"="LOADING_TYPE",
                           "pEstProcTime"="P_EST_PROC_TIME",
                           "pMgrNm"="P_MGR_NM",
                           "pContact"="P_CONTACT",
                           "unloadingType"="UNLOADING_TYPE",
                           "dEstProcTime"="D_EST_PROC_TIME",
                           "dMgrNm"="D_MGR_NM",
                           "dContact"="D_CONTACT",
                           "enablePack"="ENABLE_PACKAGE",
                           "enableRevNego"="ENABLE_REV_NEGO",
                           "remark"="REMARK"))


View(row_rename)




exportJson <- toJSON(row_rename)

write(exportJson, file = 'pdOrder_full.json')
