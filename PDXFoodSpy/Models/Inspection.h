#import <Foundation/Foundation.h>
#import "SearchResult.h"
#import "InspectionViolation.h"

NS_ASSUME_NONNULL_BEGIN

@interface Inspection : NSObject

@property SearchResult *searchResult;

@property NSArray<InspectionViolation *> *violations;

@end

NS_ASSUME_NONNULL_END
