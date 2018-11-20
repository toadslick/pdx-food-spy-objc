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

// Decorator methods

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, %i, %f", self.name, self.score, self.distance];
}

- (NSString *)scoreString {
    return [[[NSNumber alloc] initWithInt:self.score] stringValue];
}

- (UIColor *)scoreColor {
    if (self.score > 95) {
        return [[UIColor alloc] initWithRed:0.24 green:0.51 blue:0.02 alpha:1];
    } else if (self.score > 90) {
        return [[UIColor alloc] initWithRed:0.36 green:0.68 blue:0.05 alpha:1];
    } else if (self.score > 85) {
        return [[UIColor alloc] initWithRed:0.67 green:0.84 blue:0.12 alpha:1];
    } else if (self.score > 80) {
        return [[UIColor alloc] initWithRed:0.98 green:0.80 blue:0.20 alpha:1];
    } else if (self.score > 75) {
        return [[UIColor alloc] initWithRed:0.94 green:0.45 blue:0.19 alpha:1];
    } else {
        return [[UIColor alloc] initWithRed:0.93 green:0.27 blue:0.18 alpha:1];
    }
}

- (NSString *)dateString {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterLongStyle;
    df.timeStyle = NSDateFormatterNoStyle;
    df.locale = [NSLocale currentLocale];
    return [df stringFromDate:self.date];
}

// Almost all scores don't go below 70, which is the minimum passing score.
// However, treat the minimum score as 50 to catch the rare cases where restaurants fail an inspection.
- (float)scorePercent {
    float minimumScore = 50;
    return ((float)(self.score - minimumScore)) / minimumScore;
}

// MKAnnotation methods

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.address;
}

@end
