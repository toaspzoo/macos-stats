#import <Foundation/Foundation.h>
#include <Foundation/NSObjCRuntime.h>
#include <IOKit/pwr_mgt/IOPM.h>
#include <IOKit/pwr_mgt/IOPMLib.h>
#include <IOKit/ps/IOPSKeys.h>
#include <IOKit/ps/IOPowerSources.h>
#include <IOKit/hidsystem/ev_keymap.h>
#include <IOKit/hid/IOHIDKeys.h>
#include "Power.h"

@implementation Power

NSString* timeToEmpty = @"N/A";
NSString* timeToFull = @"N/A";
NSString* battSN = @"N/A";
NSString* battHealth = @"N/A";
NSString* battChargeLevel = @"N/A";
NSString* adapterPower = @"N/A";
CFBooleanRef isCharging = FALSE;

-(void)update {
    CFTypeRef psInfo = IOPSCopyPowerSourcesInfo();
    assert(psInfo != NULL);
    
    CFArrayRef psList = IOPSCopyPowerSourcesList(psInfo);
    assert(psList != NULL);
    
    long count = CFArrayGetCount(psList);
    
    for(long i = 0; i< count; i++) {
        CFDictionaryRef ps = IOPSGetPowerSourceDescription(psInfo, CFArrayGetValueAtIndex(psList, i));
        assert(ps != NULL);
        
        CFStringRef chargeLevel = (CFStringRef)CFDictionaryGetValue(ps, CFSTR(kIOPSCurrentCapacityKey));
        assert(chargeLevel != NULL);
        battChargeLevel = (__bridge NSString*)chargeLevel;
        
        CFStringRef serialNumber = (CFStringRef)CFDictionaryGetValue(ps, CFSTR(kIOPSHardwareSerialNumberKey));
        assert(serialNumber != NULL);
        battSN = (__bridge NSString*)serialNumber;
        
        CFStringRef tte = (CFStringRef)CFDictionaryGetValue(ps, CFSTR(kIOPSTimeToEmptyKey));
        assert(tte != NULL);
        timeToEmpty = (__bridge NSString*)tte;

        
        CFStringRef health = (CFStringRef)CFDictionaryGetValue(ps, CFSTR(kIOPSMaxCapacityKey));
        assert(tte != NULL);
        battHealth = (__bridge NSString*)health;

        
        CFBooleanRef charging = (CFBooleanRef)CFDictionaryGetValue(ps, CFSTR(kIOPSIsChargingKey));
        assert(charging != NULL);
        isCharging = charging;

        if(isCharging == kCFBooleanTrue) {
            CFStringRef adapterW = (CFStringRef)CFDictionaryGetValue(ps, CFSTR(kIOPSPowerAdapterWattsKey));
            adapterPower = (__bridge NSString*)adapterW;
            
            CFStringRef ttf = (CFStringRef)CFDictionaryGetValue(ps, CFSTR(kIOPSTimeToFullChargeKey));
            timeToFull = (__bridge NSString*)ttf;
        }
    }
    CFRelease(psList);
    CFRelease(psInfo);
}

-(NSString*)getTimeToEmpty {
    return timeToEmpty;
}

-(NSString *)getSN {
    return battSN;
}

-(NSString *)getHealth {
    return battHealth;
}

-(Boolean)isCharging {
    return isCharging == kCFBooleanTrue;
}

-(NSString *)getChargeLevel {
    return battChargeLevel;
}

- (NSString *)getAdapterPower {
    return adapterPower;
}

- (NSString *)getTimeToFull {
    return timeToFull;
}

@end
