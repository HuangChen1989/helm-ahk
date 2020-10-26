(require 'helm)
(require 'f)
(require 's)

(setq helm-ahk-switch-windows-dirname (f-dirname load-file-name))
(setq helm-ahk-disk (s-left 2 helm-ahk-switch-windows-dirname))

(defun cd-load-file-path-and-open-with-start-fn (f)
  (shell-command-to-string
   (format "%s & cd %s & start %s"
	   helm-ahk-disk
	   helm-ahk-switch-windows-dirname
	   (concat helm-ahk-switch-windows-dirname "/" f))))

(setq helm-ahk-switch-windows--list '())

(defun helm-ahk-switch-windows-reload-list ()
  "Reload Ahk list."
  (interactive)
  (progn
    (setq
     helm-ahk-switch-windows--list
     (s-split "," (f-read-text (concat helm-ahk-switch-windows-dirname "/windows.txt") 'utf-8)))))

(defun helm-ahk-open-select-window (_candidate)
  (progn
    (f-write
     (car (helm-marked-candidates))
     'utf-8
     (concat helm-ahk-switch-windows-dirname "/select-window.txt"))
    (cd-load-file-path-and-open-with-start-fn "open-select-window.ahk")))

(defvar helm-ahk-switch-windows-source
  (helm-build-in-buffer-source "Ahk::List"
    :init (lambda ()
	    (cd-load-file-path-and-open-with-start-fn "list-windows.ahk"))
    :data (lambda ()
	    (progn
	      (cd-load-file-path-and-open-with-start-fn "list-windows.ahk")
	      (helm-ahk-switch-windows-reload-list)
	      helm-ahk-switch-windows--list))
    :candidate-number-limit 9999
    :coerce (lambda (candidate) candidate)
    :action 'helm-ahk-open-select-window))

(defun helm-ahk-switch-windows-list ()
  "Search Ahk Bookmark using `helm'."
  (interactive)
  (helm :sources 'helm-ahk-switch-windows-source
        :prompt "Find Ahk: "
        :buffer "*helm ahk list*"))

(provide 'helm-ahk-switch-windows)
