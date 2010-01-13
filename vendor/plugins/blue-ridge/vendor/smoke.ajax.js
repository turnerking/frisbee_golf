Smoke.Ajax = {
  mocks: {},
  mock: function(url, response, status, options) {
    options = options || {};

    this.mocks[url] = {url: url, response: response, status: status, options: options};

    if(window.ActiveXObject) {
      window.AcriveXObject = Smoke.ActiveXObjectMock;
    } else {
      XMLHttpRequest = Smoke.xhrMock;
    }
  }
};

Smoke.xhrMock = function() {
  this.readyState = 4;
  this.status = 200;
};

Smoke.xhrMock.prototype.open = function(type, url, async, username, password) {
  var mock = Smoke.Ajax.mocks[url];
  this.responseText = mock.response;
  this.status = mock.status;
};

Smoke.xhrMock.prototype.abort = function() {};

Smoke.xhrMock.prototype.getResponseHeader = function() {};

Smoke.ActiveXObjectMock = function(arg) {
  new Smoke.xhrMock();
};
