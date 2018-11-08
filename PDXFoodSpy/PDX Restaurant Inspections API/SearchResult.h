#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//    address =             {
//        city = Portland;
//        street = "2002 SE Division";
//        zip = 97202;
//    };
//    date = "2014-11-23";
//    distance = "0.7808888744396705";
//    id = 723;
//    "inspection_number" = 9005081;
//    location =             {
//        GISX = "7652087.10325";
//        GISY = "677427.267712";
//        Latitude = "45.504693000";
//        Longitude = "-122.645482000";
//    };
//    name = "Dillys Bar and Grill";
//    "restaurant_id" = 723;
//    score = 0;
//    type = FoodSvcREinspct;

NS_ASSUME_NONNULL_BEGIN

@interface SearchResult : NSObject

@property NSString *name;
@property NSString *address;
@property NSString *zip;
@property NSString *inspectionID;
@property NSString *restaurantID;
@property NSInteger score;
@property NSDate *date;
@property CLLocationCoordinate2D coordinate;

+ (SearchResult *)initFromJSONDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
