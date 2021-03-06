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
    
    // UIImageViewを配列にまとめておく
    _imageViews = @[self.imageView0, self.imageView1, self.imageView2, self.imageView3, self.imageView4];
    
    // 状態の初期化
    for(NSInteger i=0; i<_imageViews.count; i++) {
        _statuses[i] = NO;
    }
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

// 表示・非表示を切り替える
- (void)setHiddenFromStatus
{
    // 表示するかどうか
    for(NSInteger i=0; i<_imageViews.count; i++)
    {
        UIImageView *imageView = (UIImageView *)_imageViews[i];
        imageView.hidden = !_statuses[i];
        
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
        _statuses[selected] = YES;
        
        // 保存するなら
        /*
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:[NSString stringWithFormat:@"hiddenStatus_%d", selected]];
        [defaults synchronize];
         */
        
        // 遷移先View Controller
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        
        // UIImageViewからランダムに一つ
        UIImageView *imageView = (UIImageView *)_imageViews[selected];
        
        // 画像セットしておく
        controller.image = imageView.image;
    }
}

#pragma mark - Random Select

// ランダムに一つ選ぶ (最適化出来そう)
- (NSInteger)randomSelect
{
    // 確率一覧
    NSInteger appearanceRatios[] = { 100, 70, 30, 10, 1 };

    // sum計算
    NSInteger random=0, sum=0;
    for(NSInteger i=0; i<_imageViews.count; i++)
    {
        sum += appearanceRatios[i];
    }
    
    // 乱数
    if(sum>0)
    {
        random = rand() % sum;
    }
    
    NSInteger csum=0, cur=0;
    for(NSInteger i=0; i<_imageViews.count; i++)
    {
        csum += appearanceRatios[i];
        if(random < csum) {
            break;
        }
        cur ++;
    }
    
    return cur;
}

@end
