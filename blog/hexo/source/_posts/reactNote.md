---
title: react 笔记
date: 2023-03-12 22:00:00
---

### JSX

JSX 是一种类 XML 语法的语法糖。[文档链接](https://facebook.github.io/jsx/)

对于 React 而言，渲染的内容是通过 `React.createElement(component, props, ...children)` 声明的。而 JSX 是 `createElement` 函数的语法糖。可见的渲染内容是通过编译工具将 JSX 编译为若干由 `createElement` 函数组成的 js 代码。

例如

```tsx
<Header>
    <h1 className="app-header">{title}</h1>
    <div>{children}</div>
<Header/>
```

会编译为

```tsx
React.createElement(
    "header", 
    {className: "app-header"}, 
    React.createElement("h1", null, {title}),
    React.createElement("div", {rootProps}, ...)
);
```

##### 组件拆分原则

单一职责原则 Single Responsibility

关注点分离原则 Separation of Concern

一次且仅一次原则 DRY, Don‘t Repeat Yourself

简约原则 KISS, Keep It Simple & Stupid



对于拆分组件减少过度设计，减少过多的决策，降低决策疲劳（当连续做决定时，你的决定的效率和效果都会逐渐下降，甚至会做出错误的决定）。

### 虚拟DOM

React渲染是通过 React 组件 --> 虚拟DOM --> Web页面真实DOM

选择虚拟DOM，是通过牺牲性能与对原理的了解，通过减少对真实DOM的操作来减少代码Bug，可以将更多的时间投放在创造性的工作上。

##### 协调

虚拟DOM会将React组件渲染成一棵元素树。当props、state、context等发生变化时，React框架会和之前做Diff对比，将元素的变动最终体现在浏览器页面的DOM中。

##### Diff 算法

1. 本身是一棵树的结构，通过递归来处理根/子元素。对于父节点而言，更新子节点，优先通过key来进行匹配；其次是剩余的逐步遍历。
2. 对比不同的元素，并清调旧的元素和它的子树，建立新的树
   1. 对比同为HTML元素
      - Tag不同的元素React会自动清掉
      - Tag相同的元素，更新不同的值
   2. 对比React组件元素
      - 组件名不同，卸载，重新挂在新的
      - 组件名相同，保留原实例，更新props,并触发组件的生命周期方法或者Hooks

##### Fiber

现在新版的React是通过 Fiber协调引擎来进行异步协调。