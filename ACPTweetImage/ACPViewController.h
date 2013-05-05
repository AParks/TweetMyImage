//
//  ACPViewController.h
//  ACPTweetImage
//
//  Created by Anna Parks on 5/2/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACPViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UISlider *red;
@property (nonatomic, retain) IBOutlet UISlider *green;
@property (nonatomic, retain) IBOutlet UISlider *blue;


- (IBAction) chooseImage:(id)sender;
- (IBAction) tweet: (id)sender;
- (IBAction) filterButtonPressed:(id)sender;





@end
