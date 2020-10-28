# 目标

-   利用 AHK 脚本使 Emacs 能全面控制 Windows 桌面应用软件
-   Live in Emacs
-   不断扩充脚本

# 脚本列表

## init-parser
和 Ahk 中的 =IniRead= =IniWrite= 功能一样
```elisp
(require 'init-parser)
;; example
(ini-read 'myfile.ini' 'section' 'key')
(ini-write 'value' 'myfile.ini' 'section' 'key')
```
## helm-ahk-sitch-windows

和 switch-to-buffer 一样切换 windows 窗口

```elisp
(require 'helm-ahk-switch-windows)
(global-set-key (kbd "C-c w") 'helm-ahk-switch-windows-list)
```

![helm-ahk-sitch-windows](https://github.com/HuangChen1989/helm-ahk/blob/master/Snipaste1.png)
