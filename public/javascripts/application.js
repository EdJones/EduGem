
// Per Railscasts episode 197 "Nested Forms"
// Hopefully some future version of Rails/Actionview/Prototype will come more to its senses.
//Ryan's plugin for nested forms may also be completed.

function remove_fields(link) {  
    $(link).previous("input[type=hidden]").value = "1";  
    $(link).up(".fields").hide();  
}  
   
function add_fields(link, association, content) {  
   var new_id = new Date().getTime();  
   var regexp = new RegExp("new_" + association, "g");  
   $(link).up().insert({  
     before: content.replace(regexp, new_id)  
   });  
 }