## 浏览器工作原理

### 概念

#### 浏览器是多进程模型

浏览器是多进程架构，包含

- 浏览器进程。主要负责界面显示、用户交互、子进程管理
- GPU进程
- 网络进程
- Audio Service
- Storage Service
- 渲染进程。主要任务是将 HTML、CSS和JavaScript 转换为用户与之交互的网页，排版引擎Blink和JavaScript引擎V8都运行在该进程中。默认情况下，Chrome 会为每个Tab标签创建一个渲染进程。
- 备用渲染进程
- 多个插件进程
- 多个标签页

#### 进程模型

1. **Process-per-site-instance**：就是你打开一个网站，然后从这个网站链开的一系列网站都属于一个进程。这是Chrome的默认模式。
2. **Process-per-tab**：这个简单，一个tab一个process，不论各个tab的站点有无联系，就和宣传的那样。用–process-per-tab开启。
3. **Single Process**：这个很熟悉了吧，传统浏览器的模式，没有多进程只有多线程，用–single-process开启。

### 导航

#### 输入URL

1. 浏览器进程会将URL传给网络进程。

   1. 通过进程之间的通信IPC来URL请求

2. 网络进程发起真正的URL请求。

   1. 网络进程会查找本地缓存，存在直接返回。

   2. 进行请求。

      1. 进行DNS解析，获取服务器ip地址，端口
      2. 利用ip地址和服务器建立tcp连接
      3. 构建请求头信息
      4. 发送请求头信息
      5. 服务器响应后，网络进程接收响应头和响应信息，并解析响应内容

   3. 网络进程解析响应流程

      1. 检查状态码，如果是301/302，则需要重定向，从Location自动中读取地址，重新进行第2步

         （301/302跳转也会读取本地缓存吗？这里有个疑问），如果是200，则继续处理请求。

      2. 200响应处理：检查响应类型Content-Type，如果是字节流类型，则将该请求提交给下载管理器，该导航流程结束，不再进行

3. 网络进程接收到了响应头数据，便解析响应头数据，并将数据转发给浏览器进程。

4. 浏览器进程接收到网络进程的响应头数据之后，发送“提交导航 (CommitNavigation)”消息到渲染进程。

   浏览器会根据响应头数据的Context-type来确定文件类型。html文件会交给浏览器渲染，下载文件会交给浏览器的下载管理器。

5. 渲染进程接收到“提交导航”的消息之后，便开始准备接收HTML数据，接收数据的方式是直接和网络进程建立数据管道。

6. 最后渲染进程会向浏览器进程“确认提交”，这是告诉浏览器进程：“已经准备好接受和解析页面数据了”。

7. 浏览器进程接收到渲染进程“提交文档”的消息之后，便开始移除之前旧的文档，然后更新浏览器进程中的页面状态。

   浏览器进程接收到确认消息后更新浏览器界面状态：安全、地址栏URL、前进后退的历史状态、更新web页面。

### TCP协议

### 响应

### 解析

根据响应的数据来构建 dom 和 cssdom

#### 构建DOM树

![img](https://static001.geekbang.org/resource/image/12/79/125849ec56a3ea98d4b476c66c754f79.png?wh=1142*555)

通过 JavaScript 修改DOM内容

```javascript
document.getElementsByTagName("p")[0].innerText = "black"
```

![img](https://static001.geekbang.org/resource/image/e7/74/e730aa1d73c1151c588e2f8c7e22c274.png?wh=1142*712)

#### 样式计算





### 渲染

### 交互





### 资料

https://developer.mozilla.org/zh-CN/docs/Web/Performance/How_browsers_work

https://developer.chrome.com/blog/inside-browser-part2/

http://hassansin.github.io/shared-event-loop-among-same-origin-windows
