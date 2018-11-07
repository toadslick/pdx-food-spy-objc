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
    [jsonFetcher fetch:[self buildURLString:coordinate]];
}

- (NSString *)buildURLString:(CLLocationCoordinate2D)coordinate {
    NSString *formatString = @"http://api.civicapps.org/restaurant-inspections/near/%f,%f";
    return [[NSString alloc] initWithFormat:formatString, coordinate.longitude, coordinate.latitude];
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveJSON:(NSDictionary *)json {
    NSLog(@"RESTAURANT SEARCH SUCCESS: %@", json);
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didFailWithError:(NSError *)error {
    NSLog(@"RESTAURANT SEARCH ERROR: %@, %@", [error localizedFailureReason], [error localizedDescription]);
}


@end
