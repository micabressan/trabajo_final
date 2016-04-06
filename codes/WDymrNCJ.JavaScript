// Choose Dimension's

serviceMaster.applyChartPercentOptions = function() {  
    var cd = this.chartDefinition;
    
    cd.dimensions = {
        value:     {
            format: {
                number: {
                    mask: '0.0%;0;0;"N/A"',
                    style: {
                        decimal: ".",
                        group:   ","
                    }
                }
            }
        }
    };
    
    cd.orthoAxisLabel_text= function(scene){
        var newValue = scene.getTickLabel();
        return (newValue * 100)+"%";
    };
                                         
    var defaults = { 
       
    };
  
    var ep = cd.extensionPoints || [];
    var objEp = Dashboards.propertiesArrayToObject(ep);
    objEp = $.extend({},objEp,defaults);
    cd.extensionPoints = Dashboards.objectToPropertiesArray(objEp);    
};

serviceMaster.applyChartQuantityAdminOptions = function() {  
    var cd = this.chartDefinition;
    
    cd.dimensions = {
        value:     {
            format: {
                number: {
                    mask: '0.0;-0.0;0;"N/A"',
                    style: {
                        decimal: ".",
                        group:   ","
                    }
                }
            }
        }
    };
    
    cd.orthoAxisLabel_text= function(scene){
        var newValue = scene.getTickLabel();
        return newValue;
    };
                                         
    var defaults = { 
       
    };
  
    var ep = cd.extensionPoints || [];
    var objEp = Dashboards.propertiesArrayToObject(ep);
    objEp = $.extend({},objEp,defaults);
    cd.extensionPoints = Dashboards.objectToPropertiesArray(objEp);    
};

serviceMaster.applyChartQuantityOptions = function() {  
    var cd = this.chartDefinition;
    
    cd.dimensions = {
        value:     {
            format: {
                number: {
                    mask: '0,0;-0,0;0;"N/A"',
                    style: {
                        decimal: ".",
                        group:   ","
                    }
                }
            }
        }
    };
    
    cd.orthoAxisLabel_text= function(scene){
        var newValue = scene.getTickLabel();
        return newValue; 
    };
                                         
    var defaults = { 
       
    };
  
    var ep = cd.extensionPoints || [];
    var objEp = Dashboards.propertiesArrayToObject(ep);
    objEp = $.extend({},objEp,defaults);
    cd.extensionPoints = Dashboards.objectToPropertiesArray(objEp);    
};