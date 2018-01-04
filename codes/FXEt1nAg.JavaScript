var content = tinyMCE.activeEditor.getContent({format: 'text'});
var regular_expression = /{{([^\)])}}/g;
var matches = content.match(reg);