### iOS集成Flutter方案


#### 1 创建 Flutter module
* 	命令
```
flutter create --template module my_flutter
```
* IDE创建 Android Studio 、 VSCode


#### 2 创建或者使用现有Xcode项目
* 	略

#### 3 集成

* 方法A。使用cocopods集成Flutter 自动集成 
	* 需要
	    * 本机配置好Flutter SDK环境
	    * Flutter module的项目源码
	*   优点 Flutter代码修改完重新运行Xcode就能呈现到项目上，无需重复打包framework
	* 编辑内容Podfile
	
	```
    vim Podfile
    ```
	```
	flutter_application_path = '../flutter_module’。 #module 相对于现有iOS项目的路径
	load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
	target 'FlutterXocde' do
 		 install_all_flutter_pods(flutter_application_path)
	end
	```
	
    ```
    podfile install
    ```



 * 方法B Flutter module打包成Framework 手动集成

    * 需要
	    * Flutter端手动打包
	    * 优点 Xcode端电脑无需安装Flutter SDK
	    * 缺点 Flutter修改需重复打包Framework
    * 打包Framework
    下面的示例假设你想在 some/path/MyApp/Flutter/ 目录下创建 frameworks：
    ```
    flutter build ios-framework --xcframework --no-universal --output=some/path/MyApp/Flutter/
    ```
    * [参考方法B手动导入库文件](https://flutter.cn/docs/development/add-to-app/ios/project-setup)


  * 方法C 使用 CocoaPods 在 Xcode 和 Flutter 框架中内嵌应用和插件框架 （暂未尝试）

    * 打包framework
    * 下面的示例假设你想在 some/path/MyApp/Flutter/ 目录下创建 frameworks：
    ```
    flutter build ios-framework --cocoapods --xcframework --no-universal --output=some/path/MyApp/Flutter/
    ```
    
    ```pod 'Flutter', :podspec => 'some/path/MyApp/Flutter/[build mode]/Flutter.podspec'```

   * [参考文档](https://flutter.cn/docs/development/add-to-app/ios/project-setup) 
