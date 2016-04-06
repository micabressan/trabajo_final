<?php
namespace app\forms;

use php\gui\framework\AbstractForm;
use php\gui\event\UXWindowEvent;
use php\gui\event\UXMouseEvent;


class MainForm extends AbstractForm
{

	/**
	 * @event show 
	 **/
	function doShow(UXWindowEvent $event)
	{	
        
        foreach ($this->children as $obj) {
            
          if ( $obj instanceof  UXToggleButton) { 
            
            $obj->on('click', function() use ($obj) {	  
            
                 pre($obj->id);

            });

          }

        }
          
	}

}