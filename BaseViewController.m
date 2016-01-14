//
//  BaseViewController.m
//  DecoMaterial
//
//  Created by Xwj on 15/12/11.
//  Copyright © 2015年 X. All rights reserved.
//

#import "BaseViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *progressHud;

@property(nonatomic, strong) UITableView *showTabelView;

@property(nonatomic, strong) UIView *showBackView;

@property(nonatomic,assign)BOOL isPoping;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = DM_NormalColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes =
                            @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.view.backgroundColor = DM_BackGroundColor;

    self.edgesForExtendedLayout = UIRectEdgeBottom;
    // Do any additional setup after loading the view.
    
    
    
    //返回按钮
    self.navigationItem.backBarButtonItem.title = @"";
    self.navigationItem.hidesBackButton = YES;
    
    UIImage *backImage = ImageNamed(@"backN.png");
    UIButton *backButtons = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton = backButtons;
    backButtons.backgroundColor = [UIColor clearColor];
    [backButtons setImage:backImage forState:UIControlStateNormal];
    [backButtons setImage:ImageNamed(@"backH.png")
                 forState:UIControlStateHighlighted];
    backButtons.frame = CGRectMake(0, 0, 44, 44);
    [backButtons addTarget:self
                    action:@selector(backButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [backButtons setImageEdgeInsets:UIEdgeInsetsMake(10, 6, 10, 28)];
    backButtons.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *leftBarButton =
    [[UIBarButtonItem alloc] initWithCustomView:backButtons];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (MBProgressHUD *)progressHud
{
    if (!_progressHud) {
        _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_progressHud];
    }
    return _progressHud;
}

#pragma mark - 菊花加载提示
/**
 *  开始加载，显示加载提示
 *
 *  @param loadingText 加载中显示的文字，如"正在加载","加载中"
 */
- (void)showHUDLoadingStart:(NSString *)loadingText
{
    [self.progressHud setMode:MBProgressHUDModeIndeterminate];
    [self.progressHud setLabelText:loadingText];
    [self.progressHud show:YES];
    [self.view bringSubviewToFront:self.progressHud];
}

/**
 *  加载成功后，隐藏加载提示。
 */
- (void)hideHUDLoading
{
    [self.progressHud hide:YES afterDelay:0.5];
}

/**
 *  显示提示，之后隐藏
 *
 *  @param successString 提示文字
 */
//- (void)showHudWithText:(NSString *)text
//{
//    [self.progressHud setMode:MBProgressHUDModeCustomView];
//    self.progressHud.labelText = text;
//    [self.progressHud show:NO];
//    [self.view bringSubviewToFront:self.progressHud];
//    [self.progressHud hide:YES afterDelay:2];
//}

- (void)addPullDownToRefreshWithTabelView:(UITableView *)refreshTableView {
    self.showTabelView = refreshTableView;
    
    [refreshTableView
     addLegendHeaderWithRefreshingTarget:self
     refreshingAction:@selector(refreshHeadDatas)
     dateKey:@"table"];
    
    [refreshTableView.header beginRefreshing];
}

- (void)addPullUpAndPullDownToRefreshTabelView:(UITableView *)refreshTableView {
    self.showTabelView = refreshTableView;
    
    [refreshTableView
     addLegendHeaderWithRefreshingTarget:self
     refreshingAction:@selector(refreshHeadDatas)
     dateKey:@"table"];
    [refreshTableView.header beginRefreshing];
    [self.showTabelView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(refreshFootDatas)];
}

- (void)refreshHeadDatas {
}

- (void)refreshFootDatas {
}

- (void)requestDataAgain {
    [self.showTabelView.header beginRefreshing];
}


- (void)endRereshingView {
    [self.showTabelView.header endRefreshing];
    [self.showTabelView.footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    if (self.navigationController.viewControllers.count > 0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _isPoping = NO;
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)backButtonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
