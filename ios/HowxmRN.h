#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(HowxmRN, NSObject)

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

RCT_EXTERN_METHOD(initializeSDK:(NSString*)appId
                  completion:(RCTResponseSenderBlock)completion);

RCT_EXTERN_METHOD(checkInitialized:(RCTResponseSenderBlock)callback);

RCT_EXTERN_METHOD(identify:(NSDictionary *)customer
                  success:(RCTResponseSenderBlock)success
                  failed:(RCTResponseSenderBlock)failed);

RCT_EXTERN_METHOD(event:(NSString*)code
                  :(NSDictionary<NSString *, id> * _Nullable)attributes
                  success:(RCTResponseSenderBlock)success
                  failed:(RCTResponseSenderBlock)failed);

RCT_EXTERN_METHOD(open:(NSString *)campaignId
                  customer:(Customer *)customer
                  extra:(NSDictionary<NSString *, id> *)extra);

RCT_EXTERN_METHOD(checkOpen:(NSString*)campaignId
                  :(NSString*)uid
                  success:(RCTResponseSenderBlock)success
                  failed:(RCTResponseSenderBlock)failed);

RCT_EXTERN_METHOD(onBeforeOpen:(RCTResponseSenderBlock)callback);

RCT_EXTERN_METHOD(onOpen:(RCTResponseSenderBlock)callback);

RCT_EXTERN_METHOD(onClose:(RCTResponseSenderBlock)callback);

RCT_EXTERN_METHOD(onPageComplete:(RCTResponseSenderBlock)callback);

RCT_EXTERN_METHOD(onComplete:(RCTResponseSenderBlock)callback);

@end
