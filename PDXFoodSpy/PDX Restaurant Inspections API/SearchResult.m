#import "SearchResult.h"

@implementation SearchResult

+ (SearchResult *)initFromJSONDictionary:(NSDictionary *)dict {
    SearchResult *result = [SearchResult new];
    NSDictionary *address = [dict objectForKey:@"address"];
    NSDictionary *location = [dict objectForKey:@"location"];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    result.name         = [dict objectForKey:@"name"];
    result.address      = [address objectForKey:@"street"];
    result.zip          = [address objectForKey:@"zip"];
    result.distance     = [[dict objectForKey:@"distance"] doubleValue];
    result.inspectionID = [dict objectForKey:@"inspection_number"];
    result.restaurantID = [dict objectForKey:@"restaurant_id"];
    result.score        = [[dict objectForKey:@"score"] intValue];
    result.date         = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
    result.coordinate   = CLLocationCoordinate2DMake(
        [[location objectForKey:@"Latitude"] doubleValue],
        [[location objectForKey:@"Longitude"] doubleValue]);
    
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, %i, %f", self.name, self.score, self.distance];
}

@end
