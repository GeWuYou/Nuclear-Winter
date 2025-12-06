# 代码规范

## 命名
  
文件夹，文件，节点：小写+下划线命名，比如game_manager.gd，main_menu.tscn，player_attack  
变量，信号：小写+下划线，bool类型使用is_,has_开头  
常量：大写+下划线  
函数：小写+下划线，bool返回值类型使用is_,has_开头  

## 注释
多人协作还是尽量写一下，比如重要的逻辑实现或函数对应功能  

## AI的使用
一定注意，修改别人代码时先检查好ai有没有删除必要依赖再进行采用  

# 文件夹结构
小写命名  
assets：存放资源类文件，如美术资源，音乐资源，音效资源等。下可细分art,music,sfx等。  
scenes：存放场景.tscn和对应场景的脚本。如有一个场景叫player，便在scenes下新建player文件夹，将player.tscn和player.gd存放到里面。  
resources：存放.tres文件  
global：用于存放单例，管理器，这些类一般为全局注册或者自身采用单例模式创建。如音频管理器AudioManager,场景管理器SceneManager,资源，全局变量管理器GameManager，信号管理器SignalManager等等。  
addons：插件文件夹(如果有)，其他未改变默认颜色的文件夹也均为插件相关文件夹  
  
```md
root[Godot项目根目录]
    ├── assets[**资源管理文件夹**]
    │   ├── art[**美术资源**]
    │   │   
    │   ├── music[**音乐资源**]
    │   │   
    │   ├── sfx[**音效资源**]
    |   |
    │   ├── material[**存放未投入使用的各类素材**]
    |
    ├── scenes[**场景文件**]
    |   │  
    |   ├── main_menu[**主菜单**]
    |   |
    |   ├── UI[**UI组件**]
    |   |
    |   ├── main_scene[**主场景**]
    |   |
    |   ├── level[**关卡或章节场景**]
    |
    ├── resources[**资源引用文件(.tres)**]
    |
    ├── global[**全局管理器**]
    |
    ├── shader[**着色器**]
  
```
# 分支
对于分支，建议在通过创建issue的方式认领任务，假设我要实现项目设置功能，那我创建一个issue，并将该issue指定给我自己，同时，从main分支新建分支名为[feat/issue编号-实现项目设置功能] 的分支，并在其中实现，当实现完成后，请务必先提交到远程，新建自己的分支，然后从main分支拉取变更，以查看是否存在冲突，如果没有则创建pr并在其中提及issue，即可在合并变更后自动关闭issue  
至于为什么要提issue是为了防止大家实现重复的功能，以及审计和追溯  
对于提交信息，一个好的提交信息应当类似 

```md

feat(battle): 实现状态系统并添加力量形态与肌肉状态

- 在Player类中增加StatusHandler组件支持
- 新增MuscleStatus和TrueStrengthFormStatus两种状态类
- 添加状态资源文件及对应的工厂函数
- 更新PlayerHandler以响应状态触发事件
- 调整场景节点结构以支持状态系统的集成
- 修改状态模板以适配新的信号机制

```
可以选择下载一个通义灵码来帮助你自动根据变更生成提交信息  