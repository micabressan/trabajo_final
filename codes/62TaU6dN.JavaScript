 var usersList = ["Roma", "Vlad", "Igor", "Anton", "Ignat", "Salavat"];

    //Улучшите этот код с помощью цика
    for(var i = 0; i < usersList.length; i++){
        drawName(usersList[i]);
    }
    //

    function drawName(name){
    var nameContainer = document.createElement("div");
    nameContainer.innerText = name;
    nameContainer.style.border = "solid";
    nameContainer.style.borderWidth = "2px";
    nameContainer.style.padding = "15px";
    document.body.appendChild(nameContainer);
    }