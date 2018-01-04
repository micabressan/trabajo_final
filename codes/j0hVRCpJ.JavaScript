

function Node(name, fr, used, code, papa) {
    this.name = name;
    this.fr = fr;
    this.used = used;
    this.code = code;
    this.papa = papa;
};

var str = WScript.StdIn.ReadLine();

alph = new Array();
for (i = 0; i < str.length; i++)
    alph[str.charAt(i)] = 0
for (i = 0; i < str.length; i++)
    alph[str.charAt(i)]++

NodeList = new Array();
for (i in alph) {
    n = new Node(i, alph[i], "", 0, null);
    NodeList.push(n);
}

var counts = NodeList.length - 1;
var min1;
var min2;
for (var i = 0; i < counts; i++) {

    min1 = new Node("min1", 999999, false, 0, null);
    for (var j = 0; j < NodeList.length; j++)
        if (NodeList[j].used == false && NodeList[j].fr < min1.fr)
            min1 = NodeList[j];
    for (var j = 0; j < NodeList.length; j++)
        if (NodeList[j].name == min1.name) {
            min1 = j;
            NodeList[j].used = true;
        }

    min2 = new Node("min2", 999999, false, 0, null);
    for (var j = 0; j < NodeList.length; j++)
        if (NodeList[j].used == false && NodeList[j].fr < min2.fr)
            min2 = NodeList[j];
    for (var j = 0; j < NodeList.length; j++)
        if (NodeList[j].name == min2.name) {
            min2 = j;
            NodeList[j].used = true;
        }

    n = new Node(NodeList[min1].name + NodeList[min2].name, NodeList[min2].fr + NodeList[min2].fr, false, 0, null)
    NodeList[min1].code = 0;
    NodeList[min2].code = 1;
    NodeList[min1].papa = n.name;
    NodeList[min2].papa = n.name;
    NodeList.push(n);
}
result = new Array();
for (var n = 0; n < NodeList.length; ++n) {

    var papa = "";
    for (var i = 0; i < NodeList.length; ++i) {
        if (NodeList[i] != null && NodeList[i].papa == null) {
            if (NodeList[i].name.length == 1) {
                if (NodeList[i].code.length > 1)
                    NodeList[i].code = NodeList[i].code.substring(1);
                result[NodeList[i].name] = NodeList[i].code;
            }
            papa = NodeList[i];
            NodeList[i] = null;
            break;
        }
    }

    for (var i = 0; i < NodeList.length; ++i)
        if (NodeList[i] != null && NodeList[i].papa == papa.name) {
            NodeList[i].papa = null;
            if (papa.code != null)
                NodeList[i].code = papa.code.toString() + NodeList[i].code.toString();
        }

    for (var i = 0; i < NodeList.length; ++i)
        if (NodeList[i] != null && NodeList[i].papa == papa.name) {
            NodeList[i].papa = null;
            if (papa.code != null)
                NodeList[i].code = papa.code.toString() + NodeList[i].code.toString();
        }

}
for (i in alph) {
	WSH.echo( i +  " = "  + alph[i]);
}
WSH.echo("Code table:")
for (i in result) {
    WSH.echo(i, result[i]);
}

var codeOfStr = "";
for (var i = 0; i < str.length; ++i) {
    codeOfStr += result[str.charAt(i)];
}
WSH.echo("Code:")
WSH.echo(codeOfStr);

var tmpStr = "";
var resultStr = "";
for (var i = 0; i < codeOfStr.length; ++i) {
    tmpStr += codeOfStr.charAt(i);
    for (e in result)
        if (result[e] == tmpStr) {
            tmpStr = "";
            resultStr += e;
        }
}
WSH.echo("Decode:");
WSH.echo(resultStr);