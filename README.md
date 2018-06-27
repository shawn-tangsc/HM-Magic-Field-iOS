# HM-Magic-Field-iOS
针对weex做的一个有placeholder上移动画的input自定义 component 

使用方式
```
            <hm-magic-input :value="registerForm.name" @input="onInput" class="register_input" placeholder="请输入您的名字" animationFont="13" moveDistance="20" ></hm-magic-input>
```
其中：
animationFont ： placeholder 上移后的大小
moveDistance ： placeholder 上移的距离
