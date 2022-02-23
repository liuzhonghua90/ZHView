# ZHView

![WechatIMG116](https://user-images.githubusercontent.com/19387301/155274182-08d58e28-961d-4267-a5ef-64f823dc891c.jpeg)


四种方式做出弹窗效果
1.代理
2.block
3.xib 节省了代码时间
以上三种都是创建view来制作弹窗
4.控制器
 
个人认为比较推荐使用block delegate模式 
block优势：可以在创建view的地方编写业务逻辑，如此，代码逻辑会更加简单清晰 
delegate优势：在业务比较复杂时使用代理
