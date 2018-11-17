#import "SearchResultsMapViewController.h"

@interface SearchResultsMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation SearchResultsMapViewController {
    NSArray<SearchResult *> *results;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<SearchResult *> *results = ((SearchResultsTabBarController *)[self parentViewController]).results;
    
    self.mapView.delegate = self;

    // Add pins to the map view.
    [self.mapView removeAnnotations:[self.mapView annotations]];
    [self.mapView addAnnotations:results];
    
    // Adjust the map's visible region to fit the added pins.
    [self.mapView showAnnotations:results animated:false];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    SearchResult *result = (SearchResult *)annotation;
    MKAnnotationView *reuseMarker = [mapView dequeueReusableAnnotationViewWithIdentifier:result.reuseIdentifier];
    if (reuseMarker) {
        return reuseMarker;
    } else {
         MKMarkerAnnotationView *marker = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:result.reuseIdentifier];
        marker.markerTintColor = [result scoreColor];
        return marker;
    }
}



@end
