/**
 * Created by Alive on 16/4/19.
 */
var arr = parseInt(Math.random() * 5);
var socket = (function () {
    var url = window.location.host;
    var socket = new WebSocket('ws://' + url + '/cable');
    var initSocketObj = {
        command: 'subscribe',
        identifier: "{\"channel\":\"ChatChannel\",\"sid\":" + arr + "}"
    };
    socket.onopen = function (event) {
        console.log("onOpen =========> " + event);
        socket.send(JSON.stringify(initSocketObj));
    };
    socket.onmessage = function (event) {
        var data = JSON.parse(event.data);
        var message = data.message;
        if (message) {
            console.log("onOpen =========> " + event.data);
            if (message.refresh) {
                //alert(1);
                loadAll();
            }
        }
    };
    socket.onclose = function (event) {
        console.log("onOpen =========> " + 'E.., close.');
    };
    return socket;
})();

function loadXMLDoc(method, url, params, success, failure) {
    var xhr = null;
    if (window.XMLHttpRequest) {// code for all new browsers
        xhr = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {// code for IE5 and IE6
        xhr = new ActiveXObject("Microsoft.xhr");
    }
    if (xhr != null) {
        xhr.onreadystatechange = function () {
            state_Change(xhr, success, failure);
        };
        xhr.open(method, url, true);
        if (method === "POST") {
            xhr.send(params);
        }
        xhr.send(null);
    }
    else {
        alert("Your browser does not support xhr.");
    }
}

function state_Change(xhr, success, failure) {
    if (xhr.readyState == 4) {// 4 = "loaded"
        if (xhr.status == 200) {// 200 = OK
            success(xhr.responseText);
        }
        else {
            failure(xhr.responseText);
        }
    }
}

function submit(button) {
    var parent = button.parentNode;
    var name = parent.querySelector('input[name=name]').value;
    var content = parent.querySelector('input[name=content]').value;
    var obj = { name: name, content: content };
    var simpleCableObj = {
        identifier: "{\"channel\":\"ChatChannel\",\"sid\":" + arr + "}",
        command: 'message',
        data: JSON.stringify(obj)
    };
    socket.send(JSON.stringify(simpleCableObj));
    //loadXMLDoc('post','/chat/create',{
    //    name:name,
    //    message:content
    //},function(res){
    //    console.log(res);
    //},function(res){
    //    console.log(res);
    //})
}

window.onload = init;

function init() {
    document.querySelector('span#channel').innerHTML = arr;
    loadAll();
    //socket.close();
}

function loadAll() {
    loadXMLDoc('GET', '/chat/get_all', null,
        function (ret) {
            var json = JSON.parse(ret);
            if (json.success) {
                var data = json.data;
                refreshMessageDom(data);
            } else {
                console.log(json.msg);
            }
        },
        function (ret) {
            console.log(ret);
        }
    )
}

function refreshMessageDom(data) {
    var messageDom = document.querySelector('div.message');
    var message = '';
    for (var i = 0; i < data.length; i++) {
        message += "『name:" + data[i].name + ", content:" + data[i].content + "』<br />";
    }
    messageDom.innerHTML = message;
}


