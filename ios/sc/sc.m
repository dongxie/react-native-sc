//
//  sc.m
//  SC
//
//

#import "sc.h"
#import <React/RCTUtils.h>
#import <UIKit/UIKit.h>
#import "OpenInstallSDK.h"
#import "TalkingData.h"
#import "hsjson.h"
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
//{uid...nickname....}
RCT_EXPORT_METHOD(ReportRegister:(NSString*)data){
    NSMutableDictionary *body=[NSJSONSerialization objectWithString:data];
    //用户注册成功后调用
    [OpenInstallSDK reportRegister];
    [TalkingData onRegister:[[body objectForKey:@"uid"] stringValue] type:TDAccountTypeRegistered name:[body objectForKey:@"nickname"]];
}
RCT_EXPORT_METHOD(ReportLogin:(NSString*)data){
    NSMutableDictionary *body=[NSJSONSerialization objectWithString:data];
    [TalkingData onRegister:[[body objectForKey:@"uid"] stringValue] type:TDAccountTypeRegistered name:[body objectForKey:@"nickname"]];
}
//talkingData {event:"事件id",label:"事件名字",defaultValue:"默认值，比如第一个kv" ,param:{k:v...}}
RCT_EXPORT_METHOD(ReportEffectPoint:(NSString*)data){
    NSMutableDictionary *body=[NSJSONSerialization objectWithString:data];
    //value为整型,如果是人民币金额，请以分为计
    [[OpenInstallSDK defaultManager] reportEffectPoint:[[body objectForKey:@"event"] stringValue] effectValue:[[body objectForKey:@"defaultValue"] integerValue]];
    [TalkingData trackEvent: [body objectForKey:@"event"] label: [body objectForKey:@"label"] parameters: [body objectForKey:@"param"]];
}
/**
 *  @method    trackPageBegin
 *  开始跟踪某一页面（可选），记录页面打开时间
 建议在viewWillAppear或者viewDidAppear方法里调用
 *  @param  pageName    页面名称（自定义）
 */
RCT_EXPORT_METHOD(trackPageBegin:(NSString *)pageName){
    [TalkingData trackPageBegin:pageName];
}

/**
 *  @method trackPageEnd
 *  结束某一页面的跟踪（可选），记录页面的关闭时间
 此方法与trackPageBegin方法结对使用，
 在iOS应用中建议在viewWillDisappear或者viewDidDisappear方法里调用
 在Watch应用中建议在DidDeactivate方法里调用
 *  @param  pageName    页面名称，请跟trackPageBegin方法的页面名称保持一致
 */
RCT_EXPORT_METHOD(trackPageEnd:(NSString *)pageName){
    [TalkingData trackPageEnd:pageName];
}
@end
