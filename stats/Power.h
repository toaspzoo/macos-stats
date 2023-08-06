#ifndef Power_h
#define Power_h
#import "Power.h"
#import <Foundation/Foundation.h>

@interface Power : NSObject
-(Boolean)isCharging;
-(NSString*)getAdapterPower;
-(NSString*)getChargeLevel;
-(NSString*)getTimeToEmpty;
-(NSString*)getTimeToFull;
-(NSString*)getSN;
-(NSString*)getHealth;
-(void)update;
@end
#endif /* Power_h */

