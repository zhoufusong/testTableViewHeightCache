使用UITableView-FDTemplateLayoutCell如何自动通过一句代码对cell进行高度计算

##### Cocoapods安装

```
platform :ios, '8.0'

target 'testTableViewHeightCache' do
  use_frameworks!
  pod 'UITableView+FDTemplateLayoutCell'
end
```

##### swift工程中使用方法

1、建立桥接文件 testTableViewHeightCache-Bridging-Header.h

- 新建header文件，在其中添加import "UITableView+FDTemplateLayoutCell.h"
- 在build Settings下的Swift Compiler下的Objective-C Bridging Header栏设置桥接头文件路径（如testTableViewHeightCache/testTableViewHeightCache-Bridging-Header.h）

2、在heightForRowAtIndexPath方法中添加如下三种方法代码之一

- 无高度缓存

```
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 202
        return tableView.fd_heightForCell(withIdentifier: "FDFeedCellID", configuration: { (make) -> Void in
            let scell = make as! FDFeedCell
            self.configCell(cell: scell, atIndexPath: indexPath)
        
        })
    }
```

- 使用indexPath高度缓存

```
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "FDFeedCellID", cacheBy: indexPath, configuration: { (make) -> Void in
            let scell = make as! FDFeedCell
            self.configCell(cell: scell, atIndexPath: indexPath)
        })
    }
```

- 使用key缓存（需要有自定义的唯一标识符）

```
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {        
        let entity = self.feedEntitySections[indexPath.section][indexPath.row];
        return tableView.fd_heightForCell(withIdentifier: "FDFeedCellID", cacheByKey: entity.identifier as NSCopying!, configuration:{ (make) -> Void in
                let scell = make as! FDFeedCell
                self.configCell(cell: scell, atIndexPath: indexPath)
            })

    }
```

注意上述cell设置仅用于高度计算，实际cell内容仍应该在cellForRowAt方法中设置

##### 布局模式

两种模式计算cell高度，不需要设置可根据是否使用自动布局来选择模式

1、Auto layout mode（using systemLayoutSizeFittingSize）

2、Frame layout mode（using sizeThatFits）

如果强制使用Frame layout mode，在cell配置代码中 cell.fd_enforceFrameLayout = true，同时必须重载sizeThatFits方法来得到content view的高度

##### Debug log

可以设置self.tableView.fd_debugLogEnabled=true来打印高度计算和创建缓存、命中缓存的日志

