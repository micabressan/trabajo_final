// GLOBALS DECLARATION //////////////////////////////////////////////////////////////////
global string $JDcamera[];

global proc JDcheckCam()
{
	if(size(`ls -sl`) != 1 || objectType(listRelatives(`ls -sl -tr`))!="camera"){
		confirmDialog
		    -title "WARNING"
		    -message "No valid selection detected!\nPlease select camera FIRST."
		    -messageAlign "center"
		    -button "OK"
		    -defaultButton "OK"
		    -cancelButton "OK"
		    -dismissString "OK";
		error "You must select a camera FIRST, then objects.";
	}else{
	    $JDcamera = `ls -sl`;
	}
};


proc JDbakeCam(string $parent)
{
    // create camera at same position and constrain parent it
    string $cam[] = `camera -n "BAKEDcam"`;
    parentConstraint $cam[0] $parent;
    //doCreateParentConstraintArgList 1 { "0","0","0","0","0","0","0","1","","0" };
    //parentConstraint -weight 1;
};


////////////////////////////////////////////////////////////////////////////////////////


// EXECUTION //////////////////////////////////////////////////////////////////
// 1- check camera+objects are selected
JDcheckCam;

// 2- prompt for saving current state
string $really = `confirmDialog -title "Saving" -message "Do you want to save current state?\n"
    -button "Yes" -button "No" -defaultButton "No"
    -cancelButton "No" -dismissString "No"`;
if($really=="Yes"){
    SaveSceneAs;
}
else if($really=="No"){
    warning "Backup NOT saved.";
}
// 3- prompt for creating nulls
string $really = `confirmDialog -title "Nulls" -message "Do you want to generate nulls at the position of the selected objects?\n"
    -button "Yes" -button "No" -defaultButton "No"
    -cancelButton "No"`;
if($really=="No"){
    JDbakeCam($JDcamera[0]);
//  $cleanScene
    warning "ONLY Baking and exporting the camera";
//  $exportSelect
//  $promptReload
}
else if($really=="Yes"){
    warning "No objects selected. A null will be created at the world center position.";
//  $worldNull
}