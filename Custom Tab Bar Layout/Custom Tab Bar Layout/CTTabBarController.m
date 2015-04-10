//
//  CTTabBarController.m
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/8/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "CTTabBarController.h"
#import "CTTabItem.h"
#import "UIView+CTView.h"

@interface CTTabBarController ()
@property (nonatomic, readwrite, assign) NSInteger controlViewHeight;
@end

@implementation CTTabBarController {
    __weak IBOutlet UIView *_tabBar;
    __weak IBOutlet UIView *_containerView;
    __weak IBOutlet UIView *_headerView;
    __weak IBOutlet UIImageView *_imageView;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_subTitleLabel;
    __weak UIViewController *_topViewController;
    NSMutableArray *_tabItems;
}

+ (instancetype)tabBarControllerWithViewControllers:(NSArray *)viewControllers {
    CTTabBarController *viewController = [[UIStoryboard storyboardWithName:@"CTTabBar" bundle:nil] instantiateViewControllerWithIdentifier:@"CTTabBarController"];
    viewController.viewControllers = viewControllers;
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tabItems = [NSMutableArray new];
    
    _imageView.image = self.headerImage;
    _titleLabel.text = self.headerTitle;
    _subTitleLabel.text = self.headerSubTitle;
    
    for (UIViewController *viewController in self.viewControllers) {
        [self addChildViewController:viewController];
        [_containerView addSubview:viewController.view];
        
        UITabBarItem *tabBarItem = viewController.tabBarItem;
        
        CTTabItem *tabItem = [CTTabItem tabItemWithTitle:tabBarItem.title image:tabBarItem.image tag:tabBarItem.tag];
        [tabItem addTarget:self action:@selector(tabItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [tabItem showLayoutBordersWithColor:[UIColor yellowColor]];
        
        [_tabBar addSubview:tabItem];
        
        [_tabItems addObject:tabItem];
    }
    
    _topViewController = [self.viewControllers lastObject];
    
    self.controlViewHeight = _headerView.height + _tabBar.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    for (UIViewController *viewController in self.viewControllers) {
        viewController.view.frame = _containerView.bounds;
    }
    
    CGFloat x = 0, y = 0, width = CGRectGetWidth(_tabBar.bounds)/self.viewControllers.count, height = CGRectGetHeight(_tabBar.bounds);
    for (UIView *subView in _tabBar.subviews) {
        if ([subView isKindOfClass:[CTTabItem class]]) {
            subView.frame = CGRectMake(x, y, width, height);
            x = x + CGRectGetWidth(subView.bounds);
        }
    }
}

- (void)setHeaderImage:(UIImage *)headerImage {
    _headerImage = headerImage;
    _imageView.image = headerImage;
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    _headerTitle = headerTitle;
    _titleLabel.text = headerTitle;
}

- (void)setHeaderSubTitle:(NSString *)headerSubTitle {
    _headerSubTitle = headerSubTitle;
    _subTitleLabel.text = headerSubTitle;
}

- (void)displaceTabBar:(CGFloat)displacement {
    //slide tab bar out
    CGRect frame = _tabBar.frame;
    CGFloat y = frame.origin.y + displacement;
    frame.origin.y = y;
    _tabBar.frame = frame;
    
    //slide header view
    frame = _headerView.frame;
    y = frame.origin.y + displacement;
    frame.origin.y = y;
    _headerView.frame = frame;
    
    //scale image view size
    BOOL bouncing = _headerView.top > 0;
    BOOL isHeaderViewShowing = _headerView.bottom > 0;
    if (isHeaderViewShowing && !bouncing) {
        frame = _imageView.frame;
        CGSize size = CGSizeMake(frame.size.height + displacement, frame.size.width + displacement);
        NSLog(@"size w: %f, h %f", size.width, size.height);
        if (size.height > 150) {
            size.height = 150;
            size.width = 150;
        }
        else if (size.height < 40) {
            size.height = 40;
            size.width = 40;
        }
        frame.size = size;
        _imageView.frame = frame;
        
        //center image view
        _imageView.center = CGPointMake(self.view.center.x, _imageView.center.y);
    }

}


- (void)tabItemPressed:(UIButton *)button {
    NSInteger index = [_tabItems indexOfObject:button];
    UIViewController *viewController = [_viewControllers objectAtIndex:index];
    [_containerView bringSubviewToFront:viewController.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
