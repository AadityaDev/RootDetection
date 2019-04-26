var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'RootDetection', 'coolMethod', [arg0]);
};

exports.isDeviceRooted = function (success, error) {
    console.log("is root called");
    exec(success, error, 'RootDetection', 'isDeviceRooted');
};
