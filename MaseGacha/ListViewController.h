//
//  ListViewController.h
//  MaseGacha
//
//  Created by bibmeke on 2012/10/12.
//  Copyright (c) 2012年 bibmeke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController
{
    NSArray *_imageViews;
    BOOL _statuses[5];
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView0;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@end
