# Tmux 笔记 
[toc]

终端复用器
### 启动与退出
- `tmux` 启动Tmux窗口
- `Ctrl-d` 或 `exit` 退出Tmux窗口

### 会话管理
- `tmux new -s <session-name>` 新建会话
- `Ctrl-b d` `tmux detach` 分离会话
- `Ctrl-b s` `tmux ls` 查看所有会话
- `tmux attach -t <session-name>` 接入会话
- `tmux kill-session -t <session-name>` 杀死会话
- `tmux switch -t <session-name>` 切换会话
- `tmux rename-session -t <session-name> <new-name>` 重命会话
- `Ctrl-b $` 重命当前会话

### 窗格操作
- `Ctrl-b %` 划分左右两个窗格
- `Ctrl-b "` 划分上下两个窗格
- `Ctrl-b 方向键` 光标切换到指定窗格
- `Ctrl-b ;` 光标切换到上一个窗格
- `Ctrl-b o` 光标切换到下一个窗格
- `Ctrl-b {` 当前窗格与上一个窗格
- `Ctrl-b }` 当前窗格与下一个窗格
- `Ctrl-b x` 关闭当前窗格
- `Ctrl-b z` 当前窗格全屏显示，再使用恢复
- `Ctrl-b Alt-方向键` 调整窗格大小
