#import "RestaurantHistoryRequest.h"

@implementation RestaurantHistoryRequest {
    JSONFetcher *jsonFetcher;
}

- (id)init {
    self = [super init];
    jsonFetcher = [JSONFetcher new];
    jsonFetcher.delegate = self;
    return self;
}

- (void)fetch:(NSString *)restaurantID {
    NSString *format = @"http://api.civicapps.org/restaurant-inspections?restaurant_id=%@";
    NSString *url = [[NSString alloc] initWithFormat:format, restaurantID];
    [jsonFetcher fetch:url];
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveDictionary:(NSDictionary *)json {
    if (self.delegate) {
        NSArray<SearchResult *> *results = [self deserializeSearchResults:json];
        [self.delegate requestDidSucceedWithResults:results];
    }
}

// The Restaurant Inspection API returns an array as the top-level JSON object only when it returns zero results.
- (void)jsonFetcher:(JSONFetcher *)fetcher didReceiveArray:(NSArray *)json {
    if (self.delegate) {
        [self.delegate requestDidSucceedWithEmptyResults];
    }
}

- (void)jsonFetcher:(JSONFetcher *)fetcher didFailWithError:(NSError *)error {
    if (self.delegate) {
        [self.delegate requestDidFailWithError:error];
    }
}

- (NSArray<SearchResult *> *)deserializeSearchResults:(NSDictionary *)json {
    NSArray<NSDictionary *> *dicts = [json objectForKey:@"results"];
    NSMutableArray<SearchResult *> *results = [NSMutableArray new];
    [dicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        SearchResult *result = [SearchResult initFromJSONDictionary:dict];
        // Only keep results for scored inspections.
        if (result.score > 0) {
            [results addObject:result];
        }
    }];
    return results;
}


@end
