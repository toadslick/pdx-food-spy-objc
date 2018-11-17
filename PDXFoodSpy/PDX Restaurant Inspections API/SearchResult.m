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
    if (self.score > 99) {
        return [UIColor greenColor];
    } else if (self.score > 89) {
        return [UIColor yellowColor];
    } else if (self.score > 79) {
        return [UIColor orangeColor];
    } else {
        return [UIColor redColor];
    }
}

// MKAnnotation methods

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return [self scoreString];
}

- (NSString *)reuseIdentifier {
    if (self.score > 99) {
        return @"green";
    } else if (self.score > 89) {
        return @"yellow";
    } else if (self.score > 79) {
        return @"orange";
    } else {
        return @"red";
    }
}

@end
