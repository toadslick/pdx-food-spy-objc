#import <Foundation/Foundation.h>
#import "InspectionViolation.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RestaurantHistoryRequestDelegate <NSObject>

- (void)requestDidFailWithError:(NSError *)error;

- (void)requestDidSucceedWithResults:(NSArray<InspectionViolation *> *)violations;

@end

NS_ASSUME_NONNULL_END
