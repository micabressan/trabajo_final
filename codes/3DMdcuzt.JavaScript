 $.ajax({ 
                type: 'POST', 
                url: '../pages/logout.php',
                
                success: function (data) { 
                    var result = JSON.parse(data);
                    
					console.log(JSON.stringify(result.success));


					if(JSON.stringify(result.success)==1){
						//something
					}
					else{
						//something
					}
                    //do html update here
                }
            });