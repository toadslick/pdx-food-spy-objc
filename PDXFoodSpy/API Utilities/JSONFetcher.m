#import "JSONFetcher.h"

@implementation JSONFetcher

- (void)fetch:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (self.delegate) {
            if (error) {
                [self.delegate jsonFetcher:self didFailWithError:error];
            } else {
                [self parseJSON:data];
            }
        }
    }];
    [task resume];
}

- (void)parseJSON:(NSData *)data {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [self.delegate jsonFetcher:self didFailWithError:error];
            } else {
                if ([json isKindOfClass:[NSDictionary class]]) {
                    [self.delegate jsonFetcher:self didReceiveDictionary:json];
                } else if ([json isKindOfClass:[NSArray class]]) {
                    [self.delegate jsonFetcher:self didReceiveArray:json];
                }
            }
        });
    });
}

@end
