#import "UIViewController+VENTouchLock.h"

@implementation UIViewController (VENTouchLock)

- (UINavigationController *)ventouchlock_embeddedInNavigationControllerWithNavigationBarClass:(Class)navigationBarClass
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:navigationBarClass toolbarClass:nil];
    [navigationController pushViewController:self animated:NO];
    return navigationController;
}

//+ (UIViewController*)ventouchlock_topMostController
//{
//    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
//
//    while (topController.presentedViewController) {
//        topController = topController.presentedViewController;
//    }
//
//    return topController;
//}

+ (UIViewController*)ventouchlock_topMostController {
    return [UIViewController topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

@end
