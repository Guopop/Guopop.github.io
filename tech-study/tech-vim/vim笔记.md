# 玩转 Vim
[toc]

### Insert 模式技巧

##### 进入 insert 模式

- `i` 在光标前插入
- `a` 在光标后插入
- `o` 在当前行下方插入一行
- `I` 在当前行首插入
- `A` 在当前行尾插入
- `O` 在当前行上方插入一行

##### insert 模式使用

- `ctrl-h` 删除一个字符
- `ctrl-w` 删除一个单词
- `ctrl-u` 删除一行

- 在终端下：
  - `ctrl-a` 移动到行首
  - `ctrl-e` 移动到行尾
  - `ctrl-b` 向前移动
  - `ctrl-f` 向后移移动

### normal 模式移动

##### 单词间移动

- `b` 以非空白符为分割，移动到上个单词首
- `w` 以非空白符为分割，移动到下个单词尾
- `B` 以空白符为分割，移动到上个单词首
- `W` 以空白符为分割，移动到下个单词尾

##### 行间搜索移动

- `f` 加一个字符，可以移动到这个字符上
- `t` 加一个字符，可以移动到这个字符前一个字符上
- `;` 匹配下一个相同的字符
- `,` 匹配上一个相同的字符
- `F` 是 `f` 的反向操作
- `T` 是 `t` 的反向操作

##### 水平移动

- `0` 移动到行首第一个字符
- `^` 移动到行首第一个非空白字符
- `$` 移动到行尾

##### 页面移动

- `gg` 移动到文件开头
- `G` 移动到文件结尾
- `ctrl-o` 快速上次移动位置
- `H` 移动到屏幕的开头
- `M` 移动到屏幕的中间
- `L` 移动到屏幕的结尾
- `ctrl-u` 向上翻页
- `ctrl-f` 向下翻页
- `zz` 将当前行置于屏幕中间

### 快速增删改查

##### 快速删除

- `x` 删除光标所在字符
- `dw` 删除光标所在字符到单词尾包括空格
- `daw` 删除光标所在单词包括单词后的空格
- `diw` 删除光标所在单词不包括单词后的空格
- `dd` 删除当前行
- `dt{char}` 删除从光标所在字符到 char 的前一个字符
- `di"` 删除双引号中的字符
- `di{` 删除大括号中的内容
- `d$` 删除到行尾
- `d0` 删除到行首
- `2dd` 删除 2 行

- `v` 选择字符 `d` 删除
- `V` 选择行 `d` 删除

##### 快速修改

- `r{char}` 替换当前字符为 char
- `s` 删除当前字符进入插入模式
- `R{char...}` 替换当前字符为 char 且持续
- `S` 删除当前行进入插入模式
- `cc` 删除当前行进入插入模式
- `caw` 删除当前单词包括单词后的空格进入插入模式
- `ciw` 删除当前单词不包括单词后的空格进入插入模式
- `ct{char}` 删除从光标所在字符到 char 的前一个字符进入插入模式
- `ci"` 删除双引号中的字符进入插入模式
- `ci{` 删除大括号中的内容并进入插入模式
- `v` 选中字符 `U` 转大写 `u` 转小写

##### 快速查询

- `/{char...}` 全局查询 char... 正向
- `?{char...}` 全局查询 char... 反向
- `n` 查找下一个匹配项
- `N` 查找上一个匹配项

##### 搜索替换

- `:% s/pattern/replace/g` 全局替换 pattern 为 replace
- `:21,25 s/pattern/replace/g` 21 到 25 行，替换 pattern 为 replace
- `:% s/pattern//n` 全局查询有多个 pattern

### 多文件操作

##### Buffer 切换

- `:ls` 列举当前缓冲区
- `:e {fileName}` 在当前页面打开另一个文件，并加载到缓冲区中
- `:b {n}` 跳转到缓冲区对应的文件
- `:b {fileName}` 跳转到缓冲区对应的文件

##### Window 窗口

- `:sp` 垂直切分窗口
- `:vs` 水平切分窗口
- `ctrl-w-{hjkl}` 窗口之间跳转

##### Tab 标签

- `:tabnew {fileName}` 重新打开一个页面
- `gt` 标签之间跳转

### 复制粘贴

- `y` 复制
- `p` 粘贴
- `yy` 复制一行
- `yiw` 复制一个单词不包括单词后空格
- `yaw` 复制一个单词包括单词后空格
- `“+ p` 复制系统剪切板内容到 vim 中

### 宏

- `q{register}` 开始录制到寄存器中`q` 结束
- `@{register}` 回放录制命令
- visual 模式下选中内容 `:normal @{register}` 对选中内容执行宏
- `:` `ctrl-p` 回填上次命令

### 补全

- `ctrl-n` `ctrl-p` 当前语义补全
- `ctrl-x` `ctrl-f` 文件路径补全
- `:r! echo %` 插入当前文件名
- `:r! echo %:p` 插入当前文件绝对路径

### 配色

- `:colorscheme ctrl+d ` 选择配色

### Vim 配置

###### 临时配置方式

- `:set nu` 显示行号
- `:syntax on` 语法高亮
- `:set hls` 搜索结果高亮
- `:set incsearch` 边搜索边高亮
- `:set autoindent` 设置缩进
- `:echo has('clipboard')` 查看当前 vim 是否支持系统剪切板
- `:set clipboard=unnamed` 复制粘贴系统剪切板内容
- `:set fileType` 设置文件类型

###### 常用设置

```javascript
" 设置行号
set number
" 开启高亮
syntax on
" 高亮搜索
set hlsearch
" 缩进
set ts=4
set expandtab
set autoindent

" 使用 crtl + h/j/k/l 切换窗口
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
```

### Vim 映射

- `:map - x` 将 x 映射成-
- `nmap` `vmap` `imap` 对应 normal, visual, insert 模式映射
- `nnoremap` `vnoremap` `inormap` 非递归映射

### Vim 插件

###### 搜索插件

- [vimawesome](https://vimawesome.com/)

###### 安装插件

- 插件安装[vim-plug](https://github.com/junegunn/vim-plug)
  - `:source %`
  - `:PlugInstall` 重启插件生效
- 启动页面[vim-startify](https://github.com/mhinz/vim-startify)
- 状态栏[vim-airline](https://github.com/vim-airline/vim-airline)
- 文件目录[nerdtree](https://github.com/preservim/nerdtree)
  - `Ctrl-t`打开关闭目录
  - `Ctrl-f`回到目录
  - `Ctrl-n`回到当前目录
- 文件搜索[ctrlp](https://github.com/ctrlpvim/ctrlp.vim)
  - `Ctrl-p` 搜索
- 快速定位[easymotion](https://github.com/easymotion/vim-easymotion)
  - `ff` 定位
- 成对编辑 vim-[surround](https://github.com/tpope/vim-surround)
  - `cs " '` 将`"`换成`'`
  - `ds "` 删除`"`
  - `ys iw "` 给单词添加`"`
  - 以上`"` 皆可以是成对的 `( [ {`
- 文件字符搜索[fzf.vim](https://github.com/junegunn/fzf.vim)
  - `brew install the_silver_searcher`实现`Ag`前提
  - `:Files path` 搜索文件
  - `:Ag chars`搜索字符
- 搜索替换[far.vim](https://github.com/brooth/far.vim)
  - `Far foo bar **/*.py`
  - `Fardo`
- 格式化[neoformat](https://github.com/sbdchd/neoformat)
  - `Ctrl-m` 格式化
- 注释[vim-commentary](https://github.com/tpope/vim-commentary)
  - `gcc` 注释/取消注释
  - `gcap` 注释段落
- git 状态显示 [nerdtree-git-plugin](https://github.com/xuyuanp/nerdtree-git-plugin)
- Markdown [vim-markdown](https://github.com/plasticboy/vim-markdown)
  - `[[`跳转上个标题
  - `]]`跳转下个标题
  - `]c`跳转标题
  - `zM`折叠所有标题
  - `zR`打开所有折叠
  - `zc`折叠当前标题
  - `za`打开当前标题
  - `:Toc`打开目录
- Markdown Preview[markdown-preview](https://github.com/iamcco/markdown-preview.nvim)
  - `Ctrl-m` 预览

