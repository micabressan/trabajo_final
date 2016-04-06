select bpi.object_id, bpi.name, pseq.value, cref.value
 from nc_objects bpi,
      nc_params action,
 nc_params_ix pseq,
 nc_params_ix cref,
 nc_params stype,
 custproductstatus@rbm_dblink cps
  where bpi.object_type_id = 9126083628313449001 /* Business Product Instance */
    and action.object_id = bpi.object_id
    and action.attr_id = 9126143611313472389 /* Product Instance Status */
    and action.list_value_id = 9126143611313472393 /* 6#9BBB59$Active */
    and pseq.object_id = bpi.object_id
    and pseq.attr_id=9135284080613451078 /* Sequence Number */
    and stype.object_id = bpi.object_id
    and stype.attr_id=9136668470113027337 /* Service Type */
    and stype.value = 'Mobiland'
    and cref.object_id = bpi.object_id
    and cref.attr_id=9135284080613451076 /* Customer Reference */
    and cref.ix_key='44497'
    and cps.customer_ref = cref.ix_key
 and cps.product_seq = pseq.ix_key
 and cps.product_status = 'TX';