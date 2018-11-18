#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestaurantHistoryRequest : NSObject

- (void)fetch:(NSString *)restaurantID;

@end

NS_ASSUME_NONNULL_END
