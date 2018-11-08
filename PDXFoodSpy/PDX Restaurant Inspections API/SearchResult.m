#import "SearchResult.h"

@implementation SearchResult

+ (SearchResult *)initFromJSONDictionary:(NSDictionary *)dict {
    SearchResult *result = [SearchResult new];
    NSDictionary *address = [dict objectForKey:@"address"];
    NSDictionary *location = [dict objectForKey:@"location"];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    result.name = [dict objectForKey:@"name"];
    result.address = [address objectForKey:@"address"];
    result.zip = [address objectForKey:@"zip"];
    result.inspectionID = [dict objectForKey:@"inspection_number"];
    result.restaurantID = [dict objectForKey:@"restaurant_id"];
    result.score = [[dict objectForKey:@"score"] integerValue];
    result.date = [dateFormatter dateFromString:[dict objectForKey:@"date"]];
    result.coordinate = CLLocationCoordinate2DMake(
        [[location objectForKey:@"Latitude"] longValue],
        [[location objectForKey:@"Longitude"] longValue]);
    return result;
}

@end