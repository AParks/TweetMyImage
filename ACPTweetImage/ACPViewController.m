//
//  ACPViewController.m
//  ACPTweetImage
//
//  Created by Anna Parks on 5/2/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import "ACPViewController.h"
#import <Social/Social.h>
#import <CoreImage/CoreImage.h>





@interface ACPViewController ()
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic, retain) UIImage *originalImage;

@end

@implementation ACPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsEditing = YES;
    self.imgPicker.delegate = self;
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//apply monochrome color to image based on slider values
-(void) filterImage{
    CIImage *beginImage = [CIImage imageWithCGImage:_originalImage.CGImage];
    CIFilter *pixelFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [pixelFilter setValue:[NSNumber numberWithFloat:1]
                   forKey:@"inputIntensity"];
    
    [pixelFilter setValue:[CIColor colorWithRed:(255*[_red value]) green:(255*[_green value]) blue:(255*[_blue value])] forKey:@"inputColor"];
    
    [pixelFilter setValue:beginImage forKey:kCIInputImageKey];
    CIImage *outputImage = [pixelFilter valueForKey:kCIOutputImageKey];
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    self.imageView.image = newImage;
}



- (IBAction) filterButtonPressed:(id)sender {
    //clear button pressed
    if ([sender tag] == 0){
        self.imageView.image = _originalImage;
        return;
    }
    [self filterImage]; //set button bressed
}

- (IBAction) chooseImage:(id)sender{
    [self presentViewController:self.imgPicker animated:YES completion:NULL];
}




- (IBAction)tweet: (id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet addImage:_imageView.image];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}




- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = _originalImage;
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self filterImage];
}

@end
