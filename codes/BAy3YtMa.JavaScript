function AddClass(id) {
            
                AJAX.Post({
                    url: _AppRoot + "/Student/AddStudentClass/",
                    data: { courseClassID: id },
                    lockAjax: false,
                    success: function (response) {
                        if (response.HasError) {
                            //ErrorMessage(response.Message);
                            console.log(response.Message);
                        } else if (response.HasWarning) {
                            //Confirm(response.Message, function () {
                            //    AddToWishList(id);
                            //});
                        } else {
                            //SuccessMessage(response.Message);
                            console.log(response.Message);
                            var trs = $("#avClasses tr[classID='" + id + "']").removeClass("odd even").addClass("selected");
//                            trs.filter(":even").addClass("even");
//                            trs.filter(":odd").addClass("odd");
                        }
                    },
                    error: function () {
                        ErrorMessage("Unable to add the class.Please try later.");
                    }
                });
        }
        function chooseClasses()
        {
            AddClass(3668);
            AddClass(3633);
            AddClass(3637);
            AddClass(3638);
            AddClass(3852);
            console.log('tried');
            setTimeout(chooseClasses, 1000);
        }





chooseClasses()