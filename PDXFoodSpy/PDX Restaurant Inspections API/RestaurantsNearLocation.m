#import "RestaurantsNearLocation.h"

@implementation RestaurantsNearLocation {
    JSONFetcher *jsonFetcher;
}

- (id)init {
    self = [super init];
    jsonFetcher = [JSONFetcher new];
    jsonFetcher.delegate = self;
    return self;
}

- (void)fetch:(CLLocationCoordinate2D)coordinate {
    NSString *url = [self buildURLString:coordinate];
    [jsonFetcher fetch:url];
}

- (NSString *)buildURLString:(CLLocationCoordinate2D)coordinate {
    NSString *format = @"http://api.civicapps.org/restaurant-inspections/near/%f,%f?since=%@";
    return [[NSString alloc] initWithFormat:format, coordinate.longitude, coordinate.latitude, [self buildEarliestDateString]];
}

- (NSString *)buildEarliestDateString {
    NSTimeInterval timeAgo = -4 * 365 * 24 * 60 * 60; // four years ago
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:timeAgo];
    return [self formatDate:date];
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}


- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveJSON:(NSDictionary *)json {
    NSLog(@"RESTAURANT SEARCH SUCCESS: %@", json);
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didFailWithError:(NSError *)error {
    NSLog(@"RESTAURANT SEARCH ERROR: %@, %@", [error localizedFailureReason], [error localizedDescription]);
}


@end
