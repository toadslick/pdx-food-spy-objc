#import "InspectionViolation.h"

@implementation InspectionViolation

+ (InspectionViolation *)initFromJSONDictionary:(NSDictionary *)dict {
    InspectionViolation *iv = [InspectionViolation new];
    iv.lawCode              = [self trimmedString:@"law"                    from:dict];
    iv.violationText        = [self trimmedString:@"violation_rule"         from:dict];
    iv.violationComments    = [self trimmedString:@"violation_comments"     from:dict];
    iv.correctiveText       = [self trimmedString:@"corrective_text"        from:dict];
    iv.correctiveComments   = [self trimmedString:@"corrective_comments"    from:dict];
    return iv;
}

+ (NSString *)trimmedString:(NSString *)key from:(NSDictionary *)dict {
    NSString *string = [dict objectForKey:key];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)description {
    return self.lawCode;
}

@end
