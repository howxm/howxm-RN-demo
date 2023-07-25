#import "HowxmRN.h"
#import <Howxm/Howxm.h>


@implementation HowxmRN

RCT_EXPORT_METHOD(initializeSDK:(NSString*)appId
                  completion:(RCTResponseSenderBlock)completion) {
  UIApplication *sharedApplication = [UIApplication performSelector:NSSelectorFromString(@"sharedApplication")];
  // 获取 delegate 对象
  id<UIApplicationDelegate> appDelegate = sharedApplication.delegate;
  UIWindow *window = [appDelegate window];
  // 获取 rootViewController
  UIViewController *rootViewController = window.rootViewController;
  [Howxm initializeSDK:appId :rootViewController :^{
    if (completion) {
      completion(@[[NSNull null]]);
    }
  } :nil];
}

RCT_EXPORT_METHOD(checkInitialized:(RCTResponseSenderBlock)callback) {
  BOOL initialized = [Howxm checkInitialized];
  callback(@[@(initialized)]);
}

RCT_EXPORT_METHOD(identify
                  :(NSDictionary *)customer
                  :(RCTResponseSenderBlock)success
                  :(RCTResponseSenderBlock)failed) {
  Customer *customerObj = [self convertToCustomer:customer];
  [Howxm identify :customerObj :^{
    if (success) {
      success(@[[NSNull null]]);
    }
  } :^{
    if (failed) {
      failed(@[[NSNull null]]);
    }
  }];
}

RCT_EXPORT_METHOD(event:(NSString*)code
                  :(NSDictionary<NSString *, id> * _Nullable)attributes
                  success:(RCTResponseSenderBlock)success
                  failed:(RCTResponseSenderBlock)failed) {
  [Howxm event:code :attributes :nil :^(void){
      success(@[[NSNull null]]);
  } :^(NSString * _Nullable errorMessage){
    if (errorMessage) {
      failed(@[errorMessage]);
    } else {
      failed(@[[NSNull null]]);
    }
  }];
}

RCT_EXPORT_METHOD(open:(NSString *)campaignId
                  customer:(NSDictionary *)customer
                  extra:(NSDictionary<NSString *, id> *)extra){
  Customer *customerObj = [self convertToCustomer:customer];
  [Howxm open:campaignId :customerObj :extra :nil];
}

RCT_EXPORT_METHOD(checkOpen:(NSString*)campaignId
                  :(NSString*)uid
                  success:(RCTResponseSenderBlock)success
                  failed:(RCTResponseSenderBlock)failed) {

  [Howxm checkOpen:campaignId :uid :^(void){
    success(@[[NSNull null]]);
  } :^(void){
    failed(@[[NSNull null]]);
  }];
}

RCT_EXPORT_METHOD(onBeforeOpen:(RCTResponseSenderBlock)callback) {
  [Howxm onBeforeOpen:^(NSString *campaignId, NSString *uid, NSDictionary *extraAttrs){
    callback(@[campaignId, uid, extraAttrs]);
  }];
}

RCT_EXPORT_METHOD(onOpen:(RCTResponseSenderBlock)callback) {
  [Howxm onOpen:^(NSString *campaignId, NSString *uid, NSDictionary *extraAttrs){
    callback(@[campaignId, uid, extraAttrs]);
  }];
}

RCT_EXPORT_METHOD(onClose:(RCTResponseSenderBlock)callback) {
  [Howxm onClose:^(NSString *campaignId, NSString *uid){
    callback(@[campaignId, uid]);
  }];
}

RCT_EXPORT_METHOD(onPageComplete:(RCTResponseSenderBlock)callback) {
  [Howxm onPageComplete:^(NSString *campaignId, NSString *uid, NSArray *fieldEntries){
    callback(@[campaignId, uid, fieldEntries]);
  }];
}

RCT_EXPORT_METHOD(onComplete:(RCTResponseSenderBlock)callback) {
  [Howxm onComplete:^(NSString *campaignId, NSString *uid){
    callback(@[campaignId, uid]);
  }];
}

- (Customer *)convertToCustomer:(NSDictionary *)dict {
    if (!dict) {
      return nil;
    }
    NSString *uid = [dict objectForKey:@"uid"];
    NSString *name = [dict objectForKey:@"name"];
    NSString *email = [dict objectForKey:@"email"];
    NSString *mobile = [dict objectForKey:@"mobile"];
    NSDictionary *extraAttributes = [dict objectForKey:@"extraAttributes"];

    Customer *customer = [[Customer alloc] init:uid :name :email :mobile :extraAttributes];
    return customer;
}

@end






