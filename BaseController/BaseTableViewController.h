//
//  BaseTableViewController.h
//  DecoMaterial
//
//  Created by Xwj on 15/12/11.
//  Copyright © 2015年 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoDataTableViewCell.h"

@interface BaseTableViewController : UITableViewController

@property(nonatomic, strong) UIView *showBackView;
@property(nonatomic, strong) UIButton *backButton;


/**
 *  开始加载，显示加载提示
 *
 *  @param loadingText 加载中显示的文字，如"正在加载","加载中"
 */
- (void)showHUDLoadingStart:(NSString *)loadingText;

/**
 *  加载成功后，隐藏加载提示。
 */
- (void)hideHUDLoading;

/**
 *  显示提示，之后隐藏
 *
 *  @param successString 提示文字
 */
//- (void)showHudWithText:(NSString *)text;

//添加上下拉刷新
- (void)addPullUpAndPullDownToRefreshTabelView:(UITableView *)refreshTableView withRefreshNow:(BOOL)rightNow;
- (void)addPullDownToRefreshWithTabelView:(UITableView *)refreshTableView withRefreshNow:(BOOL)rightNow;

//监听刷新的操作
- (void)refreshHeadDatas;
- (void)refreshFootDatas;

//结束刷新
- (void)endRereshingView;

- (void)backButtonAction:(UIButton *)button;

@end
