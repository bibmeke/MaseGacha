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
    NSArray *_imageViewArray;
    NSMutableArray *_statusArray;
}

@property (weak, nonatomic) IBOutlet UIImageView *maseImage0;
@property (weak, nonatomic) IBOutlet UIImageView *maseImage1;
@property (weak, nonatomic) IBOutlet UIImageView *maseImage2;
@property (weak, nonatomic) IBOutlet UIImageView *maseImage3;
@property (weak, nonatomic) IBOutlet UIImageView *maseImage4;

@end
