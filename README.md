# 目标

-   利用 AHK 脚本使 Emacs 能全面控制 Windows 桌面应用软件
-   Live in Emacs
-   不断扩充脚本

# 脚本列表

-   helm-ahk-sitch-windows

和 switch-to-buffer 一样切换 windows 窗口

```elisp
(add-to-list 'load-path "/path/to/helm-ahk/")
(require 'helm-ahk-switch-windows)
(global-set-key (kbd "C-c w") 'helm-ahk-switch-windows-list)
```

![helm-ahk-sitch-windows](https://github.com/HuangChen1989/helm-ahk/blob/main/Snipaste1.png)
