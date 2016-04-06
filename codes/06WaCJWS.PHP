<script src="<?php echo base_url(); ?>js/jquery.maskMoney.js" type="text/javascript"></script>
    <style type="text/css">
    #item_kit_size{
        width:99%; 
        font: 13px solid;
        margin-left: 5px ;
        margin-top: 10px !important;
    }
    #item_kit_size tr td{
        border: 1px solid #CDCDCD;
        padding: 3px 5px;
    }
    #item_kit_size tr th{
        border: 1px solid #CDCDCD;
        background: #e8e8e8;
        color: #000;
        padding: 5px 5px;
    }
    .submit_button{
        margin-bottom:20px
    }
    #item_kit_feature{
        margin-bottom: 10px;
    }
    #size_detail tr td, #quantity_detail tr td{
        line-height: 290%;
        border: none;
        border-top: 1px solid #CDCDCD;
    }
    #size_detail tr:first-child td, #quantity_detail tr:first-child td{
        border-top: none;
    }
     
    #item_kit_money{
        width:100%;
        font: 13px solid;
        margin-left: 5px ;
        margin-top: 10px !important;
    }
    #item_kit_money{
        width:99%; 
    }
    #item_kit_money tr td{
        border: 1px solid #CDCDCD;
        padding: 3px 5px;
    }
    #item_kit_money tr th{
        border: 1px solid #CDCDCD;
        background: #e8e8e8;
        color: #000;
        padding: 5px 5px;
    }
     
    #table_info_item_kit{
        width: 98%;
        margin-left: 5px;
        font-size: 12px;    
    }
    #table_info_item_kit tr td{
        padding: 4px 0px;
    }
    #table_info_item_kit .left_table{
        width: 15%;
        font-weight: bold;
    }
    #table_info_item_kit .right_table{
        width: 35%;
    }    
    //Hưng Audi 3-8-15
    .item_kit_processes tr td{
        padding: 3px 5px;
    }
    .time_processes, .processes_money{
        height: 20px;
        text-align: right;
        padding-right: 6px;
    }
    .id_processes, .unit_time{
        height: 22px;
        padding-left: 5px;
        text-align: left;
    }
    .cost_money{
        height: 20px;
        text-align: right;
        padding-right: 6px;
    }
    .cost_name, .outsource_input{
        height: 20px;
        width: 200px;
        text-align: left;
        padding-left: 6px;    
    }
    #brand_table{
        width: 100%;
        border: 1px solid #CDCDCD;
    }    
    #brand_table tr, #brand_table tr td, #brand_table tr th{
        border: 1px solid #CDCDCD;
        text-align: center;
        padding: 5px
    }
    #car_table{
        color: green;
    }
    .car_th{
        background: #e8e8e8;
    }
    .brand_tr{
        background: #E1E6FF;
    }
    .processes_money{
        background: #E1E6FF
    }
    .space_tr{
        height: 20px;
        background: #d1d1d1
    }
    .processes_money, .total_money_norms, .processes_money_total, .money_total{
        text-align: right;
        margin-right: 5px;
        border: none
    }
    .disable_input_cost {
            display: none;
    }
    .title_cost{
        border: none;
        background: #e8e8e8;
        font-size: 13px;
        font-weight: bold;
        }
    tr#car_table_tr_first td, tr#car_table_tr_first, #row_selected tr, #row_selected tr td{
        border: none;
    }
    .append_car{
        font-size: 16px;
        margin-left: 333px;
    }
    </style>
    <?php if( $production_design->num_rows() == 0){
        echo 'Chưa có mẫu sản xuất nào được phê duyệt !';exit();
    }?>
    <ul id="error_message_box"></ul>
    <fieldset id="item_kit_info">
        <legend>Thông tin sản phẩm</legend>
        <table id="table_info_item_kit">
            <tr>
                <td class="left_table"><?php echo form_label('Mã sản phẩm:', name, array('class' => wide)); ?></td>
                <td class="right_table"><?=$item_kit_info->item_kit_number;?></td>
                <td class="left_table"><?php echo form_label(lang(item_kits_name) . ':', name, array('class' => wide)); ?></td>
                <td class="right_table"><?=$item_kit_info->name;?></td>
            </tr>
            <tr>
                <td class="left_table"><?php echo form_label(lang(item_kits_unit) . ':', unit, array('class' => wide)); ?></td>
                <td class="right_table"> <?= $this->Unit->get_info($item_kit_info->unit)->name ?></td>
                <td class="left_table"><?php echo form_label(lang(items_category) . ':', category, array('class' => wide)); ?></td>
                <td class="right_table"><?= $this->Category->get_info($item_kit_info->category)->name ?></td>
            </tr>
        </table>    
    </fieldset>    
    <?php echo form_open_multipart('item_kits/save_item_kit_processes/' . $request_id, array(id => item_kit_form_approve_estimate)); ?>    
    <fieldset id="item_kit_feature">
        <legend>Thông tin sản xuất</legend>
        <div class="field_row clearfix">
            <?php echo form_label('Mã yêu cầu:', request_id, array('class' => wide)); ?>
            <div class='form_field'><?= $info_request_production->request_id ?></div>
        </div>
        <h4>&nbsp;* Tổng hợp mẫu sản xuất : </h4>
        <table id=item_kit_size>
            <tr style='text-align: center'>
                <th style="width: 10%" rowspan="2">Tên mẫu</th>
                <th colspan="2">Thông tin size</th>
                <th colspan="9">Công thức nguyên vật liệu</th>
            </tr>
            <tr>
                <th style="width: 5%">Size</th>
                <th style="width: 5%">SL size</th>
                <th style="width: 10%">Mã NVL</th>
                <th style="width: 10%">Tên NVL</th>
                <th style="width: 6%">ĐVT</th>
                <th style="width: 7%">Định mức/SP</th>
                <th style="width: 7%">Tổng định mức</th>
                <th style="width: 10%">Giá nhập</th>
                <th style="width: 10%">Giá xuất</th>
                <th style="width: 10%">SL trong kho</th>
                <th style="width: 10%">SL còn lại</th>
               
            </tr>
            <?php $total_size = 0;
            $total_norms_per_item = 0;
            $total_norms = 0;
            $total_money_norms = 0;
            foreach ($request_feature as $f){
                $i = $this->Item_kit->count_formula_materials($f->feature_id);
                $info_feature = $this->Item_kit->get_info_item_kit_feature($f->feature_id);
                ?>
                <tr>
                    <td style='text-align: left; width: 10%;' rowspan="<?= $i ?>"><?= $info_feature->name_feature ?></td>
                    <?php $info_sizes = $this->Item_kit->get_size_by_request_feature($f->request_id,$f->feature_id);?>
                    <td rowspan="<?= $i ?>" style="width: 5%;">
                        <table id="size_detail">
                            <?php foreach ($info_sizes as $is) {?>
                            <tr>
                                <td>
                                    <?= $is->size?>
                                </td>                            
                            </tr>
                            <?php
                            }?>
                        </table>
                    </td>
                    <td rowspan="<?= $i ?>" style="text-align: right; width: 5%">
                        <table id="quantity_detail">
                            <?php                        
                            foreach ($info_sizes as $is) {
                                $total_size += $is->quantity?>
                                <tr>
                                    <td>
                                        <?= $is->quantity?>
                                    </td>
                                </tr>
                            <?php
                            }?>
                        </table>
                    </td>
                        <?php                
                    $info_formula_material = $this->Item_kit->get_info_formula_materials($f->feature_id);
                    foreach ($info_formula_material as $fm) {
                        $info_store = $this->Create_invetory->check_exist_store_materials();
                        $item_info = $this->Item->get_info_in_store_material($fm[item_id], $info_store[id]);
                        $info_formula_material_item = $this->Item_kit->get_info_formula_materials_item($fm[item_id]);
                        $unit_info = $this->Unit->get_info($info_formula_material_item->unit);
                        $item_size = $this->Item_kit->get_info_item_size($f->feature_id, $fm[item_id]);
                        $total_quantity = $item_size->quantity_size * $item_size->quantity;
                        $cost_price = $item_info->quantity_first != 0 ? $item_info->cost_price_rate : $item_info->cost_price;
                       
                        $total_norms_per_item += $item_size->quantity;
                        $total_norms += $total_quantity;
                        $total_money_norms += $total_quantity * $cost_price;
                        ?>
                        <td style="text-align: center; width: 10%;"><?= $item_info->item_number?></td>
                        <td style="width: 10%;"><?= $item_info->name?></td>
                        <td style="width: 6%;"><?= $unit_info->name?></td>
                        <td style="text-align: right; width: 7%;"><?= format_quantity($item_size->quantity)?></td>
                        <td style="text-align: right; width: 7%;"><?= format_quantity($total_quantity)?></td>
                        <td style="text-align: right; width: 10%;">
                            <?= format_quantity($cost_price) ?>
                        </td>
                        <td style="text-align: right; width: 10%;">
                            <?= format_quantity($item_info->quantity_first != 0 ? $item_info->unit_price_rate : $item_info->unit_price) ?>
                        </td>
                        <td style="text-align: right; width: 10%;">
                            <?= format_quantity($item_info->quantity);?>
                        </td>
                        <td style="text-align: right; width: 10%;">
                            <?= format_quantity($item_info->quantity - $total_quantity >= 0 ? $item_info->quantity - $total_quantity : 0)?>
                        </td>
                    </tr>
                 <?php  
                }
            }?>
            <tfoot style="font-weight: bold">
                <td colspan="2"> Tổng</td>
                <td style="text-align: right;"><?= $total_size?></td>
                <td colspan="3" style="background: #e8e8e8"></td>
                <td style="text-align: right;"><?= $total_norms_per_item ?></td>
                <td style="text-align: right;"><?= $total_norms ?></td>
                <td colspan="4" style="background: #e8e8e8"></td>
            </tfoot>
        </table>
        <h4>&nbsp;* Tổng hợp công đoạn SX : </h4>
            <table id="brand_table">
                <tr>
                    <td colspan="6" >
                    <a href="#" class="append" id="append_<?= $item_kit_id?>" style="font-size: 16px; color: blueviolet; "> + Thêm công đoạn </a></td>
                </tr>    
                <tr style="border: 1px solid green">
                    <th style="width: 5%">STT</th>
                    <th style="width: 30%">Công đoạn</th>
                    <th style="width: 10%">Thời gian</th>
                    <th style="width: 20%">Đơn vị thời gian</th>
                    <th style="width: 20%">Chi phí công đoạn</th>
                    <th style="width: 10%">Xóa</th>
                </tr>
                <?php
                $unit_time = array(
                    ''=>'-- Chọn đơn vị thời gian --',
                    0=>Giờ,
                    1=>Ngày
                );
                $processes_money_total = 0;
                if($item_kit_processes->num_rows() == 0){
                    $pro_id = 1;?>
                    <tr class=brand_tr id=brand_tr_<?= $pro_id?> >
                        <td><?=
                            form_input(array(
                                name => "pro_id[$pro_id]",
                                id => "pro_id_$pro_id",
                                'class' => pro_id,
                                type => hidden,
                            ));
                            ?><?= $pro_id?></td>
                        <td><?=
                            form_dropdown("id_processes[$pro_id]", $processes, '', "class=id_processes id=id_processes_$pro_id")
                            ?></td>
                        <td><?=
                            form_input(array(
                                name => "time_processes[$pro_id]",
                                id => "time_processes_$pro_id",
                                'class' => time_processes,
                            ));
                            ?></td>
                        <td><?=
                            form_dropdown("unit_time[$pro_id]", $unit_time, '', "class=unit_time id=unit_time_$pro_id")
                            ?></td>
                        <td><?=
                            form_input(array(
                                name => "processes_money[$pro_id]",
                                id => "processes_money_$pro_id",
                                'class' => processes_money,
                                readonly=>""
                            ));
                            ?></td>
                        <td><a href=# class=del_brand onclick='return deleteBrandRow(this, <?= $pro_id?>);' >X</a></td>
                    </tr>
                    <tr id=car_tr_<?= $pro_id?>>
                        <td colspan="6" style="padding: 0px;">
                            <table class=car_table id=car_table_<?= $pro_id?>>
                                <tr id=car_table_tr_first>
                                    <td colspan="2" >
                                        <a href=# class=append_car id=append_car_<?= $pro_id?> style="color: blue"> + Thêm chi phí</a></td>
                                    <td colspan="2">
                                        <label style="margin-left: 200px">
                                            <input type="checkbox" name="chk[<?= $pro_id?>]" id="chk_<?= $pro_id?>" value="1" > Thuê ngoài
                                        </label>
                                    </td>
                                </tr>    
                                <tr class=car_th>
                                    <th style="width: 30%" class="title_cost<?= $pro_id?>">
                                        Tên chi phí
                                    </th>
                                    <th style="width: 30%" class="title_cost2<?= $pro_id?>">
                                        Tên nhà cung cấp
                                    </th>
     
                                    <th style="width: 30%">Giá chi phí</th>
                                    <th style="width: 30%">Ghi chú</th>
                                    <th style="width: 10%">Xóa</th>
                                </tr>
                                <?php $i=1;
                                $pro_id_i = $pro_id.$i;?>
                                <!-- tr cost name-->
                                <tr class=car_tr_cost_name<?= $pro_id ?> >
                                    <td><?= form_input(array(
                                            name => "cost_name[$pro_id_i]",
                                            id => "cost_name_$pro_id_i",
                                            'class' => cost_name,
                                        ));?>
                                    </td>
                                    <td><?= form_input(array(
                                            name => "cost_money[$pro_id_i]",
                                            id => "cost_money_$pro_id_i",
                                            'class' => "cost_money cost_money$pro_id",
                                            onchange => "calculate_cost($pro_id)"
                                        ));?>
                                    </td>
                                    <td><?=
                                        form_textarea(array(
                                            name => "comment[$pro_id_i]",
                                            id => "comment_$pro_id_i",
                                            'class' => "comment comment$pro_id",
                                            'rows' => 3,
                                            'cols' => 20,
                                        ));?>
                                    </td>
                                    <td><a href=# class=del_car onclick='return deleteCarRow(this, <?= $pro_id ?>);' >X</a></td>
                                    </td>
                                </tr>
                               
                                <!--car_tr_chk -->
                                <tr class="car_tr_chk<?= $pro_id ?>" >
                                </tr>  
                            </table>
                        </td>
                    </tr>
                    <tr><td colspan="6" id="space_tr_<?= $pro_id ?>" class=space_tr></td></tr>
                    <?php
                    echo form_input(array(
                        'class' => count_car,
                        type => hidden,
                        value => $pro_id
                    ));
                    $pro_id++;
                }else{
                    $pro_id = 1;
                    $stt = 1;
                    foreach ($item_kit_processes->result() as $ip){
                        $pro_id = $ip->pro_id;
                        $processes_money_total += $ip->processes_money;
                        $processes_cost = $this->Item_kit->get_info_processes_cost($request_id, $ip->id_processes);
                                ?>
                        <tr class=brand_tr id=brand_tr_<?= $pro_id?>>
                            <td><?=
                                form_input(array(
                                    name => "pro_id[$pro_id]",
                                    id => "pro_id_$pro_id",
                                    'class' => pro_id,
                                    type => hidden,
                                ));
                                ?><?= $stt?></td>
                            <td><?=
                                form_dropdown("id_processes[$pro_id]", $processes, $ip->id_processes, "class=id_processes id=id_processes_$pro_id")
                                ?></td>
                            <td><?=
                                form_input(array(
                                    name => "time_processes[$pro_id]",
                                    id => "time_processes_$pro_id",
                                    'class' => time_processes,
                                    value => $ip->time_processes,
                                ));
                                ?></td>
                            <td><?=
                                form_dropdown("unit_time[$pro_id]", $unit_time, $ip->unit_time, "class=unit_time id=unit_time_$pro_id")
                                ?></td>
                            <td><?=
                                form_input(array(
                                    name => "processes_money[$pro_id]",
                                    id => "processes_money_$pro_id",
                                    'class' => processes_money,
                                    value => number_format($ip->processes_money),
                                    readonly=>""
                                ));
                                ?></td>
                            <td><a href=# class=del_brand onclick='return deleteBrandRow(this, <?= $pro_id?>);' >X</a></td>
                        </tr>
                        <tr id=car_tr_<?= $pro_id?>>
                            <td colspan="6" style="padding: 0px;">
                                <table class=car_table id=car_table_<?= $pro_id?> >
                                    <tr id=car_table_tr_first>
                                        <td colspan="2">
                                            <a href=# class=append_car id=append_car_<?= $pro_id?> style="color: blue"> + Thêm chi phí</a></td>
                                        <td colspan="2">
                                            <label style="margin-left: 200px">
                                                <input type="checkbox" name="chk[<?= $pro_id?>]" id="chk_<?= $pro_id?>" value="1" <?= ($processes_cost->row()->outsource == 0) ? '' : 'checked=checked' ?>> Thuê ngoài
                                            </label>
                                        </td>
                                    </tr>    
                                    <tr class=car_th>
                                        <th style="width: 30%" class="title_cost<?= $pro_id?>">
                                            Tên chi phí
                                        </th>
                                        <th style="width: 30%" class="title_cost2<?= $pro_id?>">
                                            Tên nhà cung cấp
                                        </th>
                                       
                                        <th style="width: 30%">Giá chi phí</th>
                                        <th style="width: 30%">Ghi chú</th>
                                        <th style="width: 10%">Xóa</th>
                                    </tr>
                                    <?php $i=1;
                                    if ( $processes_cost->row()->outsource == 0){
                                        foreach ($processes_cost->result() as $pc){
                                            $pro_id_i = $pro_id.$i;?>
                                            <!-- row cost name -->
                                            <tr class="car_tr_cost_name<?= $pro_id ?>" >
                                                <td>
                                                    <?php
                                                    echo form_input(array(
                                                        name => "cost_name[$pro_id_i]",
                                                        id => "cost_name_$pro_id_i",
                                                        'class' => cost_name,
                                                        value => $pc->cost_name,
                                                    ));?>
                                                </td>
                                                <td><?=
                                                    form_input(array(
                                                        name => "cost_money[$pro_id_i]",
                                                        id => "cost_money_$pro_id_i",
                                                        'class' => "cost_money cost_money$pro_id",
                                                        value => number_format($pc->cost_money),
                                                        onchange => "calculate_cost($pro_id)"
                                                    ));?>
                                                </td>
                                                <td><?=
                                                    form_textarea(array(
                                                        name => "comment[$pro_id_i]",
                                                        id => "comment_$pro_id_i",
                                                        'class' => "comment comment$pro_id",
                                                        value => $pc->comment,
                                                        rows => 3,
                                                        cols => 20,
                                                    ));?>
                                                </td>
                                                <td><a href=# class=del_car onclick='return deleteCarRow(this, <?= $pro_id ?>);' >X</a></td>
                                            </tr>
                                        <?php $i++;
                                        }//end foreach
                                    }else{?>
                                        <!-- row outsource -->
                                        <tr class="car_tr_outsource<?= $pro_id ?>" >
                                            <td>
                                                <table id="row_selected" >
                                                    <?php
                                                    $info_supplier = $this->Supplier->get_info($processes_cost->row()->outsource);?>
                                                    <tr>
                                                        <td width="200px">
                                                            <?=
                                                            form_input(array(
                                                                name => "outsource[$pro_id]",
                                                                id => "outsource$pro_id",
                                                                value => $processes_cost->row()->outsource,
                                                                type => hidden
                                                            ));?>
                                                            <?= $info_supplier->company_name?></td>
                                                        <td><a href=# style="text-decoration: underline" onclick="return deleteRow(this, <?= $pro_id ?>)">Xóa</a>
                                                        </td>
                                                    </tr>
                                                </table>    
     
                                                <div class="part_outsource<?= $pro_id ?>">
                                                    <?php
                                                    echo form_input(array(
                                                        id => "outsource_input_$pro_id",
                                                        'class' => outsource_input,
                                                        placeholder => "Nhập tên nhà cung cấp"
                                                    )); ?>
                                                    <table id="row_selected<?= $pro_id ?>" >
                                                    </table>
                                                </div>
                                            </td>
                                            <td><?=
                                                form_input(array(
                                                    name => "cost_money[$pro_id]",
                                                    id => "cost_money_$pro_id",
                                                    'class' => "cost_money cost_money$pro_id",
                                                    value => number_format($processes_cost->row()->cost_money),
                                                    onchange => "calculate_cost($pro_id)"
                                                ));?>
                                            </td>
                                            <td><?=
                                                form_textarea(array(
                                                    name => "comment[$pro_id]",
                                                    id => "comment_$pro_id",
                                                    'class' => "comment comment$pro_id",
                                                    value => $processes_cost->row()->comment,
                                                    rows => 3,
                                                    cols => 20,
                                                ));?>
                                            </td>
                                            <td><a href=# class=del_car onclick='return deleteCarRow(this, <?= $pro_id ?>);' >X</a></td>
                                        </tr>
                                    <?php $i++;
                                    }//end else $processes_cost->row()->outsource != 0
                                    echo form_input(array(
                                        id => "count_car_$pro_id",
                                        'class' => count_car,
                                        type => hidden,
                                        value => $i
                                    ));?>
                                       
                                    <!--car_tr_chk -->
                                    <tr class="car_tr_chk<?= $pro_id ?>" >
                                    </tr>  
                                   
                                </table>
                            </td>
                        </tr>
                        <tr><td colspan="6" id="space_tr_<?= $pro_id ?>" class=space_tr></td></tr>
                        <?php
                        $pro_id++;
                        $stt++;
                    }//end foreach processes
                }//end else processes->num_rows
               echo form_input(array(
                    name => count_pro_id,
                    'class' => count_pro_id,
                    type => hidden,
                    value => $pro_id
                ));
                ?>
            </table>
        <h4>&nbsp;* Tổng hợp chi phí SX: </h4>
        <table id=item_kit_money>
            <tr style="text-align: center">
                <th style='width: 33%;'>Tổng chi phí NVL</th>
                <th style='width: 33%;'>Tổng chi phí công đoạn SX</th>
                <th style='width: 33%;'>Tổng tiền</th>
            </tr>
                <tr style='text-align: right'>
                    <td><?= form_input(array(
                        name => total_money_norms,
                        'class' => total_money_norms,
                        value => number_format($total_money_norms),
                        readonly => ''
                    ))?>
                    </td>
                    <td><?= form_input(array(
                        name => processes_money_total,
                        'class' => processes_money_total,
                        readonly => '',
                        value => number_format($processes_money_total)
                    ));?>
                    </td>
                    <td><?= form_input(array(
                        name => money_total,
                        'class' => money_total,
                        readonly => '',
                        value => number_format($total_money_norms + $processes_money_total)
                    ));?>
                    </td>
                </tr>
        </table>
        <br>  
        <?php echo form_submit(array(
            value => lang(common_submit),
            'class' => 'submit_button float_right',
            style => 'margin-bottom:20px',
            name => save_estimate
        ));?>
    </fieldset>
    <?php echo form_close(); ?>
    <script type="text/javascript">
    $(document).ready(function(){
        //append cost of processes old
        if($('.count_car').val() == 1){    
            status_checkbox(1);
            append_cost_and_click_checkbox(1, 2);
        }else{
            $("#brand_table").find('.brand_tr').each(function(index, element){
                var pro_id = $(element).attr('id').substring($(element).attr('id').lastIndexOf('_') + 1);
                var i = $('#count_car_'+pro_id).val();
               
                status_checkbox(pro_id);
                append_cost_and_click_checkbox(pro_id, i);
            });
        }
        //append processes & cost new
        var pro_id = $('.count_pro_id').val();
        var ii = 1;  
        var stt = $('#brand_table .brand_tr').length + 1;
        $('.append').click(function(){
            $('#brand_table').append(
                '<tr class=brand_tr id=brand_tr_'+pro_id+'>'
                    +'<td><input type=hidden name=pro_id['+pro_id+'] id="pro_id_'+pro_id+'" class=pro_id value='+pro_id+'  >'+stt+'</td>'
                    +'<td>'
                        +'<select name=id_processes['+pro_id+'] class=id_processes id=id_processes_'+pro_id+' >'
                            +'<option value= >-- Chọn công đoạn --</option>'
                            +'<?php foreach($this->Item_kit->get_all_processes_new()->result_array() as $r){ ?>'
                                +'<option value=<?= $r['id_processes']?> > <?= $r['name_processes']?></option>'
                            +'<?php }?>'
                        +'</select>'
                    +'</td>'
                    +'<td><input name=time_processes['+pro_id+'] id=time_processes_'+pro_id+' class=time_processes ></td>'
                    +'<td>'
                        +'<select name=unit_time['+pro_id+'] id=unit_time_'+pro_id+' class=unit_time >'
                            +'<option value= >-- Chọn đơn vị thời gian --</option>'
                            +'<option value=0 >Giờ</option>'
                            +'<option value=1 >Ngày</option>'
                        +'</select>'
                    +'</td>'
                    +'<td><input name=processes_money['+pro_id+'] id=processes_money_'+pro_id+' \n\
                            class=processes_money readonly ></td>'
                    +'<td><a href=# class=del_brand onclick="return deleteBrandRow(this, '+pro_id+');" >X</a></td>'
                +'</tr>'
                +'<tr id=car_tr_'+pro_id+'>'        
                    +'<td colspan="6" style="padding: 0px;">'
                        +'<table class=car_table id=car_table_'+pro_id+'>'
                            +'<tr id=car_table_tr_first>'
                                +'<td colspan="2" >'
                                    +'<a href=# class=append_car id=append_car_'+pro_id+' style=" color: blue"> + Thêm chi phí</a></td>'
                                +'<td colspan=2 >'
                                    +'<label style="margin-left: 200px">'
                                        +'<input type=checkbox name=chk id=chk_'+pro_id+' value=1 > Thuê ngoài'
                                    +'</label>'
                                +'</td>'
                            +'</tr>'  
                            +'<tr class=car_th>'
                                +'<th style="width: 30%" class=title_cost'+pro_id+'>Tên chi phí</th>'
                                +'<th style="width: 30%; display:none" class=title_cost2'+pro_id+'>Tên nhà cung cấp</th>'
                                +'<th style="width: 30%">Giá chi phí</th>'
                                +'<th style="width: 30%">Ghi chú</th>'
                                +'<th style="width: 10%">Xóa</th>'
                            +'</tr>'
                            +'<tr class=car_tr_cost_name'+pro_id+'>'
                                +'<td>'
                                    +'<input name=cost_name['+pro_id+ii+'] id=cost_name_'+pro_id+ii+' class=cost_name >'
                                +'</td>'
                                +'<td>'
                                    +'<input name=cost_money['+pro_id+ii+'] id=cost_money_'+pro_id+ii+' \n\
                                        class="cost_money cost_money'+pro_id+'" onchange="calculate_cost('+pro_id+')" >'
                                +'</td>'
                                +'<td><textarea name=comment['+pro_id+ii+'] id=comment_'+pro_id+ii+' \n\
                            class="comment comment'+pro_id+'" type=textarea cols=20 rows=3 ></textarea></td>'
                                +'<td><a href=# class=del_car onclick="return deleteCarRow(this, '+pro_id+')" >X</a></td>'
                            +'</tr>'
                            +'<tr class=car_tr_chk'+pro_id+' >'
                            +'</tr>'
                        +'</table>'
                    +'</td>'
                +'</tr>'
                +'<tr><td colspan="6" id=space_tr_'+pro_id+' class=space_tr></td></tr>'
            );
            //only enter number
            $(".time_processes").keydown(function (e) {
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                  (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
                  (e.keyCode >= 35 && e.keyCode <= 40)) {
                    return;
                }
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });
            $(".cost_money").keydown(function (e) {
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
                  (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
                  (e.keyCode >= 35 && e.keyCode <= 40)) {
                    return;
                }
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                    e.preventDefault();
                }
            });    
            append_cost_and_click_checkbox(pro_id, 2);
            pro_id++;
            stt++;
            return false;
        });
        setTimeout(function () {
            $(":input:visible:first", "#item_kit_form_approve_estimate").focus();
        }, 100);
        var submitting = false;
        $('#item_kit_form_approve_estimate').validate({  
            submitHandler: function (form) {
                if (submitting)
                    return;
                submitting = true;
                $(form).mask(<?php echo json_encode(lang('common_wait')); ?>);
                $(form).ajaxSubmit({
                    success: function (response) {
                        submitting = false;
                        tb_remove();
                        post_item_kit_form_submit(response);
                    },
                    dataType: 'json'
                });
            },
            errorLabelContainer: "#error_message_box",
            wrapper: "li",        
        });
    });
    function status_checkbox(pro_id){
        if ($('#chk_'+pro_id).is(':checked')){
            //title
            $('#car_table_'+pro_id+' .car_th .title_cost'+pro_id).hide();
            $('#car_table_'+pro_id+' .car_th .title_cost2'+pro_id).show();
            //link append
            $('#append_car_'+pro_id).hide();
            //hide div
            $('.part_outsource'+pro_id).hide();
            //hide show tr
            $('.car_tr_cost_name'+pro_id).hide();
            $('.car_tr_outsource'+pro_id).show();
            auto_complete(pro_id);
        } else{
            //title
            $('#car_table_'+pro_id+' .car_th .title_cost'+pro_id).show();
            $('#car_table_'+pro_id+' .car_th .title_cost2'+pro_id).hide();
            //link append
            $('#append_car_'+pro_id).show();
            //hide show tr
            $('.car_tr_cost_name'+pro_id).show();
            $('.car_tr_outsource'+pro_id).hide();
        }    
    }
    function append_cost_and_click_checkbox(pro_id, i){
        append_cost(pro_id, i);
       
        $('#chk_'+pro_id).click(function(){
            if ($('#chk_'+pro_id).is(':checked')){
                //title
                $('#car_table_'+pro_id+' .car_th .title_cost'+pro_id).hide();
                $('#car_table_'+pro_id+' .car_th .title_cost2'+pro_id).show();
                //link append
                $('#append_car_'+pro_id).hide();
                //remove tr chk
                $('.car_tr_cost_name'+pro_id+' td').remove();
                $('.car_tr_chk'+pro_id+' td').remove();
               
                append_outsource_chk(pro_id);
                auto_complete(pro_id);
            } else{
                //title
                $('#car_table_'+pro_id+' .car_th .title_cost'+pro_id).show();
                $('#car_table_'+pro_id+' .car_th .title_cost2'+pro_id).hide();
                //link append
                $('#append_car_'+pro_id).show();
                //remove tr chk  
                $('.car_tr_outsource'+pro_id).remove();
                $('.car_tr_chk'+pro_id+' td').remove();
               
                append_cost_name_chk(pro_id);
            }
        });
    }    
    function append_cost(pro_id, i){
        $('#append_car_'+pro_id).click(function(){
            $('#car_table_'+pro_id).append(
                '<tr class=car_tr_cost_name'+pro_id+' >'
                    +'<td><input name=cost_name['+pro_id+i+'] id=cost_name_'+pro_id+i+' class="cost_name cost_name'+pro_id+'" ></td>'
                    +'<td><input name=cost_money['+pro_id+i+'] id=cost_money_'+pro_id+i+' \n\
                        class="cost_money cost_money'+pro_id+'" onchange="calculate_cost('+pro_id+')" ></td>'
                    +'<td><textarea name=comment['+pro_id+i+'] id=comment_'+pro_id+i+' \n\
                    class="comment comment'+pro_id+'" type=textarea cols=20 rows=3 ></textarea></td>'
                    +'<td><a href=# class=del_brand onclick="return deleteCarRow(this, '+pro_id+');" >X</a></td>'
                +'</tr>'
            );
            i++;
            return false;
        });
    }
    function append_cost_name_chk(pro_id){
        $('.car_tr_chk'+pro_id).append(
            '<td>'
                +'<input id=cost_name_'+pro_id+' class="cost_name cost_name'+pro_id+'" name=cost_name['+pro_id+'] >'
            +'</td>'
            +'<td>'
                +'<input name=cost_money['+pro_id+'] id=cost_money_'+pro_id+' class="cost_money cost_money'+pro_id+'" onchange="calculate_cost('+pro_id+')" >'
            +'</td>'
            +'<td>'
                +'<textarea name=comment['+pro_id+'] id=comment_'+pro_id+' class="comment comment'+pro_id+'" rows=3 cols=20 ></textarea>'
            +'</td>'
            +'<td><a href=# class=del_car onclick="return deleteCarRow(this, '+pro_id+')" >X</a></td>'
        );
    }
    function append_outsource_chk(pro_id){
        $('.car_tr_chk'+pro_id).append(
            '<td>'
                +'<div class=part_outsource'+pro_id+'>'
                    +'<input id=outsource_input_'+pro_id+' class=outsource_input placeholder = "Nhập tên nhà cung cấp" >'
                    +'<table id=row_selected'+pro_id+' >'
                    +'</table>'
                +'</div>'
            +'</td>'
            +'<td>'
                +'<input name=cost_money['+pro_id+'] id=cost_money_'+pro_id+' class="cost_money cost_money'+pro_id+'" onchange="calculate_cost('+pro_id+')" >'
            +'</td>'
            +'<td>'
                +'<textarea name=comment['+pro_id+'] id=comment_'+pro_id+' class="comment comment'+pro_id+'" rows=3 cols=20 ></textarea>'
            +'</td>'
            +'<td><a href=# class=del_car onclick="return deleteCarRow(this, '+pro_id+')" >X</a></td>'
        );
    }
    function auto_complete(pro_id){
        $("#outsource_input_"+pro_id).autocomplete({
            source: '<?php echo site_url("sales/supplier_search_cost"); ?>',
            delay: 10,
            autoFocus: false,
            minLength: 0,
            select: function (event, ui){
                $("#outsource_input_"+pro_id).val("");
                if ($("#row_selected" + ui.item.value).length == 1){
                    $("#row_selected" + ui.item.value).val(parseFloat($("#row_selected" + ui.item.value).val()) + 1);
                }else{
                    $('#outsource_input_'+pro_id).hide();
                    $("#row_selected"+pro_id).append(
                        '<tr style="border: none">'
                        +'<td width="80%" style="border: none"><input type=hidden id=outsource'+pro_id+' name=outsource['+pro_id+'] value=' + ui.item.value + ' />' + ui.item.label + '</td>'
                        +'<td style="border: none"><a href=# style="text-decoration: underline" onclick="return deleteRow(this, '+pro_id+')">Xóa</a></td>'
                        +'</tr>'
                    );
                }
                return false;
            }
        });
    }
    function deleteRow(link, pro_id){
        $('#outsource_input_'+pro_id).show();
        $('.part_outsource'+pro_id).show();
        $(link).parent().parent().remove();
        return false;
    }
    function deleteBrandRow(link, pro_id){
        var count_tr_brand = $('#brand_table .brand_tr').length;
        if(count_tr_brand == 1){
            alert('Bạn không thể xóa hết công đoạn !');
            return false;
        }
        $(link).parent().parent().remove();
        $('#car_tr_'+pro_id).remove();
        $('#space_tr_'+pro_id).remove();
        calculate_cost(pro_id);
        return false;
    }
    function deleteCarRow(link, pro_id){
        var count_tr_car = $('#car_table_'+pro_id+' .car_tr').length;
        if(count_tr_car == 1){
            alert('Bạn không thể xóa hết chi phí của 1 công đoạn !');
            return false;
        }    
        $(link).parent().parent().remove();
        return false;
    }
    function calculate_cost(pro_id) {
        var sum_cost=0;
        $('.cost_money'+pro_id).each(function () {
            var a = $(this).val().replace(/,/g, "");
            sum_cost += +a;
        });
        $('#processes_money_'+pro_id).val((sum_cost+'').replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,"));//add ',' to show
       
        var sum_processes=0;
        $('.processes_money').each(function () {
            var a = $(this).val().replace(/,/g, "");
            sum_processes += +a;
        });
        $('.processes_money_total').val((sum_processes+'').replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,"));//add ',' to show
       
        var money_total = +$('.total_money_norms').val().replace(/,/g, "") + sum_processes;
        $('.money_total').val((money_total+'').replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,"));//add ',' to show    
    }    
    $('.submit_button').click(function () {
        var arr_id_processes = [];
        var arr_id_processes_none = [];
        var arr_time_processes = [];
        var arr_unit_time = [];
        var arr_cost_name = [];
        var arr_cost_money = [];
       
        $(".brand_tr").find('.pro_id').each(function (index, element) {
            var pro_id = $(element).attr('id').substring($(element).attr('id').lastIndexOf('_') + 1);
           
            if($('#id_processes_' + pro_id).val()){
                arr_id_processes.push(pro_id);
               
                if ( ! $('#time_processes_' + pro_id).val()
                    || $('#time_processes_' + pro_id).val() == 0) {
                    arr_time_processes.push(pro_id);
                }
                if ( ! $('#unit_time_' + pro_id).val()) {
                    arr_unit_time.push(pro_id);
                }
            }else{
                if( ! $('#id_processes_' + pro_id).val()){
                    arr_id_processes_none.push(pro_id);
                }
            }
            $(".car_tr").find('.cost_name').each(function (index, element) {
                var pro_id_i = $(element).attr('id').substring($(element).attr('id').lastIndexOf('_') + 1);  
               
                if ( ! $('#cost_name_' + pro_id_i).val() && ! $('#outsource'+pro_id).val() ) {
                    arr_cost_name.push(pro_id_i);
                }
                if ( ! $('#cost_money_' + pro_id_i).val()
                    || $('#cost_money_' + pro_id_i).val() == 0) {
                    arr_cost_money.push(pro_id_i);
                }            
            });
        });
        if (arr_id_processes.length < 1) {
            alert("Bạn chưa chọn công đoạn nào !");
            return false;
        }
        if (arr_id_processes_none.length > 0) {
            alert("Có công đoạn chưa thấy chọn !");
            return false;
        }
        if (arr_time_processes.length > 0) {
            alert("Công đoạn đã chọn chưa có thời gian !");
            return false;
        }
        if (arr_unit_time.length > 0) {
            alert("Công đoạn đã chọn chưa có đơn vị thời gian !");
            return false;
        }
        if (arr_cost_name.length > 0) {
            alert("Bạn chưa điền tên chi phí !");
            return false;
        }
        if (arr_cost_money.length > 0) {
            alert("Bạn chưa điền giá chi phí !");
            return false;
        }
    });
    //$('.cost_money').maskMoney();//ko onchange dc..........
    $('.processes_money').maskMoney();
    //only enter number
    $(".time_processes").keydown(function (e) {
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
          (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
          (e.keyCode >= 35 && e.keyCode <= 40)) {
            return;
        }
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });    
    $(".cost_money").keydown(function (e) {
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
          (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
          (e.keyCode >= 35 && e.keyCode <= 40)) {
            return;
        }
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
    </script>