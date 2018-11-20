#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <UIKit/UIColor.h>
#import <MapKit/MKAnnotation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResult : NSObject <MKAnnotation>

+ (SearchResult *)initFromJSONDictionary:(NSDictionary *)dict;

@property NSString *name;
@property NSString *address;
@property NSString *zip;
@property NSString *inspectionID;
@property NSString *restaurantID;
@property int score;
@property NSDate *date;
@property double distance;

// Decorator methods

- (NSString *)scoreString;
- (UIColor *)scoreColor;
- (NSString *)dateString;

// MKAnnotation methods

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (readonly, copy) NSString *title;
@property (readonly, copy) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
