var Trackmetrics = {
  authToken: null,
  setAuthToken: function(auth_token) {
    this.authToken = auth_token;
  },
  send: function(name, data) {
    var _bm_request = new XMLHttpRequest();
    _bm_request.open("POST", "http://trackmetrics.herokuapp.com/api/v1/events.json?auth_token=" + this.authToken, true);
    _bm_request.setRequestHeader('Content-Type', 'application/json');
    _bm_request.onreadystatechange = function() {
      // this function runs when the Ajax request changes state.
      // https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
    };
    _bm_request.send(JSON.stringify({name: name, data: data}));
  }
}
