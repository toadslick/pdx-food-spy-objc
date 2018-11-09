#import "SelectLocationViewController.h"
#import "CurrentLocationUpdater.h"
#import "SearchNearCoordinate.h"

@interface SelectLocationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *busySpinner;
@end

@implementation SelectLocationViewController {
    CurrentLocationUpdater *clu;
    AddressGeocoder *geocoder;
    CLLocationCoordinate2D currentCoordinate;
    SearchNearCoordinate *search;
    Boolean viewIsBusy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable this button until the curent location is detected.
    self.currentLocationButton.enabled = false;
    
    // Disable the busy spinner.
    self.busySpinner.hidden = YES;
    
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
    [self setBusyState:YES];
    [search fetch:currentCoordinate];
}

- (IBAction)addressTextFieldSubmitted:(id)sender {
    [self setBusyState:YES];
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
    [self setBusyState:NO];
    NSLog(@"RESULTS: %@", results);
}

- (void)searchDidSucceedWithEmptyResults {
    [self setBusyState:NO];
    NSLog(@"RESULTS: EMPTY");
}

- (void)searchDidFailWithError:(NSError *)error {
    [self setBusyState:NO];
    NSLog(@"ERROR: %@", [error localizedDescription]);
}

- (void)setBusyState:(Boolean)isBusy {
    viewIsBusy = isBusy;
    self.currentLocationButton.enabled = !isBusy;
    self.addressTextField.enabled = !isBusy;
    
    if (isBusy) {
        [self.busySpinner startAnimating];
    } else {
        [self.busySpinner stopAnimating];
    }
}

@end
