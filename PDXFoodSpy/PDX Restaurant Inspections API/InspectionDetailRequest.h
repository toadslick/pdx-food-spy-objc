#import <Foundation/Foundation.h>
#import "RequestDelegate.h"
#import "JSONFetcher.h"
#import "InspectionViolation.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionDetailRequest : NSObject <JSONFetcherDelegate>

@property (weak) id <RequestDelegate> delegate;

- (void)fetch:(NSString *)inspectionID;

@end

NS_ASSUME_NONNULL_END
