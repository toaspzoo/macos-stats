//
//  SMCObjC.m
//  stats
//
//  Created by toaspzoo on 03/08/2023.
//

#import <Foundation/Foundation.h>
#import "SMCObjC.h"

@implementation SMCObjC : NSObject
+(double)calculateTemp {
    return calculate();
}
-(int)calculateFanSpeed {
    return fanSpeed();
}
@end
