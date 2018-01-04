export const data_activities = new webix.DataCollection({
	url: "http://localhost:8096/api/v1/activities/",
	save: "rest->http://localhost:8096/api/v1/activities/",
	scheme:{

        $init:function(obj){
            if(obj.DueDate)
               obj.DueDate = webix.i18n.parseFormatDate(obj.DueDate);
        },
        $save:function(obj){
            if(obj.DueDate)
                obj.DueDate = webix.i18n.parseFormatStr(obj.DueDate);
        }
    }
});