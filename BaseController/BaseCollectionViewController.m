//
//  BaseCollectionViewController.m
//  DecoMaterial
//
//  Created by Xwj on 15/12/26.
//  Copyright © 2015年 X. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import <MBProgressHUD.h>
#import <MJRefresh/MJRefresh.h>
//#import <UIScrollView+EmptyDataSet.h>
@interface BaseCollectionViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,assign)BOOL isPoping;
@property (nonatomic, strong) MBProgressHUD *progressHud;

@end

@implementation BaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (MBProgressHUD *)progressHud
{
    if (!_progressHud) {
        _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_progressHud];
    }
    return _progressHud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.collectionView.emptyDataSetDelegate = self;
//    self.collectionView.emptyDataSetSource = self;
    self.navigationController.navigationBar.barTintColor = DM_NormalColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes =
    @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.collectionView.backgroundColor = DM_BackGroundColor;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
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

//#pragma mark - 没有数据显示
//
//#pragma mark - DZNEmptyDataSetSource Methods
//
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = @"";
//    
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:30.0],
//                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
//                                 NSParagraphStyleAttributeName: paragraphStyle};
//    
//    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//}
//
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = @"";
//    
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0],
//                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
//                                 NSParagraphStyleAttributeName: paragraphStyle};
//    
//    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//}
//
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIImage imageNamed:@"empty_placeholder"];
//}
//
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return DM_BackGroundColor;
//}
//
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return nil;
//}
//
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return 0;
//}
//
//
//#pragma mark - DZNEmptyDataSetSource Methods
//
//- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
//{
//    return YES;
//}
//
//- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
//{
//    return YES;
//}
//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
//{
//    [self.collectionView.header beginRefreshing];
//}
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
- (void)showHudWithText:(NSString *)text
{
    [self.progressHud setMode:MBProgressHUDModeCustomView];
    self.progressHud.labelText = text;
    [self.progressHud show:NO];
    [[[[UIApplication sharedApplication]delegate]window]addSubview:self.progressHud];
    [self.progressHud hide:YES afterDelay:2];
}

- (void)addPullDownToRefreshWithTabelView:(UICollectionView *)refreshTableView withRefreshNow:(BOOL)rightNow{
    self.collectionView = refreshTableView;
    [refreshTableView
     addLegendHeaderWithRefreshingTarget:self
     refreshingAction:@selector(refreshHeadDatas)
     dateKey:@"table"];
    if (rightNow) {
        [refreshTableView.header beginRefreshing];
    }
}

- (void)addPullUpAndPullDownToRefreshTabelView:(UICollectionView *)refreshTableView withRefreshNow:(BOOL)rightNow{
    self.collectionView = refreshTableView;
    [refreshTableView
     addLegendHeaderWithRefreshingTarget:self
     refreshingAction:@selector(refreshHeadDatas)
     dateKey:@"table"];
    if (rightNow) {
        [refreshTableView.header beginRefreshing];
    }
    
    [self.collectionView
     addLegendFooterWithRefreshingTarget:self
     refreshingAction:@selector(refreshFootDatas)];
}

- (void)refreshHeadDatas {
    
}

- (void)refreshFootDatas {
    
}
- (void)endRereshingView {
    [self.collectionView.header endRefreshing];
    [self.collectionView.footer endRefreshing];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //返回手势
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    _isPoping = NO;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    [otherGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    return NO;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (!_isPoping) {
        _isPoping = YES;
        return YES;
    }
    return NO;
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

- (void)backButtonAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
