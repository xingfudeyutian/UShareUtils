//
//  SPUShareUtils.m
//
//  Created by hanyutong on 2017/5/17.
//

#import "SPUShareUtils.h"


@implementation SPShareModel

@end


@interface SPUShareUtils ()

@property (nonatomic ,strong)SPShareModel * shareModel;

@end

@implementation SPUShareUtils

+ (SPUShareUtils *)sharedUShareUtil
{
    static SPUShareUtils *uShareUtils = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        uShareUtils = [[self alloc] init];
    });
    return uShareUtils;
}

-(void)showShareMenuWithModel:(SPShareModel*)shareModel
{
    self.shareModel = shareModel;
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        NSLog(@"%ld",platformType);
        [self shareWebPageToPlatformType:platformType];
    }];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareModel.shareTitle descr:self.shareModel.shareDesc thumImage:self.shareModel.thumbURL];
    //设置网页地址
    shareObject.webpageUrl = self.shareModel.webpageUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.shareModel.currentViewController completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}


@end
