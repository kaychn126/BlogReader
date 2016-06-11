# EBEmptyView
one line code to show emptyView in UITableView or UIScrollView

![ScreenShot](https://github.com/kaychn126/EBEmptyView/blob/master/Simulator%20Screen%20Shot.png)


#Show the emptyView
```objective-c
    //show the default view
    [_tableView eb_showDefaultEmptyView:_tableArray.count==0];
    
    //you can also set the image and text yourself
    //[_tableView eb_showEmptyView:_tableArray.count==0 withEmptyImage:@"emptyImage" withEmptyText:@"NO DATA"];
```

# Usage
```objective-c
    #import "UIScrollView+EBEmptyView.h"

    _tableArray = [NSMutableArray array];
    //query data....
    //operate data...
    [_tableView reloadData];
    
    //show the default view
    [_tableView eb_showDefaultEmptyView:_tableArray.count==0];
    
    //you can also set the image and text yourself
    //[_tableView eb_showEmptyView:_tableArray.count==0 withEmptyImage:@"emptyImage" withEmptyText:@"NO DATA"];
```
