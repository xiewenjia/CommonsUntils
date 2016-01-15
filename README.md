# CommonsUntils
工具类，基类等。

#### ```BaseTabelViewController```
#### ```BaseCollectionViewController```

继承于 UITabelViewController 和 UICollectionViewController 

```
/**
 *  为一个TabelView添加上拉加载 下拉刷新 
 *
 *  @param refreshTableView 
 *  @param rightNow 是否添加之后就刷新
 */
- (void)addPullUpAndPullDownToRefreshTabelView:(UITableView *)refreshTableView withRefreshNow:(BOOL)rightNow;

```

```
//下拉刷新操作 子类重写
- (void)refreshHeadDatas;

```

```
//上拉加载操作 子类重写
- (void)refreshFootDatas;

```

```
//结束刷新
- (void)endRereshingView;

```

```
/**
 *  开始加载，显示加载提示
 *
 *  @param loadingText 加载中显示的文字，如"正在加载","加载中"
 */
- (void)showHUDLoadingStart:(NSString *)loadingText;

```

```
/**
 *  加载成功后，隐藏加载提示。
 */
- (void)hideHUDLoading;

/**
 *  显示提示，之后隐藏
 *
 *  @param text 提示文字
 */
- (void)showHudWithText:(NSString *)text;

```
---

#### ```MainDefines```

 常用的宏的定义
 
 ---
#### ```RegexConst```

 常用的正则表达式
 
 ---
