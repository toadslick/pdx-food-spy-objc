#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InspectionViolation : NSObject

+ (InspectionViolation *)initFromJSONDictionary:(NSDictionary *)dict;

@property NSString *lawCode;
@property NSString *violationText;
@property NSString *violationComments;
@property NSString *correctiveText;
@property NSString *correctiveComments;

@end

NS_ASSUME_NONNULL_END
