/*! shinyStorePlus v0.8 | (c) Written by Obi Obianom, www.obianom.com | all rights reserved */
function initialize(t){let n="app"+hashCode(t.appname),e=new Dexie(n);e.version(1).stores({shinyStoresPlus:"++id,app,var,type,value,created"}),retrieveAllInputs(n,e).then(function(t){t.length&&returnValues(t)}),"boolean"==typeof t.input&&t.input&&initializeAllInputs(n,e),"object"==typeof t.input&&t.input.length&&initializeAllInputs(n,e,t.input),"boolean"==typeof t.output&&t.output&&initializeAllOutputs(n,e)}function initializeAllOutputs(l,s,p=null){$.each([".shiny-text-output.shiny-bound-output"],function(t,o){$(o).each(function(t,n){let e=0,i=this,u=$(i).attr("id"),a=$(i).html();$(i).on("DOMSubtreeModified",function(){a=$(i).html(),getInputById(l,u,o,s).then(function(t){null!=t&&(e=t.id),0==e?setInputById(l,u,o,a,p,s):updateInputById(l,u,o,a,e,p,s)})})})})}function initializeAllInputs(s,p,c=null){$.each(["input.shiny-bound-input","textarea.shiny-bound-input","select.shiny-bound-input"],function(t,l){$(l).each(function(t,n){let e=0,i=l,u=this,a=$(u).attr("id");null==a&&console.log($(u).attr("name")+"is undefined.");let o=$(u).val();$(u).change(function(){o="checkbox"==$(u).attr("type")?(l="checkbox.shiny-bound-input",$(u).is(":checked")):(l=i,$(u).val()),getInputById(s,a,l,p).then(function(t){null!=t&&(e=t.id),0==e?setInputById(s,a,l,o,c,p):updateInputById(s,a,l,o,e,c,p)})}),$(u).keyup(function(){l=i,o=$(u).val(),getInputById(s,a,l,p).then(function(t){null!=t&&(e=t.id),0==e?setInputById(s,a,l,o,c,p):updateInputById(s,a,l,o,e,c,p)})})})});let l=[],d=[];$.each(["div.shiny-bound-input:has(div.shiny-options-group)","div.shiny-bound-input:has(input[type='text'])"],function(t,o){$(o).each(function(n,t){let i=0,u=$(this).attr("id"),a=$(this).val();$(this).find('input[type="radio"]').change(function(){o="radio.shiny-bound-input",a=$(this).val(),getInputById(s,u,o,p).then(function(t){null!=t&&(i=t.id),0==i?setInputById(s,u,o,a,c,p):updateInputById(s,u,o,a,i,c,p)})}),l[n]=[],$(this).find('input[type="checkbox"]').each(function(t,n){o="checkboxgroup.shiny-bound-input",a=$(this).val();var e=$(this).attr("name");$(this).change(function(){a=[],document.getElementsByName(e).forEach(t=>{t.checked?a.push(t.value):a=removeItemOnce(a,t.value),a=[...new Set(a)]}),getInputById(s,u,o,p).then(function(t){null!=t&&(i=t.id),0==i?setInputById(s,u,o,a,c,p):updateInputById(s,u,o,a,i,c,p)})})});let e=$(this).find('input[type="text"]');1==e.length&&e.change(function(){o="dateinput.shiny-bound-input",a=$(this).val(),getInputById(s,u,o,p).then(function(t){null!=t&&(i=t.id),0==i?setInputById(s,u,o,a,c,p):updateInputById(s,u,o,a,i,c,p)})}),d[n]=[],2==e.length&&e.each(function(){o="dateinputrange.shiny-bound-input",$(this).change(function(){d[n]=[e.first().val(),e.first().next().next().val()],getInputById(s,u,o,p).then(function(t){null!=t&&(i=t.id),0==i?setInputById(s,u,o,d[n],c,p):updateInputById(s,u,o,d[n],i,c,p)})})})})})}function removeItemOnce(t,n){n=t.indexOf(n);return-1<n&&t.splice(n,1),t}function replaceNonAlphanumeric(t){return t.replace(/[^A-Za-z0-9]/g,"")}function timeIntVal(){return Math.floor(Date.now())}function hashCode(t){let n=0;if(0==t.length)return n;for(i=0;i<t.length;i++)n=(n<<5)-n+(ch=t.charCodeAt(i)),n&=n;return n}function retrieveAllInputs(t,n){return n.shinyStoresPlus.where({app:t}).toArray()}function getInputById(t,n,e,i){let u=i.shinyStoresPlus.where({app:t,var:n});return u.toArray().then(function(t){1<t.length&&i.shinyStoresPlus.delete(t[1].id)}),u.first()}function setInputById(t,n,e,i,u,a){let o=!1;null!=u&&!u.includes(n)||(o=!0),o&&a.shinyStoresPlus.add({app:t,var:n,type:e,value:i,created:timeIntVal()}).catch(function(t){console.error("Unable to update the input:"+t.stack)})}function updateInputById(t,n,e,i,u,a,o){let l=!1;null!=a&&!a.includes(n)||(l=!0),l&&o.shinyStoresPlus.update(u,{app:t,var:n,value:i,created:timeIntVal()})}function clearDatabase(t){console.log("Clearing storage for "+t+"..."),new Dexie(t).delete()}function sendWarning(t){Shiny.setInputValue("transmittedWarningx0x0ssp",JSON.stringify(t))}function returnValues(t){Shiny.setInputValue("transmittedDatax0x",JSON.stringify(t))}Shiny.addCustomMessageHandler("retriever",function(t){void 0!==t&&initialize(t)}),Shiny.addCustomMessageHandler("clearStorage",function(t){clearDatabase("app"+hashCode(t))}),$(document).on("shiny:connected",function(t){const n=new URL(window.location.href);var e={};n.searchParams.forEach(function(t,n){e[n]=t}),Shiny.setInputValue("sSP1locationParams",JSON.stringify(e))});
