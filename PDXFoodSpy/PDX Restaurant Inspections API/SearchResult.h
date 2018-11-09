#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResult : NSObject

@property NSString *name;
@property NSString *address;
@property NSString *zip;
@property NSString *inspectionID;
@property NSString *restaurantID;
@property int score;
@property NSDate *date;
@property CLLocationCoordinate2D coordinate;
@property double distance;

+ (SearchResult *)initFromJSONDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
