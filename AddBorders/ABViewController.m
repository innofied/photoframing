//
//  ABViewController.m
//  AddBorders
//
//  Created by Sandip Saha on 05/11/13.
//  Copyright (c) 2013 innofied.com. All rights reserved.
//

#import "ABViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ABViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *border1;
@property (weak, nonatomic) IBOutlet UIButton *border2;
@property (weak, nonatomic) IBOutlet UIButton *border3;
@property (weak, nonatomic) IBOutlet UIButton *border4;

@end

@implementation ABViewController
@synthesize imageView;
@synthesize border1, border2, border3,border4;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    border1.tag =1;
    border2.tag =2;
    border3.tag =3;
    border4.tag =4;
    imageView.image = [UIImage imageNamed:@"car.png"];
    
    
    

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)borderButtonTapped:(UIButton *)sender {
    
    imageView.image = [UIImage imageNamed:@"car.png"];
    
    float scale ;
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00)
    {
         // RETINA DISPLAY
    	scale = 2.0;
    }
    else
    {
    	// non - retina display
    	scale = 1.0
    }
    
    UIImage *borderImage = [UIImage imageNamed:[NSString stringWithFormat:@"borderImage%i.png", sender.tag]];
    
    
    borderImage = [ ABViewController  imageWithImage:borderImage
		      scaledToSize:CGSizeMake(imageView.frame.size.width*scale, imageView.frame.size,height*scale)];
		      
    NSData *dataFromImage = UIImageJPEGRepresentation(imageView.image, 1);
    
    
    CIImage *beginImage= [CIImage imageWithData:dataFromImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *border =[CIImage imageWithData:UIImagePNGRepresentation(borderImage)];
    
    CIFilter *filter= [CIFilter filterWithName:@"CISourceOverCompositing"];  //@"CISoftLightBlendMode"];
    [filter setDefaults];
    [filter setValue:border forKey:@"inputImage"];
    
    [filter setValue:beginImage forKey:@"inputBackgroundImage"];

    CIImage *outputImage = [filter valueForKey:@"outputImage"];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    imageView.image = newImg;

    
    
}



-(UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
