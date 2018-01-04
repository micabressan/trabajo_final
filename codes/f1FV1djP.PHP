
	   
	   <?php if(!osc_is_home_page()){ echo '<div class="resp-wrapper">'; } ?>
	   
         <?php
         //cell_3
        $total_categories   = osc_count_categories();
        $col1_max_cat       = ceil($total_categories/3);

         osc_goto_first_category();
         $i      = 0;

         while ( osc_has_categories() ) {
         ?>
		 				
					
        <?php
            if($i%$col1_max_cat == 0){
                if($i > 0) { echo '</div>'; }
                if($i == 0) {
                   echo '<div class="cell_3 first_cel">';
                } else {
                    echo '<div class="cell_3">';
                }
            }
        ?>
		
		
        <ul class="r-list">
             <li>
                 <h1>
                    <?php
                    $_slug      = osc_category_slug();
                    $_url       = osc_search_category_url();
                    $_name      = osc_category_name();
                    $_total_items = osc_category_total_items();
                    if ( osc_count_subcategories() > 0 ) { ?>
                    <span class="collapse resp-toogle"><i class="fa fa-caret-right fa-lg"></i></span>
                    <?php } ?>
                    <?php if($_total_items > 0) { ?>
                    <a class="category <?php echo $_slug; ?>" href="<?php echo $_url; ?>"><?php echo $_name ; ?></a> <span>(<?php echo $_total_items ; ?>)</span>
                    <?php } else { ?>
                    <a class="category <?php echo $_slug; ?>" href="#"><?php echo $_name ; ?></a> <span>(<?php echo $_total_items ; ?>)</span>
                    <?php } ?>
                 </h1>
				 
				 
				 
                 <?php if ( osc_count_subcategories() > 0 ) { ?>
                   <ul>
                         <?php while ( osc_has_subcategories() ) { ?>
                             <li>
                             <?php if( osc_category_total_items() > 0 ) { ?>
                                 <a class="category sub-category <?php echo osc_category_slug() ; ?>" href="<?php echo osc_search_category_url() ; ?>"><?php echo osc_category_name() ; ?></a> <span>(<?php echo osc_category_total_items() ; ?>)</span>
                             <?php } else { ?>
                                 <a class="category sub-category <?php echo osc_category_slug() ; ?>" href="#"><?php echo osc_category_name() ; ?></a> <span>(<?php echo osc_category_total_items() ; ?>)</span>
                             <?php } ?>
                             </li>
                         <?php } ?>
                   </ul>
                 <?php } ?>
             </li>
        </ul>
        <?php
                $i++;
            }
            echo '</div>';
        ?>
        <?php if(!osc_is_home_page()){ echo '</div>'; } ?>