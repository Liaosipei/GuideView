# GuideView
1. GuideView实现ios app初次启动时的引导界面，可修改页面数目，默认为4个页面。
2. 连续滑动页面至最后一页，出现“立即体验”按钮，点击后进入程序主页面，主页面上的“返回引导页面”按钮可实现再次返回引导页面的功能。
3. 每个页面上附有一个呈现图片的ImageView和呈现文字的Label，使用者可在主页面中修改图片和文字的各类属性。
4. 图片和文字在滑动过程中呈现渐变的动画效果，过渡自然。

#使用说明
在需要呈现启动页面的地方，比如程序的根ViewController.m中的viewDidAppear函数中加入以下代码即可进入启动页面：

GuideViewController *guide=[[GuideViewController alloc]init]; 

guide.delegate=self; 

[self presentViewController:guide animated:YES completion:nil]; 

