#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertPresenter : NSObject

+ (void)presentAlert:(NSString * _Nullable)title withMessage:(NSString *)message forController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
