//
//  BlogReaderAppDelegate.m
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import "BRBlogReaderAppDelegate.h"
#import "BRBlogListViewController.h"
#import "BRAutherListViewController.h"
#import "BRConfigs.h"

@interface BRBlogReaderAppDelegate ()

@end

@implementation BRBlogReaderAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BRBlogListViewController *blogListVc = [[BRBlogListViewController alloc] init];
    UINavigationController *blogListNav = [[UINavigationController alloc] initWithRootViewController:blogListVc];
    blogListNav.view.backgroundColor = [UIColor whiteColor];
    UITabBarItem *blogListItem = [[UITabBarItem alloc] init];
    [blogListItem setImage:[UIImage imageNamed:@"tabbar_blog_normal"]];
    [blogListItem setSelectedImage:[UIImage imageNamed:@"tabbar_blog_select"]];
    [blogListItem setTitle:@"博客"];
    blogListVc.tabBarItem = blogListItem;
    
    BRAutherListViewController *autherListVc = [[BRAutherListViewController alloc] init];
    UINavigationController *autherListNav = [[UINavigationController alloc] initWithRootViewController:autherListVc];
    autherListNav.view.backgroundColor = [UIColor whiteColor];
    UITabBarItem *autherListItem = [[UITabBarItem alloc] init];
    [autherListItem setImage:[UIImage imageNamed:@"tabbar_auther_normal"]];
    [autherListItem setSelectedImage:[UIImage imageNamed:@"tabbar_auther_select"]];
    [autherListItem setTitle:@"博主"];
    autherListVc.tabBarItem = autherListItem;
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.view.backgroundColor = [UIColor whiteColor];
    tabbarController.viewControllers = [NSArray arrayWithObjects:blogListNav,autherListNav, nil];
    tabbarController.tabBar.tintColor = kRGBColor(71,71,71);
    
    //custom SVProgressHUD
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.6f]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
