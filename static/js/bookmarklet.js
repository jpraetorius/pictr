javascript:
(function(){
  var style = document.createElement("style");
  style.type="text/css";
  style.innerHTML="#jpr-bmmgr {position: absolute; top: 10px; right: 10px; z-index:100; width: 200px; height: 200px; border: 5px solid #000; border-radius: 3px; box-shadow: 5px 5px 5px #ddd; background-color: #fff; color: #000;}";
  var head=document.getElementsByTagName('head')[0];
  head.appendChild(style);
  
  var mgr = document.createElement("div");
  mgr.innerHTML = "<script type='text/javascript'>function submitLink() {var client = new XMLHttpRequest();client.open('POST', 'http://localhost:4567/add');client.setRequestHeader('Content-Type', 'text/plain;charset=UTF-8');client.send('1234');}</script><h1>Submit to linkmgr</h1><form action='#' method='#' onsubmit='submitLink();'><label for='title'>Title:</label><input type='text' name='title' id='title' placeholder='Enter a name for displaying the link' autofocus='autofocus' /><label for='link'>Link:</label><input type='text' name='link' id='link' placeholder='The links address'/><label for='tags'>Tags:</label><input type='text' name='tags' id='tags' placeholder='comma-separated list of tags'/><input type='submit' value='Submit Link' />";
  
  mgr.id = "jpr-bmmgr";
  var body = document.getElementsByTagName('body')[0];
  body.appendChild(mgr);
})();
