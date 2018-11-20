#import "InspectionViolation.h"

@implementation InspectionViolation

+ (InspectionViolation *)initFromJSONDictionary:(NSDictionary *)dict {
    InspectionViolation *iv = [InspectionViolation new];
    iv.lawCode              = [dict objectForKey:@"law"];
    iv.violationText        = [dict objectForKey:@"violation_rule"];
    iv.violationComments    = [dict objectForKey:@"violation_comments"];
    iv.correctiveText       = [dict objectForKey:@"corrective_text"];
    iv.correctiveComments   = [dict objectForKey:@"corrective_comments"];
    return iv;
}

- (NSString *)description {
    return self.lawCode;
}


@end
