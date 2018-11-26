//
//  PTRIDFA.m
//  IDFA
//
//  Created by Tomas Roos on 22/07/16.
//  Copyright © 2016 Tomas Roos. All rights reserved.
//

#import "sc.h"
#import <React/RCTUtils.h>
#import <UIKit/UIKit.h>
#import "OpenInstallSDK.h"
@import AdSupport;

@implementation sc

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(getIDFA:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject)
{
    NSUUID *IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
    resolve([IDFA UUIDString]);
}

RCT_EXPORT_METHOD(getOpenInstallData:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject)
{
    [[OpenInstallSDK defaultManager] getInstallParmsCompleted:^(OpeninstallData*_Nullable appData) {
        //在主线程中回调
        NSMutableDictionary * data=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"hi",@"hi",appData.data,@"data",appData.channelCode,@"channelCode", nil];
        resolve(data);
    }];
    
}

RCT_EXPORT_METHOD(openInstallReportRegister){
    //用户注册成功后调用
    [OpenInstallSDK reportRegister];
}
RCT_EXPORT_METHOD(openInstallReportEffectPoint:(NSString *)pointId
                                          with:(NSNumber *)point){
    [[OpenInstallSDK defaultManager] reportEffectPoint:pointId effectValue:[point integerValue]];//value为整型,如果是人民币金额，请以分为计
}
@end
