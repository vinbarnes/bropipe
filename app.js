var x = new XMLHttpRequest();
x.onreadystatechange = function() { doData(x.responseText) };
x.open('GET', 'http://localhost:7575/actions', true);
x.send('');

function doData(data) {
    console.log(data);
}

//'http://localhost:7575'
function buildForm(opts) {
    var d = document;
    var f = d.createElement('form');
    f.setAttribute('method', 'POST');
    f.setAttribute('id', 'actionPicker');
    f.setAttribute('action', opts['bropipeURL']);
    var a = d.createElement('input');
    a.setAttribute('type', 'text');
    a.setAttribute('name', 'cmd');
    a.setAttribute('id', 'cmdChosen');
    var u = d.createElement('input');
    u.setAttribute('type', 'hidden');
    u.setAttribute('name', 'url');
    u.setAttribute('id', 'actionURL');
    u.setAttribute('value', opts['actionURL']);
    f.appendChild(a);
    f.appendChild(u);
    d.body.appendChild(f);
}
var opts = {};
opts['bropipeURL'] = 'http://localhost:7575'
opts['actionURL'] = encodeURIComponent(window.location.href);

buildForm(opts);
