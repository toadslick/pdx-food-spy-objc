#import "AlertPresenter.h"

@implementation AlertPresenter

// Render an alert with a title, message, and button to dismiss.
+ (void)presentAlert:(NSString *)title withMessage:(NSString *)message forController:(UIViewController *)controller {
    if (title == nil) {
        title = @"An Error Occurred";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [alert addAction:defaultAction];
    [controller presentViewController:alert animated:YES completion:nil];
}

@end
