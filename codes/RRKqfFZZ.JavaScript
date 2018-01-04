var usersList = ["Roma", "Vlad", "Igor", "Anton", "Ignat", "Salavat"];

//Улучшите этот код с помощью цика
drawName(usersList[0]);
drawName(usersList[1]);
drawName(usersList[2]);
drawName(usersList[3]);
drawName(usersList[4]);
drawName(usersList[5]);
//

function drawName(name){
    var nameContainer = document.createElement("div");
    nameContainer.innerText = name;
    nameContainer.style.border = "solid";
    nameContainer.style.borderWidth = "2px";
    nameContainer.style.padding = "15px";
    document.body.appendChild(nameContainer);
}