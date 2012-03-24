javascript:
function iprl5(){
    var d = document;
    var z = d.createElement('scr'+'ipt');
    var b = d.body;
    var l = d.location;
    try{
        if(!b) throw(0);
        d.title = '(Saving...) ' +d.title;
        z.setAttribute('src',
                       l.protocol+
                       '//www.instapaper.com/j/EtOx5jEWkGA2?u='+
                       encodeURIComponent(l.href)+
                       '&t='+(new Date().getTime()));
        b.appendChild(z);
    } catch(e) {
        alert('Please wait until the page has loaded.');
    }
}
iprl5();
void(0)
