var element=document.getElementById('article_right').outerHTML;
var data={element:element};
var json=JSON.stringify(data);
var szpitale=json.split('<p>');
//console.log(szpitale);
var ready='{';
var reg=/Szpital /g;
for(var elem in szpitale){
    if(szpitale[elem].match(reg)){
        let szpital=szpitale[elem].split('<br>');
            if(elem!=szpitale.length-1){
            ready=ready.concat('"szpital'+elem+'":{"nazwa":"'+szpital[0]+'","adres":"'+szpital[1]+'","miasto":"'+szpital[2]+'"},');
            }else{
            ready=ready.concat('"szpital'+elem+'":{"nazwa":"'+szpital[0]+'","adres":"'+szpital[1]+'","miasto":"'+szpital[2]+'"}');
            }
    }
}
ready=ready.concat('}');
//var szpitale_json=JSON.parse(ready);
console.log(ready);