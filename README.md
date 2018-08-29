# SSMagicInputCell
## 安装
直接导入SSMagicInputCell文件夹，因为内部采用Masonry布局，所以需要导入Masonry框架，或者用系统提供的约束进行重写。
## 如何使用
1.在所需要使用的ViewController中导入#import "SSMagicInputCell.h"，然后再cellForRow方法中：
```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSMagicInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    //maxlength:设置允许输入的最大文字数
    [cell updateCellWithLeft:@"左边文字" right:@"右边内容" placeholder:@"请输入内容" maxLength:20];
    
    return cell;
}
```
2.实现SSMagicInputCellDelegate
```
//输入变化
- (void)ss_textViewDidChange:(SSTextView *)textView {
    
}

//输入换行
- (void)ss_textViewCell:(SSMagicInputCell *)cell textHeightChange:(NSString *)text {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
```
具体使用可以参考Demo，简单易用，不用再为不能实时换行而苦恼。
## 效果
![image](https://github.com/RockXeng/SSMagicInputCell/blob/master/DemoGif/demoGif.gif)

## 关于作者
以下是我的博客和公众号，你们可以在这里找到我，我会不定期分享一些技术文章，一起探索iOS的奥秘。。。

大圣的博客：[https://rockxeng.cn](https://rockxeng.cn)

大圣的公众号：![image](https://github.com/RockXeng/SSMagicInputCell/blob/master/DemoGif/gzh.jpg)
