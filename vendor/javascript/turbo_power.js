var e=11;function morphAttrs(t,r){var o=r.attributes;var s;var i;var n;var a;var c;if(r.nodeType!==e&&t.nodeType!==e){for(var l=o.length-1;l>=0;l--){s=o[l];i=s.name;n=s.namespaceURI;a=s.value;if(n){i=s.localName||i;c=t.getAttributeNS(n,i);if(c!==a){s.prefix==="xmlns"&&(i=s.name);t.setAttributeNS(n,i,a)}}else{c=t.getAttribute(i);c!==a&&t.setAttribute(i,a)}}var u=t.attributes;for(var d=u.length-1;d>=0;d--){s=u[d];i=s.name;n=s.namespaceURI;if(n){i=s.localName||i;r.hasAttributeNS(n,i)||t.removeAttributeNS(n,i)}else r.hasAttribute(i)||t.removeAttribute(i)}}}var t;var r="http://www.w3.org/1999/xhtml";var o=typeof document==="undefined"?void 0:document;var s=!!o&&"content"in o.createElement("template");var i=!!o&&o.createRange&&"createContextualFragment"in o.createRange();function createFragmentFromTemplate(e){var t=o.createElement("template");t.innerHTML=e;return t.content.childNodes[0]}function createFragmentFromRange(e){if(!t){t=o.createRange();t.selectNode(o.body)}var r=t.createContextualFragment(e);return r.childNodes[0]}function createFragmentFromWrap(e){var t=o.createElement("body");t.innerHTML=e;return t.childNodes[0]}
/**
 * This is about the same
 * var html = new DOMParser().parseFromString(str, 'text/html');
 * return html.body.firstChild;
 *
 * @method toElement
 * @param {String} str
 */function toElement(e){e=e.trim();return s?createFragmentFromTemplate(e):i?createFragmentFromRange(e):createFragmentFromWrap(e)}
/**
 * Returns true if two node's names are the same.
 *
 * NOTE: We don't bother checking `namespaceURI` because you will never find two HTML elements with the same
 *       nodeName and different namespace URIs.
 *
 * @param {Element} a
 * @param {Element} b The target element
 * @return {boolean}
 */function compareNodeNames(e,t){var r=e.nodeName;var o=t.nodeName;var s,i;if(r===o)return true;s=r.charCodeAt(0);i=o.charCodeAt(0);return s<=90&&i>=97?r===o.toUpperCase():i<=90&&s>=97&&o===r.toUpperCase()}
/**
 * Create an element, optionally with a known namespace URI.
 *
 * @param {string} name the element name, e.g. 'div' or 'svg'
 * @param {string} [namespaceURI] the element's namespace URI, i.e. the value of
 * its `xmlns` attribute or its inferred namespace.
 *
 * @return {Element}
 */function createElementNS(e,t){return t&&t!==r?o.createElementNS(t,e):o.createElement(e)}function moveChildren(e,t){var r=e.firstChild;while(r){var o=r.nextSibling;t.appendChild(r);r=o}return t}function syncBooleanAttrProp(e,t,r){if(e[r]!==t[r]){e[r]=t[r];e[r]?e.setAttribute(r,""):e.removeAttribute(r)}}var n={OPTION:function(e,t){var r=e.parentNode;if(r){var o=r.nodeName.toUpperCase();if(o==="OPTGROUP"){r=r.parentNode;o=r&&r.nodeName.toUpperCase()}if(o==="SELECT"&&!r.hasAttribute("multiple")){if(e.hasAttribute("selected")&&!t.selected){e.setAttribute("selected","selected");e.removeAttribute("selected")}r.selectedIndex=-1}}syncBooleanAttrProp(e,t,"selected")},INPUT:function(e,t){syncBooleanAttrProp(e,t,"checked");syncBooleanAttrProp(e,t,"disabled");e.value!==t.value&&(e.value=t.value);t.hasAttribute("value")||e.removeAttribute("value")},TEXTAREA:function(e,t){var r=t.value;e.value!==r&&(e.value=r);var o=e.firstChild;if(o){var s=o.nodeValue;if(s==r||!r&&s==e.placeholder)return;o.nodeValue=r}},SELECT:function(e,t){if(!t.hasAttribute("multiple")){var r=-1;var o=0;var s=e.firstChild;var i;var n;while(s){n=s.nodeName&&s.nodeName.toUpperCase();if(n==="OPTGROUP"){i=s;s=i.firstChild}else{if(n==="OPTION"){if(s.hasAttribute("selected")){r=o;break}o++}s=s.nextSibling;if(!s&&i){s=i.nextSibling;i=null}}}e.selectedIndex=r}}};var a=1;var c=11;var l=3;var u=8;function noop(){}function defaultGetNodeKey(e){if(e)return e.getAttribute&&e.getAttribute("id")||e.id}function morphdomFactory(e){return function morphdom(t,r,s){s||(s={});if(typeof r==="string")if(t.nodeName==="#document"||t.nodeName==="HTML"||t.nodeName==="BODY"){var i=r;r=o.createElement("html");r.innerHTML=i}else r=toElement(r);else r.nodeType===c&&(r=r.firstElementChild);var d=s.getNodeKey||defaultGetNodeKey;var _=s.onBeforeNodeAdded||noop;var m=s.onNodeAdded||noop;var f=s.onBeforeElUpdated||noop;var h=s.onElUpdated||noop;var g=s.onBeforeNodeDiscarded||noop;var b=s.onNodeDiscarded||noop;var p=s.onBeforeElChildrenUpdated||noop;var v=s.skipFromChildren||noop;var A=s.addChild||function(e,t){return e.appendChild(t)};var w=s.childrenOnly===true;var E=Object.create(null);var T=[];function addKeyedRemoval(e){T.push(e)}function walkDiscardedChildNodes(e,t){if(e.nodeType===a){var r=e.firstChild;while(r){var o=void 0;if(t&&(o=d(r)))addKeyedRemoval(o);else{b(r);r.firstChild&&walkDiscardedChildNodes(r,t)}r=r.nextSibling}}}
/**
    * Removes a DOM node out of the original DOM
    *
    * @param  {Node} node The node to remove
    * @param  {Node} parentNode The nodes parent
    * @param  {Boolean} skipKeyedNodes If true then elements with keys will be skipped and not discarded.
    * @return {undefined}
    */function removeNode(e,t,r){if(g(e)!==false){t&&t.removeChild(e);b(e);walkDiscardedChildNodes(e,r)}}function indexTree(e){if(e.nodeType===a||e.nodeType===c){var t=e.firstChild;while(t){var r=d(t);r&&(E[r]=t);indexTree(t);t=t.nextSibling}}}indexTree(t);function handleNodeAdded(e){m(e);var t=e.firstChild;while(t){var r=t.nextSibling;var o=d(t);if(o){var s=E[o];if(s&&compareNodeNames(t,s)){t.parentNode.replaceChild(s,t);morphEl(s,t)}else handleNodeAdded(t)}else handleNodeAdded(t);t=r}}function cleanupFromEl(e,t,r){while(t){var o=t.nextSibling;(r=d(t))?addKeyedRemoval(r):removeNode(t,e,true);t=o}}function morphEl(t,r,o){var s=d(r);s&&delete E[s];if(!o){if(f(t,r)===false)return;e(t,r);h(t);if(p(t,r)===false)return}t.nodeName!=="TEXTAREA"?morphChildren(t,r):n.TEXTAREA(t,r)}function morphChildren(e,t){var r=v(e);var s=t.firstChild;var i=e.firstChild;var c;var m;var f;var h;var g;e:while(s){h=s.nextSibling;c=d(s);while(!r&&i){f=i.nextSibling;if(s.isSameNode&&s.isSameNode(i)){s=h;i=f;continue e}m=d(i);var b=i.nodeType;var p=void 0;if(b===s.nodeType)if(b===a){if(c){if(c!==m)if(g=E[c])if(f===g)p=false;else{e.insertBefore(g,i);m?addKeyedRemoval(m):removeNode(i,e,true);i=g}else p=false}else m&&(p=false);p=p!==false&&compareNodeNames(i,s);p&&morphEl(i,s)}else if(b===l||b==u){p=true;i.nodeValue!==s.nodeValue&&(i.nodeValue=s.nodeValue)}if(p){s=h;i=f;continue e}m?addKeyedRemoval(m):removeNode(i,e,true);i=f}if(c&&(g=E[c])&&compareNodeNames(g,s)){A(e,g);morphEl(g,s)}else{var w=_(s);if(w!==false){w&&(s=w);s.actualize&&(s=s.actualize(e.ownerDocument||o));A(e,s);handleNodeAdded(s)}}s=h;i=f}cleanupFromEl(e,i,m);var T=n[e.nodeName];T&&T(e,t)}var y=t;var N=y.nodeType;var S=r.nodeType;if(!w)if(N===a)if(S===a){if(!compareNodeNames(t,r)){b(t);y=moveChildren(t,createElementNS(r.nodeName,r.namespaceURI))}}else y=r;else if(N===l||N===u){if(S===N){y.nodeValue!==r.nodeValue&&(y.nodeValue=r.nodeValue);return y}y=r}if(y===r)b(t);else{if(r.isSameNode&&r.isSameNode(y))return;morphEl(y,r,w);if(T)for(var C=0,k=T.length;C<k;C++){var x=E[T[C]];x&&removeNode(x,x.parentNode,false)}}if(!w&&y!==t&&t.parentNode){y.actualize&&(y=y.actualize(t.ownerDocument||o));t.parentNode.replaceChild(y,t)}return y}}var d=morphdomFactory(morphAttrs);function morph(){const e={childrenOnly:this.hasAttribute("children-only")};this.targetElements.forEach((t=>{d(t,e.childrenOnly?this.templateContent:this.templateElement.innerHTML,e)}))}const initialize$1=e=>{e.morph=morph};function camelize(e){return e.replace(/(?:[_-])([a-z0-9])/g,((e,t)=>t.toUpperCase()))}function capitalize(e){return e.charAt(0).toUpperCase()+e.slice(1)}function dasherize(e){return e.replace(/([A-Z])/g,((e,t)=>`-${t.toLowerCase()}`))}function tokenize(e){return e&&e.match(/[^\s]+/g)||[]}function typecast(e){try{return JSON.parse(e)}catch(t){return e}}var _=Object.freeze({__proto__:null,camelize:camelize,capitalize:capitalize,dasherize:dasherize,tokenize:tokenize,typecast:typecast});function add_css_class(){const e=tokenize(this.getAttribute("classes"));e.length>0?this.targetElements.forEach((t=>t.classList.add(...e))):console.warn('[TurboPower] no "classes" provided for Turbo Streams operation "add_css_class"')}function remove_attribute(){const e=this.getAttribute("attribute");e?this.targetElements.forEach((t=>t.removeAttribute(e))):console.warn('[TurboPower] no "attribute" provided for Turbo Streams operation "remove_attribute"')}function remove_css_class(){const e=tokenize(this.getAttribute("classes"));e.length>0?this.targetElements.forEach((t=>t.classList.remove(...e))):console.warn('[TurboPower] no "classes" provided for Turbo Streams operation "remove_css_class"')}function set_attribute(){const e=this.getAttribute("attribute");const t=this.getAttribute("value")||"";e?this.targetElements.forEach((r=>r.setAttribute(e,t))):console.warn('[TurboPower] no "attribute" provided for Turbo Streams operation "set_attribute"')}function set_dataset_attribute(){const e=this.getAttribute("attribute");const t=this.getAttribute("value")||"";e?this.targetElements.forEach((r=>r.dataset[camelize(e)]=t)):console.warn('[TurboPower] no "attribute" provided for Turbo Streams operation "set_dataset_attribute"')}function set_property(){const e=this.getAttribute("name");const t=typecast(this.getAttribute("value")||"");e?this.targetElements.forEach((r=>r[e]=t)):console.error('[TurboPower] no "name" provided for Turbo Streams operation "set_property"')}function set_style(){const e=this.getAttribute("name");const t=this.getAttribute("value")||"";e?this.targetElements.forEach((r=>r.style[e]=t)):console.error('[TurboPower] no "name" provided for Turbo Streams operation "set_style"')}function set_styles(){const e=this.getAttribute("styles")||"";this.targetElements.forEach((t=>t.setAttribute("style",e)))}function set_value(){const e=this.getAttribute("value")||"";this.targetElements.forEach((t=>t.value=e))}function toggle_css_class(){const e=tokenize(this.getAttribute("classes"));e.length>0?this.targetElements.forEach((t=>{e.forEach((e=>t.classList.toggle(e)))})):console.warn('[TurboPower] no "classes" provided for Turbo Streams operation "toggle_css_class"')}function replace_css_class(){const e=this.getAttribute("from")||"";const t=this.getAttribute("to")||"";e&&t?this.targetElements.forEach((r=>{const o=r.classList.replace(e,t);o||console.warn(`[TurboPower] The "${e}" CSS class provided in the "from" attribute for the "replace_css_class" action was not found on the target element. No replacements made.`,r)})):console.warn('[TurboPower] no "from" or "to" class provided for Turbo Streams operation "replace_css_class"')}function registerAttributesActions(e){e.add_css_class=add_css_class;e.remove_css_class=remove_css_class;e.remove_attribute=remove_attribute;e.set_attribute=set_attribute;e.set_dataset_attribute=set_dataset_attribute;e.set_property=set_property;e.set_style=set_style;e.set_styles=set_styles;e.set_value=set_value;e.toggle_css_class=toggle_css_class;e.replace_css_class=replace_css_class}function reload(){window.location.reload()}function scroll_into_view(){const e=this.getAttribute("align-to-top");const t=this.getAttribute("block");const r=this.getAttribute("inline");const o=this.getAttribute("behavior");if(e)this.targetElements.forEach((t=>t.scrollIntoView(e==="true")));else if(t||r||o){const e={};t&&(e.block=t);r&&(e.inline=r);o&&(e.behavior=o);this.targetElements.forEach((t=>t.scrollIntoView(e)))}else this.targetElements.forEach((e=>e.scrollIntoView()))}function set_focus(){this.targetElements.forEach((e=>e.focus()))}function set_title(){const e=this.getAttribute("title")||"";let t=document.head.querySelector("title");if(!t){t=document.createElement("title");document.head.appendChild(t)}t.textContent=e}function registerBrowserActions(e){e.reload=reload;e.scroll_into_view=scroll_into_view;e.set_focus=set_focus;e.set_title=set_title}function console_log(){const e=this.getAttribute("message");const t=this.getAttribute("level")||"log";console[t](e)}function console_table(){const e=JSON.parse(this.getAttribute("data")||"[]");const t=JSON.parse(this.getAttribute("columns")||"[]");console.table(e,t)}function registerDebugActions(e){e.console_log=console_log;e.console_table=console_table}function invoke(){console.warn("[TurboPower] The `invoke` Turbo Stream Action was removed from TurboPower. If you'd like to continue using this action please use the successor library instead. Read more here: https://github.com/hopsoft/turbo_boost-streams")}function registerDeprecatedActions(e){e.invoke||(e.invoke=invoke)}class CookieStringBuilder{constructor(e){this.ATTRIBUTE_TO_COOKIE_KEY_MAPPING=[["domain","Domain",false],["path","Path",false],["expires","Expires",false],["max-age","Max-Age",false],["http-only","HttpOnly",true],["secure","Secure",true],["same-site","SameSite",false]];this.streamElement=e}build(){let e=`${this.streamElement.getAttribute("name")}=${this.streamElement.getAttribute("value")}`;this.ATTRIBUTE_TO_COOKIE_KEY_MAPPING.forEach((([t,r,o])=>{const s=this.streamElement.getAttribute(t);if(s!==null){const t=o?r:`${r}=${s}`;e=`${e}; ${t}`}}));return e}}function set_cookie(){const e=this.getAttribute("cookie")||"";document.cookie=e}function set_cookie_item(){const e=new CookieStringBuilder(this);document.cookie=e.build()}function registerDocumentActions(e){e.set_cookie=set_cookie;e.set_cookie_item=set_cookie_item}function graft(){const e=this.getAttribute("parent");if(e){const t=document.querySelector(e);t?this.targetElements.forEach((e=>t.appendChild(e))):console.error(`[TurboPower] couldn't find parent element using selector "${e}" for Turbo Streams operation "graft"`)}else console.error('[TurboPower] no "parent" selector provided for Turbo Streams operation "graft"')}function inner_html(){const e=this.templateContent.textContent||"";this.targetElements.forEach((t=>t.innerHTML=e))}function insert_adjacent_html(){const e=this.getAttribute("position")||"beforebegin";const t=this.templateContent.textContent||"";this.targetElements.forEach((r=>r.insertAdjacentHTML(e,t)))}function insert_adjacent_text(){const e=this.getAttribute("position")||"beforebegin";const t=this.getAttribute("text")||"";this.targetElements.forEach((r=>r.insertAdjacentText(e,t)))}function outer_html(){const e=this.templateContent.textContent||"";this.targetElements.forEach((t=>t.outerHTML=e))}function set_meta(){const e=this.getAttribute("name");const t=this.getAttribute("content")||"";if(e){let r=document.head.querySelector(`meta[name='${e}']`);if(!r){r=document.createElement("meta");r.name=e;document.head.appendChild(r)}r.content=t}else console.error('[TurboPower] no "name" provided for Turbo Streams operation "set_meta"')}function text_content(){const e=this.getAttribute("text")||"";this.targetElements.forEach((t=>t.textContent=e))}function registerDOMActions(e){e.graft=graft;e.inner_html=inner_html;e.insert_adjacent_html=insert_adjacent_html;e.insert_adjacent_text=insert_adjacent_text;e.outer_html=outer_html;e.text_content=text_content;e.set_meta=set_meta}function dispatch_event(){const e=this.getAttribute("name");let t=null;try{t=this.templateContent.textContent}catch(e){}try{const r=t?JSON.parse(t):{};if(e){const t={bubbles:true,cancelable:true,detail:r};const o=new CustomEvent(e,t);this.targetElements.forEach((e=>e.dispatchEvent(o)))}else console.warn('[TurboPower] no "name" provided for Turbo Streams operation "dispatch_event"')}catch(e){console.error(`[TurboPower] error proccessing provided "detail" in "<template>" ("${t}") for Turbo Streams operation "dispatch_event".`,`Error: "${e.message}"`)}}function registerEventsActions(e){e.dispatch_event=dispatch_event}function reset_form(){this.targetElements.forEach((e=>e.reset()))}function registerFormActions(e){e.reset_form=reset_form}function push_state(){const e=this.getAttribute("url");const t=this.getAttribute("state");const r=this.getAttribute("title")||"";window.history.pushState(t,r,e)}function replace_state(){const e=this.getAttribute("url");const t=this.getAttribute("state");const r=this.getAttribute("title")||"";window.history.replaceState(t,r,e)}function history_back(){window.history.back()}function history_forward(){window.history.forward()}function history_go(){const e=Number(this.getAttribute("delta"))||0;window.history.go(e)}function registerHistoryActions(e){e.push_state=push_state;e.replace_state=replace_state;e.history_back=history_back;e.history_go=history_go}const m=["dir","lang","badge","body","tag","icon","image","data","vibrate","renotify","require-interaction","actions","silent"];const createNotification=e=>{const t=e.getAttribute("title")||"";const r=Array.from(e.attributes).filter((e=>m.includes(e.name))).map((e=>[camelize(e.name),typecast(e.value)]));const o=Object.fromEntries(r);new Notification(t,o)};function notification(){window.Notification?Notification.permission==="granted"?createNotification(this):Notification.permission!=="denied"&&Notification.requestPermission().then((e=>{e==="granted"&&createNotification(this)})):alert("This browser does not support desktop notification")}function registerNotificationActions(e){e.notification=notification}function storage(e){return e==="session"?window.sessionStorage:window.localStorage}function clear_storage(){const e=this.getAttribute("type");storage(e).clear()}function set_storage_item(){const e=this.getAttribute("key");const t=this.getAttribute("value")||"";const r=this.getAttribute("type");e?storage(r).setItem(e,t):console.warn('[TurboPower] no "key" provided for Turbo Streams operation "set_storage_item"')}function remove_storage_item(){const e=this.getAttribute("key");const t=this.getAttribute("type");e?storage(t).removeItem(e):console.warn('[TurboPower] no "key" provided for Turbo Streams operation "remove_storage_item"')}function registerStorageActions(e){e.clear_storage=clear_storage;e.set_storage_item=set_storage_item;e.remove_storage_item=remove_storage_item}var f={get location(){return window.TurboPowerLocation||window.location}};function redirect_to(){const e=this.getAttribute("url")||"/";const t=this.getAttribute("turbo-action")||"advance";const r=this.getAttribute("turbo-frame");const o=this.getAttribute("turbo")!=="false";const s={action:t};r&&(s.frame=r);o&&window.Turbo?window.Turbo.visit(e,s):f.location.assign(e)}function turbo_clear_cache(){window.Turbo.cache.clear()}function registerTurboActions(e){e.redirect_to=redirect_to;e.turbo_clear_cache=turbo_clear_cache}function turbo_progress_bar_set_value(){const e=this.getAttribute("value")||0;window.Turbo.navigator.adapter.progressBar.setValue(Number(e))}function turbo_progress_bar_show(){window.Turbo.navigator.adapter.progressBar.show()}function turbo_progress_bar_hide(){window.Turbo.navigator.adapter.progressBar.hide()}function registerTurboProgressBarActions(e){e.turbo_progress_bar_set_value=turbo_progress_bar_set_value;e.turbo_progress_bar_show=turbo_progress_bar_show;e.turbo_progress_bar_hide=turbo_progress_bar_hide}function turbo_frame_reload(){this.targetElements.forEach((e=>e.reload()))}function turbo_frame_set_src(){const e=this.getAttribute("src");this.targetElements.forEach((t=>t.src=e))}function registerTurboFrameActions(e){e.turbo_frame_reload=turbo_frame_reload;e.turbo_frame_set_src=turbo_frame_set_src}function register$1(e){registerAttributesActions(e);registerBrowserActions(e);registerDebugActions(e);registerDeprecatedActions(e);registerDocumentActions(e);registerDOMActions(e);registerEventsActions(e);registerFormActions(e);registerHistoryActions(e);registerNotificationActions(e);registerStorageActions(e);registerTurboActions(e);registerTurboProgressBarActions(e);registerTurboFrameActions(e)}var h=Object.freeze({__proto__:null,add_css_class:add_css_class,clear_storage:clear_storage,console_log:console_log,console_table:console_table,dispatch_event:dispatch_event,graft:graft,history_back:history_back,history_forward:history_forward,history_go:history_go,inner_html:inner_html,insert_adjacent_html:insert_adjacent_html,insert_adjacent_text:insert_adjacent_text,invoke:invoke,notification:notification,outer_html:outer_html,push_state:push_state,redirect_to:redirect_to,register:register$1,registerAttributesActions:registerAttributesActions,registerBrowserActions:registerBrowserActions,registerDOMActions:registerDOMActions,registerDebugActions:registerDebugActions,registerDeprecatedActions:registerDeprecatedActions,registerDocumentActions:registerDocumentActions,registerEventsActions:registerEventsActions,registerFormActions:registerFormActions,registerHistoryActions:registerHistoryActions,registerNotificationActions:registerNotificationActions,registerStorageActions:registerStorageActions,registerTurboActions:registerTurboActions,registerTurboFrameActions:registerTurboFrameActions,registerTurboProgressBarActions:registerTurboProgressBarActions,reload:reload,remove_attribute:remove_attribute,remove_css_class:remove_css_class,remove_storage_item:remove_storage_item,replace_css_class:replace_css_class,replace_state:replace_state,reset_form:reset_form,scroll_into_view:scroll_into_view,set_attribute:set_attribute,set_cookie:set_cookie,set_cookie_item:set_cookie_item,set_dataset_attribute:set_dataset_attribute,set_focus:set_focus,set_meta:set_meta,set_property:set_property,set_storage_item:set_storage_item,set_style:set_style,set_styles:set_styles,set_title:set_title,set_value:set_value,text_content:text_content,toggle_css_class:toggle_css_class,turbo_clear_cache:turbo_clear_cache,turbo_frame_reload:turbo_frame_reload,turbo_frame_set_src:turbo_frame_set_src,turbo_progress_bar_hide:turbo_progress_bar_hide,turbo_progress_bar_set_value:turbo_progress_bar_set_value,turbo_progress_bar_show:turbo_progress_bar_show});function initialize(e){initialize$1(e);register$1(e)}function register(e,t,r){r[e]=t}var g={initialize:initialize,register:register,Actions:h,Utils:_};export{h as Actions,_ as Utils,g as default,initialize,register};

