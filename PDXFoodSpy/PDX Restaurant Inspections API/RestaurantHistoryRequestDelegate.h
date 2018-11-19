#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RestaurantHistoryRequestDelegate <NSObject>

- (void)requestDidFailWithError:(NSError *)error;

- (void)requestDidSucceedWithResults;

@end

NS_ASSUME_NONNULL_END
