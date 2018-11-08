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
    SearchNearCoordinate *rnl;
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
    
    // Thing to fetch and parse API data.
    rnl = [SearchNearCoordinate new];
}

- (IBAction)currentLocationButtonTapped:(id)sender {
    NSLog(@"CURRENT LOCATION: %f, %f", currentCoordinate.latitude, currentCoordinate.longitude);
    [rnl fetch:currentCoordinate];
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
    NSLog(@"CURRENT LOCATION ERROR: %@, %@", [error localizedFailureReason], [error localizedDescription]);
}

- (void)addressGeocoder:(AddressGeocoder *)geocoder foundCoordinate:(CLLocationCoordinate2D)coordinate forAddress:(NSString *)address {
    NSLog(@"GEOCODER SUCCESS: %f, %f", coordinate.latitude, coordinate.longitude);
    [rnl fetch:coordinate];
}

- (void)addressGeocoder:(AddressGeocoder *)geocoder didFailWithError:(NSError *)error forAddress:(NSString *)address {
    NSLog(@"GEOCODER ERROR: %@, %@", [error localizedFailureReason], [error localizedDescription]);
}

@end
