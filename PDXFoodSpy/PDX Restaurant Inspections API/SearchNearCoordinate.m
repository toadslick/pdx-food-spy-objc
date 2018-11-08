#import "SearchNearCoordinate.h"
#import "SearchResult.h"

@implementation SearchNearCoordinate {
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
    NSLog(@"URL: %@", url);
    [jsonFetcher fetch:url];
}

- (NSString *)buildURLString:(CLLocationCoordinate2D)coordinate {
    NSString *format = @"http://api.civicapps.org/restaurant-inspections/near/%f,%f?since=%@&limit=%i";
    return [[NSString alloc] initWithFormat:format, coordinate.longitude, coordinate.latitude, [self buildEarliestDateString], 100];
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

- (NSArray<SearchResult *> *)buildSearchResults:(NSDictionary *)json {
    NSArray<NSDictionary *> *dicts = [json objectForKey:@"results"];
    NSArray<SearchResult *> *results = @[];
    
    // The "results" object will be nil if the JSON response returned with zero results found.
    if (dicts) {
        [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            // Only keep results for which the type is "FoodSvcSemi".
            NSString *type = [dict objectForKey:@"type"];
            if ([type isEqualToString:@"FoodSvcSemi"]) {
                SearchResult *result = [SearchResult initFromJSONDictionary:dict];
            }
        }];
    }
    return results;
}




@end
