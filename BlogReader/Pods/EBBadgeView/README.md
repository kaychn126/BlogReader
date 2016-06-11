# EBBadgeView
这是一套App显示未读标示的开源库。(A library helps UIView and UITabBar to show custom badgeView)  

包含的类有：  
UIView+EBBadgeView：提供扩展方法使UIView可以显示自定义的未读标示。  
UITabBar+EBBadgeView：提供扩展方法使UITabBar可以显示自定义的未读标示。  
UIView+EBBadgeHelper：提供扩展方法使UIView可以获取所有subViews的未读标示，并将所有的subViews的未读标示合并。另一个功能是任何UIView的标示发生变化都会一层一层向上通知所有的superView。  
EBBadgeModel：标示模型，用于封装标示属性。


# ScreenShot
![](https://github.com/kaychn126/EBBadgeView/blob/master/PPCamara_20160508205514.gif?raw=true)

# Installation
##1.cocoapods  
```ruby
pod 'EBBadgeView'
```
##2.手动（manual）    
将EBBadgeView文件夹拖入工程中（drag EBBadgeView dir to your proj）


# Usage
```objc

#import "EBBadgeView.h"

// UIView 显示BadgeView (Just one line code make UIView shows beautiful custom badgeView)
[view eb_showWithBadgeModel:badgeModel];

// 设置BadgeView的位置(set the position)
[view.eb_badgeValueView setCenter:CGPointMake(0,0)];

// UITabBar 显示自定义BadgeView(UITabBar show custom badgeView use following code)
[self.tabBarController.tabBar eb_showWithBadgeModel:badgeModel atIndex:0];

// 在UITabBar中你也可以自己设置BadgeView的位置（You can set the position like this）
[self.tabBarController.tabBar eb_setItemBadgeOffset:CGPointMake(10, 14)];

```
