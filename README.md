# HM-Magic-Field-iOS
针对weex做的一个有placeholder上移动画的input自定义 component 

### 引用方式

在pod中添加
```
 pod 'HMWeexMagicField', :git => 'https://github.com/shawn-tangsc/HM-Magic-Field-iOS.git', :tag => '1.0.1'
```
然后重新pod update，由于插件内部自动注册，所以引入后不需要原生端再有操作，直接可以如下方式使用。

### 使用方式

```
<hm-magic-input :value="registerForm.name" @input="onInput" class="register_input" placeholder="请输入您的名字" animationFont="13" moveDistance="20" ></hm-magic-input>
```
### 效果
![](https://ws1.sinaimg.cn/large/006tNc79gy1fsplpj4xvhj309l04hdfm.jpg)


### 说明：
所有的使用方式和weex 自带的input一样，因为继承了WXEditComponent 类

### 其中：
animationFont ： placeholder 上移后的大小
moveDistance ： placeholder 上移的距离
