#import <Foundation/Foundation.h>
#import "InspectionDetailRequestDelegate.h"
#import "JSONFetcher.h"
#import "SearchResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectionDetailRequest : NSObject <JSONFetcherDelegate>

@property (weak) id <InspectionDetailRequestDelegate> delegate;

- (void)fetch:(NSString *)inspectionID;

@end

NS_ASSUME_NONNULL_END
