SELECT Count(a.orderID) AS AT, 
a.Facilityid, Facilities.`Facility Name`, 
a.StudentID, PassengersOnly.FirstName, 
PassengersOnly.LastName, min(Facilities.Address) AS FA,
 min(a.Idates) AS FirstOfIdates
FROM ((a LEFT JOIN Facilities ON 
a.Facilityid = Facilities.FacilityID) 
LEFT JOIN Drivers ON a.DriverID = Drivers.DriverID) 
LEFT JOIN PassengersOnly ON 
a.StudentID = PassengersOnly.StudentID
,(SELECT DISTINCT  Vouchers.VoucherID , Vouchers.orderID, Vouchers.Facilityid , 
 Vouchers.StudentID ,  Vouchers.DriverID ,  Vouchers.DayofWeek , 
 Vouchers.Turn ,   Vouchers.Transfered ,  Vouchers.Void , 
 Vouchers.dateofservice ,  Passengers.Arrival ,  Passengers.Departure, 
 `passengers`.`Amount to Bill Center`, `Passengers`.`Tax%` as Tax,
 `passengers`.`Amount to Bill Center` + 
 (`passengers`.`Amount to Bill Center` * `Passengers`.`Tax%`/100) AS tot,
 getdatesH( Vouchers.studentid , Vouchers.facilityid, '2015-03-01','2015-03-15' ) AS Idates
FROM Passengers RIGHT JOIN Vouchers ON Passengers.OrderID = Vouchers.OrderID
WHERE  Vouchers.dateofservice >= '2015-03-01' and Vouchers.dateofservice <= '2015-03-15'
UNION
SELECT DISTINCT  VouchersHistory.VoucherID , VouchersHistory.orderID, VouchersHistory.Facilityid , 
 VouchersHistory.StudentID ,  VouchersHistory.DriverID ,  VouchersHistory.DayofWeek , 
 VouchersHistory.Turn ,   VouchersHistory.Transfered ,  VouchersHistory.Void , 
 VouchersHistory.dateofservice ,  Passengers.Arrival ,  Passengers.Departure, 
 `passengers`.`Amount to Bill Center`, `Passengers`.`Tax%` as Tax,
 `passengers`.`Amount to Bill Center` + 
 (`passengers`.`Amount to Bill Center` * `Passengers`.`Tax%`/100) AS tot,
 getdatesH( VouchersHistory.studentid , VouchersHistory.facilityid, '2015-03-01','2015-03-15' ) AS Idates
FROM Passengers RIGHT JOIN VouchersHistory ON Passengers.OrderID = VouchersHistory.OrderID
WHERE  VouchersHistory.dateofservice >= '2015-03-01' and VouchersHistory.dateofservice <= '2015-03-15') AS a

GROUP BY a.Facilityid, Facilities.`Facility Name`, 
a.StudentID, PassengersOnly.FirstName, PassengersOnly.LastName