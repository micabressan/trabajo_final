arrangementDivsInPlace();


$('#plus').click(function () {
    var div = addNewDraggDiv();
    div.childNodes[0].focus();
})

$('#draggElements').on('mousedown', 'div', function(e) {
    var obj = this;
    var inputIndex = $(this).index();
    obj.childNodes[0].style.cursor = 'move';

    xInDiv = e.offsetX==undefined?e.layerX:e.offsetX;
    yInDiv = e.offsetY==undefined?e.layerY:e.offsetY;
    dragObj = obj;

    document.onmousemove = function(e){
        var x = e.pageX;
        var y = e.pageY;

        if(dragObj == null){
            return;
        }

        x = x - xInDiv +"px";
        y = y - yInDiv +"px";
        
        $(dragObj).css('left', x);
        $(dragObj).css('top', y);

    };

    document.onmouseup = function(e){
        obj.childNodes[0].style.cursor = 'text';
        dragObj = null;
        savePosition(e.pageX - xInDiv +"px", e.pageY - yInDiv +"px", inputIndex);
    };

});

$('#draggElements').on('keydown', 'input', function(e){
    var inputIndex = $(this).parent().index();
    console.log(this);
    this.size = (this.value.length - this.value.length / 5) || 1;
    if(e.keyCode==13){
        var width = this.value.length || 1;
        var x = $(this).parent().css('left');
        var y = $(this).parent().css('top'); 
        savePositionAndValueAndWidth(inputIndex, this, x, y, width);
        this.blur();
    }

   else if(e.keyCode==27){
        this.blur();
    }
});


function savePositionAndValueAndWidth(inputIndex, input, x, y, width){
    var value = input.value;
    $.ajax({
        method: "POST",
        url: "server/server.php",
        data: ({TypeOfWork:0, input:inputIndex, value:value, x:x, y:y, width:width}),
    });
}

function savePosition(x, y, inputIndex) {
    $.ajax({
        method: "POST",
        url: "server/server.php",
        data: ({TypeOfWork:1, input:inputIndex, x:x, y:y}),
    });
}

function addNewDraggDiv (){
    var div = document.createElement('div');
    var draggElements =  document.getElementById('draggElements');
    div.setAttribute('class', 'draggElemem');
    draggElements.appendChild(div); 
    div.innerHTML = '<input class="input"></input>';
    
    return div;        
}

function arrangementDivsInPlace () {
    $.ajax({
        method: "POST",
        url: "server/getPosition.php",
        dataType: 'json',
        success: function (data) {
            console.log(data);
            for (var i = 0; i < data.length; i++) {
                var div = addNewDraggDiv();
                var child = div.childNodes[0];
                
                setСharacteristics(i, div, child, data);   
            }
        }
    });
}


function setСharacteristics(i, div, child, data){
    $(div).css('left', data[i]['x']);
    $(div).css('top', data[i]['y']);
    $(child).val(data[i]['value']);
    child.size = data[i]['value'].length;
}