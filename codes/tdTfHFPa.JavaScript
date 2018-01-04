      var models;
      $.when(me.api.getModels()).then(function( data, textStatus, jqXHR ) {
        console.log(data); //(5) [Object, Object, Object, Object, Object]
        models = data;
      });
      console.log(models); //undefined