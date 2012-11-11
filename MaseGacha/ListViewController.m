//
//  ListViewController.m
//  MaseGacha
//
//  Created by bibmeke on 2012/10/12.
//  Copyright (c) 2012年 bibmeke. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ImageViewを配列に突っ込んどく
    _imageViewArray = @[self.maseImage0, self.maseImage1, self.maseImage2, self.maseImage3, self.maseImage4];
    _statusArray = [@[@NO, @NO, @NO, @NO, @NO] mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 表示・非表示を切り替える
    [self setHiddenFromStatus];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Image View 

// 全部隠す
- (void)hideAllImage
{
    for(UIImageView *imageView in _imageViewArray) {
        imageView.hidden = YES;
    }
}

// 表示・非表示を切り替える
- (void)setHiddenFromStatus
{
    // まずは全部隠す
    [self hideAllImage];
    
    // 表示するかどうか
    for(NSInteger i=0; i<_imageViewArray.count; i++)
    {
        UIImageView *imageView = (UIImageView *)_imageViewArray[i];
        imageView.hidden = ![_statusArray[i] boolValue];
        
        // 保存するなら
        /*
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSNumber *number = [defaults objectForKey:[NSString stringWithFormat:@"hiddenStatus_%d", i]];
        if(number != nil) {
            BOOL isHidden = ![number boolValue];
        
            UIImageView *imageView = (UIImageView *)_imageViewArray[i];
            imageView.hidden = isHidden;
        }
         */
    }
}

#pragma mark - Segue

// 画面遷移前
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"pushToDetail"]) {
        // ランダムに選ぶ
        NSInteger selected = [self randomSelect];
        
        // 表示
        _statusArray[selected] = @YES;
        
        // 保存するなら
        /*
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:[NSString stringWithFormat:@"hiddenStatus_%d", selected]];
        [defaults synchronize];
         */
        
        // 遷移先View Controller
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        
        // UIImageViewからランダムに一つ
        UIImageView *imageView = (UIImageView *)_imageViewArray[selected];
        
        // 画像セットしておく
        controller.image = imageView.image;
    }
}

#pragma mark - Random Select

// ランダムに一つ選ぶ (最適化出来そう)
- (NSInteger)randomSelect
{
    // 確率一覧
    NSArray *appearanceRatio = @[@100, @70, @30, @10, @1];

    // sum計算
    NSInteger random=0, sum=0;
    for(NSNumber *n in appearanceRatio) {
        sum += [n integerValue];
    }
    
    // 乱数
    if(sum>0) {
        random = rand() % sum;
    }
    
    NSInteger csum=0, cur=0;
    for(NSNumber *n in appearanceRatio) {
        csum += [n integerValue];
        if(random < csum) {
            break;
        }
        cur ++;
    }
    
    return cur;
}

@end
