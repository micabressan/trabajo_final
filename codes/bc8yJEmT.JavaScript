//This code assumes Danbooru JSON API's posts.json result is in a pre tag in the documents body.
//(This is the case if you open the API result directly in Firefox and run the code below in the web console)

//parse the data:
var array = JSON.parse(document.getElementsByTagName("pre")[0].textContent);
var uploaders = {};    //If you want to analyze e.g. a whole day you have to analyze several pages of results; therefore to add the values of page(n) to the previous page's results initialize this with the output from page(n-1).
for (var i = 0; i < array.length; i++) {
if (uploaders[array[i].uploader_name]) {
uploaders[array[i].uploader_name].count++;
} else {
uploaders[array[i].uploader_name] = {};
uploaders[array[i].uploader_name].id = array[i].uploader_id;
uploaders[array[i].uploader_name].count = 1;
}
}
console.log(JSON.stringify(uploaders)); //This is the output mentioned above

//number of posts:
var uploaders_keys = Object.keys(uploaders);
var posts = 0;
for (var i = 0; i < uploaders_keys.length; i++) {
posts += uploaders[uploaders_keys[i]].count;
}
console.log("Posts:" + posts);

//number of uploaders:
console.log("Uploaders:" + Object.keys(uploaders).length);

//sort into categories:
var uploaders_keys = Object.keys(uploaders);
var categories = {"1":0,"2-5":0,"6-10":0,"11-20":0,"21-30":0,"31-40":0,"41-50":0, "51+":0};
for (var i = 0; i < uploaders_keys.length; i++) {
if (uploaders[uploaders_keys[i]].count < 2) {
categories["1"]++;
} else if (uploaders[uploaders_keys[i]].count < 6) {
categories["2-5"]++;
} else if (uploaders[uploaders_keys[i]].count < 11) {
categories["6-10"]++;
} else if (uploaders[uploaders_keys[i]].count < 21) {
categories["11-20"]++;
} else if (uploaders[uploaders_keys[i]].count < 31) {
categories["21-30"]++;
} else if (uploaders[uploaders_keys[i]].count < 41) {
categories["31-40"]++;
} else if (uploaders[uploaders_keys[i]].count < 51) {
categories["41-50"]++;
} else {
categories["51+"]++;
}}
console.log(categories);

//pretty print for Danbooru forum:
var categories_keys = Object.keys(categories);
var string = "";
for (var i = 0; i < categories_keys.length; i++) {
string += "\[b\]" + categories[categories_keys[i]] + " user(s)\[\/b\] with \[b\]" + categories_keys[i] + " uploads\[\/b\].\n";
}
console.log(string)