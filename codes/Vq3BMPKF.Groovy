def out = ''
boolean isVendorAssigned = true
unwrappedThis.each{
    project -> 
        project.getActivities().each{
            job ->
                if(!job.getProvider()){
                    isVendorAssigned = false
                } 
            }
}

if(isVendorAssigned){
    out = "Yes"
} else out = "No"