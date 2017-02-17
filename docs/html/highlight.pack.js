/*! highlight.js v9.0.0 | BSD3 License | git.io/hljslicense */
!function(e){"undefined"!=typeof exports?e(exports):(self.hljs=e({}),"function"==typeof define&&define.amd&&define("hljs",[],function(){return self.hljs}))}(function(e){function n(e){return e.replace(/&/gm,"&amp;").replace(/</gm,"&lt;").replace(/>/gm,"&gt;")}function t(e){return e.nodeName.toLowerCase()}function r(e,n){var t=e&&e.exec(n);return t&&0==t.index}function a(e){return/^(no-?highlight|plain|text)$/i.test(e)}function i(e){var n,t,r,i=e.className+" ";if(i+=e.parentNode?e.parentNode.className:"",t=/\blang(?:uage)?-([\w-]+)\b/i.exec(i))return x(t[1])?t[1]:"no-highlight";for(i=i.split(/\s+/),n=0,r=i.length;r>n;n++)if(x(i[n])||a(i[n]))return i[n]}function o(e,n){var t,r={};for(t in e)r[t]=e[t];if(n)for(t in n)r[t]=n[t];return r}function s(e){var n=[];return function r(e,a){for(var i=e.firstChild;i;i=i.nextSibling)3==i.nodeType?a+=i.nodeValue.length:1==i.nodeType&&(n.push({event:"start",offset:a,node:i}),a=r(i,a),t(i).match(/br|hr|img|input/)||n.push({event:"stop",offset:a,node:i}));return a}(e,0),n}function c(e,r,a){function i(){return e.length&&r.length?e[0].offset!=r[0].offset?e[0].offset<r[0].offset?e:r:"start"==r[0].event?e:r:e.length?e:r}function o(e){function r(e){return" "+e.nodeName+'="'+n(e.value)+'"'}l+="<"+t(e)+Array.prototype.map.call(e.attributes,r).join("")+">"}function s(e){l+="</"+t(e)+">"}function c(e){("start"==e.event?o:s)(e.node)}for(var u=0,l="",f=[];e.length||r.length;){var b=i();if(l+=n(a.substr(u,b[0].offset-u)),u=b[0].offset,b==e){f.reverse().forEach(s);do c(b.splice(0,1)[0]),b=i();while(b==e&&b.length&&b[0].offset==u);f.reverse().forEach(o)}else"start"==b[0].event?f.push(b[0].node):f.pop(),c(b.splice(0,1)[0])}return l+n(a.substr(u))}function u(e){function n(e){return e&&e.source||e}function t(t,r){return new RegExp(n(t),"m"+(e.cI?"i":"")+(r?"g":""))}function r(a,i){if(!a.compiled){if(a.compiled=!0,a.k=a.k||a.bK,a.k){var s={},c=function(n,t){e.cI&&(t=t.toLowerCase()),t.split(" ").forEach(function(e){var t=e.split("|");s[t[0]]=[n,t[1]?Number(t[1]):1]})};"string"==typeof a.k?c("keyword",a.k):Object.keys(a.k).forEach(function(e){c(e,a.k[e])}),a.k=s}a.lR=t(a.l||/\b\w+\b/,!0),i&&(a.bK&&(a.b="\\b("+a.bK.split(" ").join("|")+")\\b"),a.b||(a.b=/\B|\b/),a.bR=t(a.b),a.e||a.eW||(a.e=/\B|\b/),a.e&&(a.eR=t(a.e)),a.tE=n(a.e)||"",a.eW&&i.tE&&(a.tE+=(a.e?"|":"")+i.tE)),a.i&&(a.iR=t(a.i)),void 0===a.r&&(a.r=1),a.c||(a.c=[]);var u=[];a.c.forEach(function(e){e.v?e.v.forEach(function(n){u.push(o(e,n))}):u.push("self"==e?a:e)}),a.c=u,a.c.forEach(function(e){r(e,a)}),a.starts&&r(a.starts,i);var l=a.c.map(function(e){return e.bK?"\\.?("+e.b+")\\.?":e.b}).concat([a.tE,a.i]).map(n).filter(Boolean);a.t=l.length?t(l.join("|"),!0):{exec:function(){return null}}}}r(e)}function l(e,t,a,i){function o(e,n){for(var t=0;t<n.c.length;t++)if(r(n.c[t].bR,e))return n.c[t]}function s(e,n){if(r(e.eR,n)){for(;e.endsParent&&e.parent;)e=e.parent;return e}return e.eW?s(e.parent,n):void 0}function c(e,n){return!a&&r(n.iR,e)}function b(e,n){var t=N.cI?n[0].toLowerCase():n[0];return e.k.hasOwnProperty(t)&&e.k[t]}function p(e,n,t,r){var a=r?"":y.classPrefix,i='<span class="'+a,o=t?"":"</span>";return i+=e+'">',i+n+o}function g(){if(!R.k)return n(M);var e="",t=0;R.lR.lastIndex=0;for(var r=R.lR.exec(M);r;){e+=n(M.substr(t,r.index-t));var a=b(R,r);a?(B+=a[1],e+=p(a[0],n(r[0]))):e+=n(r[0]),t=R.lR.lastIndex,r=R.lR.exec(M)}return e+n(M.substr(t))}function d(){var e="string"==typeof R.sL;if(e&&!w[R.sL])return n(M);var t=e?l(R.sL,M,!0,k[R.sL]):f(M,R.sL.length?R.sL:void 0);return R.r>0&&(B+=t.r),e&&(k[R.sL]=t.top),p(t.language,t.value,!1,!0)}function h(){return void 0!==R.sL?d():g()}function m(e,t){var r=e.cN?p(e.cN,"",!0):"";e.rB?(L+=r,M=""):e.eB?(L+=n(t)+r,M=""):(L+=r,M=t),R=Object.create(e,{parent:{value:R}})}function v(e,t){if(M+=e,void 0===t)return L+=h(),0;var r=o(t,R);if(r)return L+=h(),m(r,t),r.rB?0:t.length;var a=s(R,t);if(a){var i=R;i.rE||i.eE||(M+=t),L+=h();do R.cN&&(L+="</span>"),B+=R.r,R=R.parent;while(R!=a.parent);return i.eE&&(L+=n(t)),M="",a.starts&&m(a.starts,""),i.rE?0:t.length}if(c(t,R))throw new Error('Illegal lexeme "'+t+'" for mode "'+(R.cN||"<unnamed>")+'"');return M+=t,t.length||1}var N=x(e);if(!N)throw new Error('Unknown language: "'+e+'"');u(N);var E,R=i||N,k={},L="";for(E=R;E!=N;E=E.parent)E.cN&&(L=p(E.cN,"",!0)+L);var M="",B=0;try{for(var C,j,I=0;;){if(R.t.lastIndex=I,C=R.t.exec(t),!C)break;j=v(t.substr(I,C.index-I),C[0]),I=C.index+j}for(v(t.substr(I)),E=R;E.parent;E=E.parent)E.cN&&(L+="</span>");return{r:B,value:L,language:e,top:R}}catch(_){if(-1!=_.message.indexOf("Illegal"))return{r:0,value:n(t)};throw _}}function f(e,t){t=t||y.languages||Object.keys(w);var r={r:0,value:n(e)},a=r;return t.forEach(function(n){if(x(n)){var t=l(n,e,!1);t.language=n,t.r>a.r&&(a=t),t.r>r.r&&(a=r,r=t)}}),a.language&&(r.second_best=a),r}function b(e){return y.tabReplace&&(e=e.replace(/^((<[^>]+>|\t)+)/gm,function(e,n){return n.replace(/\t/g,y.tabReplace)})),y.useBR&&(e=e.replace(/\n/g,"<br>")),e}function p(e,n,t){var r=n?E[n]:t,a=[e.trim()];return e.match(/\bhljs\b/)||a.push("hljs"),-1===e.indexOf(r)&&a.push(r),a.join(" ").trim()}function g(e){var n=i(e);if(!a(n)){var t;y.useBR?(t=document.createElementNS("http://www.w3.org/1999/xhtml","div"),t.innerHTML=e.innerHTML.replace(/\n/g,"").replace(/<br[ \/]*>/g,"\n")):t=e;var r=t.textContent,o=n?l(n,r,!0):f(r),u=s(t);if(u.length){var g=document.createElementNS("http://www.w3.org/1999/xhtml","div");g.innerHTML=o.value,o.value=c(u,s(g),r)}o.value=b(o.value),e.innerHTML=o.value,e.className=p(e.className,n,o.language),e.result={language:o.language,re:o.r},o.second_best&&(e.second_best={language:o.second_best.language,re:o.second_best.r})}}function d(e){y=o(y,e)}function h(){if(!h.called){h.called=!0;var e=document.querySelectorAll("div.line");Array.prototype.forEach.call(e,g)}}function m(){addEventListener("DOMContentLoaded",h,!1),addEventListener("load",h,!1)}function v(n,t){var r=w[n]=t(e);r.aliases&&r.aliases.forEach(function(e){E[e]=n})}function N(){return Object.keys(w)}function x(e){return e=(e||"").toLowerCase(),w[e]||w[E[e]]}var y={classPrefix:"hljs-",tabReplace:null,useBR:!1,languages:void 0},w={},E={};return e.highlight=l,e.highlightAuto=f,e.fixMarkup=b,e.highlightBlock=g,e.configure=d,e.initHighlighting=h,e.initHighlightingOnLoad=m,e.registerLanguage=v,e.listLanguages=N,e.getLanguage=x,e.inherit=o,e.IR="[a-zA-Z]\\w*",e.UIR="[a-zA-Z_]\\w*",e.NR="\\b\\d+(\\.\\d+)?",e.CNR="(-?)(\\b0[xX][a-fA-F0-9]+|(\\b\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?\\d+)?)",e.BNR="\\b(0b[01]+)",e.RSR="!|!=|!==|%|%=|&|&&|&=|\\*|\\*=|\\+|\\+=|,|-|-=|/=|/|:|;|<<|<<=|<=|<|===|==|=|>>>=|>>=|>=|>>>|>>|>|\\?|\\[|\\{|\\(|\\^|\\^=|\\||\\|=|\\|\\||~",e.BE={b:"\\\\[\\s\\S]",r:0},e.ASM={cN:"string",b:"'",e:"'",i:"\\n",c:[e.BE]},e.QSM={cN:"string",b:'"',e:'"',i:"\\n",c:[e.BE]},e.PWM={b:/\b(a|an|the|are|I|I'm|isn't|don't|doesn't|won't|but|just|should|pretty|simply|enough|gonna|going|wtf|so|such|will|you|your|like)\b/},e.C=function(n,t,r){var a=e.inherit({cN:"comment",b:n,e:t,c:[]},r||{});return a.c.push(e.PWM),a.c.push({cN:"doctag",b:"(?:TODO|FIXME|NOTE|BUG|XXX):",r:0}),a},e.CLCM=e.C("//","$"),e.CBCM=e.C("/\\*","\\*/"),e.HCM=e.C("#","$"),e.NM={cN:"number",b:e.NR,r:0},e.CNM={cN:"number",b:e.CNR,r:0},e.BNM={cN:"number",b:e.BNR,r:0},e.CSSNM={cN:"number",b:e.NR+"(%|em|ex|ch|rem|vw|vh|vmin|vmax|cm|mm|in|pt|pc|px|deg|grad|rad|turn|s|ms|Hz|kHz|dpi|dpcm|dppx)?",r:0},e.RM={cN:"regexp",b:/\//,e:/\/[gimuy]*/,i:/\n/,c:[e.BE,{b:/\[/,e:/\]/,r:0,c:[e.BE]}]},e.TM={cN:"title",b:e.IR,r:0},e.UTM={cN:"title",b:e.UIR,r:0},e.registerLanguage("playmol",function(e){var n={v:[{b:/\$\{[a-zA-Z]\w*\}/,rB:!0,c:[{cN:"variable",b:/\$\{/,e:/\}/,eB:!0,eE:!0}]},{cN:"variable",b:/\$[a-zA-Z]\w*/}]},t={keyword:"define as for from in to downto next if then else endif atom_type mass diameter bond_type angle_type dihedral_type improper_type atom charge bond link unlink build align include shell aspect packmol seed retry nloops fix copy pack velocity body",built_in:"not abs exp log ln sqrt sinh cosh tanh sin cos tan asin acos atan int nint ceil floor mol"},r={cN:"keyword",v:[{b:/\bbox\s+(lengths|density|volume|angles)\b/},{b:/\bwrite\s+(playmol|lammps|lmp\/models|emdee|summary|xyz|lammpstrj|internals)\b/},{b:/\baction\s+(execute|setup)\b/},{b:/\b(pre|suf)fix\s+(atom|type)s(\s+none)?\b/},{b:/\bimproper(\s+search)?\b/},{b:/\bextra\s+(bond|angle|dihedral)\b/},{b:/\bquit(\s+all)?\b/},{b:/\breset\s+all/},{b:/\breset(\s+((bond|angle|dihedral|improper)_types|atoms|charges|bonds|impropers|xyz|packmol))+/}]};return{aliases:["playmol","pmol","mol"],k:t,c:[e.inherit(e.ASM,{cN:"string"}),e.inherit(e.QSM,{cN:"string"}),e.CNM,n,r,e.C("#","$")]}}),e});
