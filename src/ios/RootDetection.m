/********* RootDetection.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface RootDetection : CDVPlugin {
    // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;

- (void)isDeviceRooted:(CDVInvokedUrlCommand*)command;

@end

@implementation RootDetection

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    
    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) isDeviceRooted:(CDVInvokedUrlCommand*)command
{
    NSMutableDictionary *jsonObject;
    CDVPluginResult* pluginResult = nil;
    NSError *error;
    NSString *stringToBeWritten = @"This is a test for root.";
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    FILE *f = NULL ;
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"] ||
        [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"] ||
        [[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"] ||
        [[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"] ||
        [[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"] ||
        [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] ||
        [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]])  {
        [jsonObject setObject:[NSNumber numberWithBool:YES] forKey:@"isRootDevice"];
        printf("result is yes0");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObject];
        exit(0);
    } else if ((f = fopen("/bin/bash", "r")) ||
        (f = fopen("/Applications/Cydia.app", "r")) ||
        (f = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r")) ||
        (f = fopen("/usr/sbin/sshd", "r")) ||
        (f = fopen("/etc/apt", "r")))  {
        fclose(f);
        [jsonObject setObject:[NSNumber numberWithBool:YES] forKey:@"isRootDevice"];
        printf("result is yes1");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObject];
        fclose(f);
        exit(0);
    }else if(error == nil) {
        [jsonObject setObject:[NSNumber numberWithBool:YES] forKey:@"isRootDevice"];
        printf("result is yes2");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObject];
        exit(0);
    }else {
        printf("result is no");
        [jsonObject setObject:[NSNumber numberWithBool:NO] forKey:@"isRootDevice"];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObject];
    }
}

@end
