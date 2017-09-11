//
//  SPUShareUtils.h
//
//  Created by hanyutong on 2017/5/17.
//

#import <Foundation/Foundation.h>
#import <UShareUI/UShareUI.h>

@interface SPShareModel : NSObject

@property (nonatomic, copy)NSString * thumbURL;
@property (nonatomic, copy)NSString * shareTitle;
@property (nonatomic, copy)NSString * shareDesc;
@property (nonatomic, copy)NSString * webpageUrl;
@property (nonatomic, strong)UIViewController * currentViewController;

 
@end


@interface SPUShareUtils : NSObject

+ (SPUShareUtils *)sharedUShareUtil;
-(void)showShareMenuWithModel:(SPShareModel*)shareModel;

@end
