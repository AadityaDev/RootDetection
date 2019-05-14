var exec = require('cordova/exec');

exports.isDeviceRooted = function (success, error) {
    console.log("is root called");
    exec(success, error, 'RootDetection', 'isDeviceRooted');
};
