import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
/**
 * This class echoes a string called from JavaScript.
 */
public class RootDetection extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        // Log.v("Adi Root Detection","action is "+action);
        switch(action){
            case "isDeviceRooted":
            this.isDeviceRooted(callbackContext);
            return true;
            default:
            return false;
        }
    }

    private void coolMethod(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }

    private boolean isDeviceRooted(CallbackContext callbackContext) {
        boolean res = checkRootMethod1() || checkRootMethod2() || checkRootMethod3();
        try{
            JSONObject result = new JSONObject();
            result.put("isRootDevice",res);
        // Log.d("Adi Root Detection","callback context "+callbackContext);
        // Log.d("Adi Root Detection","res is "+res);
        if(res){
            // Log.v("Adi Root Detection","if");
            callbackContext.success(result);
        }else{
            // Log.d("Adi Root Detection","else");
            callbackContext.success(result);
        }
        }catch(JSONException jsonException){
            callbackContext.error("JSON Exception");
        }finally{
            return res;
        }
    }

    private boolean checkRootMethod1() {
        String buildTags = android.os.Build.TAGS;
        return buildTags != null && buildTags.contains("test-keys");
    }

    private boolean checkRootMethod2() {
        String[] paths = { "/system/app/Superuser.apk", "/sbin/su", "/system/bin/su", "/system/xbin/su", "/data/local/xbin/su", "/data/local/bin/su", "/system/sd/xbin/su",
                "/system/bin/failsafe/su", "/data/local/su", "/su/bin/su"};
        for (String path : paths) {
            if (new File(path).exists()) return true;
        }
        return false;
    }

    private boolean checkRootMethod3() {
        Process process = null;
        try {
            process = Runtime.getRuntime().exec(new String[] { "/system/xbin/which", "su" });
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
            if (in.readLine() != null) return true;
            return false;
        } catch (Throwable t) {
            return false;
        } finally {
            if (process != null) process.destroy();
        }
    }

}
