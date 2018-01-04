SELECT DISTINCT
  con.ID AS containerID
 ,con.BARCODE AS stagingID
 ,inb_parent.BARCODE AS inboundID
 ,pct.NAME AS containerType
 ,con.LAST_SCANNED_DATE AS lastScannedDateStr
 ,con.CREATE_DATE AS createDateStr
 ,sub.materialName AS materialName
 ,sub.materialId AS materiaTypeIds
 ,locationPath.locationName AS locationName
 ,ccte.NAME AS externalCondition
 ,ccti.NAME AS internalCondition
 ,ccte.NOTE_REQUIRED_FLG AS externalCondNoteRequired
 ,ccti.NOTE_REQUIRED_FLG AS internalCondNoteRequired
 ,con.INTERNAL_CONDITION_ID AS intConditionId
 ,con.EXTERNAL_CONDITION_ID AS extConditionId
 ,con.TRACKING_NUMBER AS trackingNumber
 ,ccte.ID AS externalConditionTypeId
 ,ccti.ID AS internalConditionTypeId
 ,acc.ID AS accountId
 ,acc.ACCOUNT_CODE AS accountCode
 ,con.TEMPERATURE_LOGGER_ID AS temperatureLoggerID
 ,ISNULL(con.SHIPPING_CONDITION, '-') AS shippingCondition
 ,dbo.GROUP_CONCAT(sp.NAME) AS specialProcessing
 ,procct.ID AS processingContainerTypeId
 ,m.PRIMARYID AS studyId
 ,con.ALTERNATE_BARCODE AS alternateBarcode
 ,con.ALTERNATE_BOX_ID AS alternateBoxId
 ,IIF(sub1.empty = 'Y', 'Yes', 'No') AS empty
 ,COUNT(note2.ID) AS notes
 ,cont.CONTACT_NAME AS createdBy
 ,wr.BARCODE AS workRequestBarcode
 ,(SELECT
      dbo.GROUP_CONCAT_DS(cspl.SPECIAL_PROCESSING_ID, ';', 1)
    FROM CONTAINER_SPEC_PROC_LNK cspl
    WHERE cspl.CONTAINER_ID = con.ID)
  AS specProcIdList
FROM CONTAINER con
INNER JOIN CONTAINER_MAT_TYPE_LINK cmtl
  ON cmtl.CONTAINER_ID = con.ID
INNER JOIN CONTAINER con_parent
  ON con_parent.ID = con.PARENT_CONTAINER_ID
INNER JOIN PHYSICAL_CONTAINER_TYPE pct
  ON con.PHYSICAL_CONTAINER_TYPE_ID = pct.ID
INNER JOIN PROCESSING_CONTAINER_TYPE procct
  ON con.PROCESSING_CONTAINER_TYPE_ID = procct.ID
INNER JOIN MATERIAL_TYPE matType
  ON cmtl.INBOUND_MATERIAL_TYPE_ID = matType.ID
INNER JOIN EAP_WORK_REQUEST wr
  ON wr.ID = con.WORK_REQUEST_ID
INNER JOIN WR_TASK task
  ON task.WORK_REQUEST_ID = wr.ID
INNER JOIN WR_SUBTASK subtask
  ON subtask.TASK_ID = task.ID
LEFT JOIN CONTAINER_SPEC_PROC_LNK cspl
  ON con.ID = cspl.CONTAINER_ID
LEFT JOIN SPECIAL_PROCESSING sp
  ON cspl.SPECIAL_PROCESSING_ID = sp.ID
LEFT JOIN CONTAINER_CONDITION cci
  ON con.INTERNAL_CONDITION_ID = cci.ID
LEFT JOIN CONTAINER_CONDITION_TYPE ccti
  ON cci.CONDITION_TYPE_ID = ccti.ID
LEFT JOIN CONTAINER_CONDITION cce
  ON con_parent.EXTERNAL_CONDITION_ID = cce.ID
LEFT JOIN CONTAINER_CONDITION_TYPE ccte
  ON cce.CONDITION_TYPE_ID = ccte.ID
LEFT JOIN EAP_USER eu
  ON eu.ID = con.CREATE_BY
LEFT JOIN EAP_CONTACTS cont
  ON cont.ID = eu.CONTACT_ID
LEFT JOIN LOCATION loc
  ON con.LOCATION_ID = loc.ID
CROSS APPLY (SELECT
    dbo.GROUP_CONCAT_D(lPath.NAME, '-') AS locationName
  FROM LOCATION lPath
  WHERE loc.HID.IsDescendantOf(lPath.HID) = 1) AS locationPath
LEFT JOIN EAM_ACCOUNT acc
  ON wr.ACCOUNT_ID = acc.ID
LEFT JOIN MATERIAL_TRANSFER_CONTAINER mtc
  ON mtc.CONTAINER_ID = con.ID
LEFT JOIN CONTAINER_METAINDEX_LINK cml
  ON cml.CONTAINER_ID = con.ID
LEFT JOIN METAINDEX m
  ON m.ID = cml.METAINDEX_ID
LEFT JOIN note2 note2
  ON note2.PARENT_ID = con.ID
    AND note2.PARENT_TABLE = 'CONTAINER'
INNER JOIN (SELECT
    conSub.ID AS contID
   ,dbo.GROUP_CONCAT_DS(mt.NAME, ', ', 1) AS materialName
   ,dbo.GROUP_CONCAT_D(mt.ID, ',') AS materialId
  FROM CONTAINER conSub
  LEFT JOIN CONTAINER_MAT_TYPE_LINK cmtl
    ON conSub.ID = cmtl.CONTAINER_ID
  INNER JOIN MATERIAL_TYPE mt
    ON mt.ID = cmtl.INBOUND_MATERIAL_TYPE_ID
  WHERE mt.ID = cmtl.INBOUND_MATERIAL_TYPE_ID
  GROUP BY conSub.ID) sub
  ON sub.contID = con.ID
INNER JOIN CONTAINER inb_parent
  ON con.HID.IsDescendantOf(inb_parent.HID) = 1
    AND inb_parent.PROCESSING_CONTAINER_TYPE_ID = ?
LEFT JOIN (SELECT
    conSub1.ID AS contID
   ,cmtl.IS_EMPTY AS empty
  FROM CONTAINER conSub1
  LEFT JOIN CONTAINER_MAT_TYPE_LINK cmtl
    ON conSub1.ID = cmtl.CONTAINER_ID
  INNER JOIN MATERIAL_TYPE mt
    ON mt.ID = cmtl.INBOUND_MATERIAL_TYPE_ID
  WHERE mt.ID = cmtl.INBOUND_MATERIAL_TYPE_ID
  AND cmtl.INBOUND_MATERIAL_TYPE_ID = ?
  GROUP BY conSub1.ID
          ,cmtl.IS_EMPTY) sub1
  ON sub1.contID = con.ID
WHERE subtask.ID = ?
AND matType.ID IN (SELECT
    MATERIAL_TYPE_ID
  FROM WR_TASK_TYPE tt
  JOIN WR_TASK t
    ON t.TASK_TYPE = tt.ID
  JOIN WR_SUBTASK s
    ON s.TASK_ID = t.ID
  WHERE s.ID = ?)
AND cmtl.INBOUND_MATERIAL_TYPE_ID = ?
AND (sub1.empty = 'N'
OR sub1.empty IS NULL)
AND con.ID IN (?)
AND procct.ID IN (?, ?)
AND (m.ID = ?
OR m.ID IS NULL)
GROUP BY con.ID
        ,locationPath.locationName
        ,acc.ACCOUNT_CODE
        ,acc.ID
        ,con.BARCODE
        ,pct.NAME
        ,con.LAST_SCANNED_DATE
        ,matType.NAME
        ,inb_parent.BARCODE
        ,con.CREATE_DATE
        ,ccte.NAME
        ,ccti.NAME
        ,con.TEMPERATURE_LOGGER_ID
        ,con.SHIPPING_CONDITION
        ,ccte.NOTE_REQUIRED_FLG
        ,ccti.NOTE_REQUIRED_FLG
        ,con.INTERNAL_CONDITION_ID
        ,con.EXTERNAL_CONDITION_ID
        ,con.TRACKING_NUMBER
        ,ccte.ID
        ,ccti.ID
        ,procct.ID
        ,m.PRIMARYID
        ,con.ALTERNATE_BARCODE
        ,wr.BARCODE
        ,con.ALTERNATE_BOX_ID
        ,cmtl.IS_EMPTY
        ,cont.CONTACT_NAME
        ,sub.materialName
        ,sub.materialId
        ,sub1.empty