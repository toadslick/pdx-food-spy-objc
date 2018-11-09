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
    NSString *format = @"http://api.civicapps.org/restaurant-inspections/near/%f,%f?since=%@&limit=%i&distance=%f";
    return [[NSString alloc] initWithFormat:format, coordinate.longitude, coordinate.latitude, @"2014-01-01", 50, 0.5];
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveDictionary:(NSDictionary *)json {
    NSArray<SearchResult *> *results = [self buildSearchResults:json];
    NSLog(@"RESULTS: %@", results);
}

// The Restaurant Inspection API returns an array as the top-level JSON object only when it returns zero results. 
- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveArray:(NSArray *)json {
    NSLog(@"RESULTS: EMPTY");
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

- (NSArray<SearchResult *> *)buildSearchResults:(NSDictionary *)json {
    NSArray<NSDictionary *> *dicts = [json objectForKey:@"results"];
    NSMutableDictionary<NSString *, SearchResult *> *latestResults = [NSMutableDictionary new];
    [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // Only keep results for which the type is "FoodSvcSemi".
        NSString *type = [dict objectForKey:@"type"];
        if ([type isEqualToString:@"FoodSvcSemi"]) {
            SearchResult *result = [SearchResult initFromJSONDictionary:dict];
            
            // Only keep the latest result for each restaurant.
            // Store each result in a dictionary according to the restaurant ID.
            SearchResult *previousResult = [latestResults objectForKey:result.restaurantID];
            
            // Use this result if it has a later inspection date than the previous result.
            if (previousResult) {
                if ([[result.date laterDate:previousResult.date] isEqualToDate:result.date]) {
                    [latestResults setObject:result forKey:result.restaurantID];
                }

            // If a result doesn't exist for the restaurant ID, use this result.
            } else {
                [latestResults setObject:result forKey:result.restaurantID];
            }
        }
    }];
    
    return [latestResults allValues];
}




@end
