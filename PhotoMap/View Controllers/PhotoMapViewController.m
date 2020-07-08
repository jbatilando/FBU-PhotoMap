//
//  PhotoMapViewController.m
//  PhotoMap
//
//  Created by emersonmalca on 7/8/18.
//  Copyright © 2018 Codepath. All rights reserved.
//

#import "PhotoMapViewController.h"
#import <MapKit/MapKit.h>
#import "LocationsViewController.h"

@interface PhotoMapViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UIImage *selectedImage;
@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.map setRegion:sfRegion animated:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // Assign the image to a property so that it can be used later
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    self.selectedImage = originalImage;
    // Dismiss the modal camera view controller you previously presented.
    [self dismissViewControllerAnimated:YES completion:^{
        // Launch the LocationsViewController in the completion block of dismissing the camera modal using the segue identifier tagSegue.
        [self performSegueWithIdentifier:@"tagSegue" sender:nil];
    }];
}

- (IBAction)didTapOnButton:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"tagSegue"]) {
        LocationsViewController *locationsViewController = [segue destinationViewController];
        locationsViewController.delegate = self;
    }
}


- (void)locationsViewController:(id)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    // Pop to VC
    [self.navigationController popToViewController:self animated:YES];
}

@end
