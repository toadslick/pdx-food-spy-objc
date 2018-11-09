#import "SelectLocationViewController.h"
#import "CurrentLocationUpdater.h"
#import "SearchNearCoordinate.h"

@interface SelectLocationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@end

@implementation SelectLocationViewController {
    CurrentLocationUpdater *clu;
    AddressGeocoder *geocoder;
    CLLocationCoordinate2D currentCoordinate;
    SearchNearCoordinate *search;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable this button until the curent location is detected.
    self.currentLocationButton.enabled = false;
    
    // Begin detecting the current location.
    clu = [CurrentLocationUpdater new];
    clu.delegate = self;
    [clu start];
    
    // Initialize the address geocoder.
    geocoder = [AddressGeocoder new];
    geocoder.delegate = self;
    
    // Search and parse API data.
    search = [SearchNearCoordinate new];
    search.delegate = self;
}

- (IBAction)currentLocationButtonTapped:(id)sender {
    [search fetch:currentCoordinate];
}

- (IBAction)addressTextFieldSubmitted:(id)sender {
    NSString *address = self.addressTextField.text;
    if (address) {
        [geocoder geocode:address];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Stop updating the current location.
    [clu stop];
}

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didUpdateCoordinate:(CLLocationCoordinate2D)coordinate {
    self.currentLocationButton.enabled = true;
    currentCoordinate = coordinate;
}

- (void)currentLocationUpdater:(CurrentLocationUpdater *)updater didFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

- (void)addressGeocoder:(AddressGeocoder *)geocoder foundCoordinate:(CLLocationCoordinate2D)coordinate forAddress:(NSString *)address {
    [search fetch:coordinate];
}

- (void)addressGeocoder:(AddressGeocoder *)geocoder didFailWithError:(NSError *)error forAddress:(NSString *)address {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

- (void)searchDidSucceedWithResults:(NSArray<SearchResult *> *)results {
    NSLog(@"RESULTS: %@", results);
}

- (void)searchDidSucceedWithEmptyResults {
    NSLog(@"RESULTS: EMPTY");
}

- (void)searchDidFailWithError:(NSError *)error {
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

@end
