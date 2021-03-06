(require 's)
(require 'f)
(require 'dash)
(require 'ht)

(defun ini-read-section (x)
  (let ((table (ht-create)))
    (dolist (i (--remove (equal "" it) (s-lines x)))
      (apply 'ht-set! table
	     (s-split "=" i)))
    table))

;(ini-read "helm-ahk.ini" "switch-windows" "windows")

(defun ini-read-file (x)
  (let ((table (ht-create)))
    (--map
     (-let [(a b) it]
       (ht-set! table (substring a 1) (ini-read-section b)))
     (--map
      (s-split "\]" it)
      (--remove (equal "\r\n" it) (s-slice-at "\\[" (f-read-text x 'utf-16-le)))))
    table))

(defun ini-read (file section key)
  (ht-get* (ini-read-file file) section key))

(defun ini-set-section-value (table section key value)
  (let ((section-table (ht-get table section)))
    (ht-set! section-table
	     key value)
    section-table))

(defun ini-set-value (file section key value)
  (let ((table (ini-read-file file)))
    (ht-set!
     table
     section
     (ini-set-section-value table section key value))
    table))

(defun kv-to-line0 (k v)
  (format "%s=%s" k v))

(defun kv-to-line1 (x)
  (s-join "\r\n" (ht-map 'kv-to-line0 x)))

(defun kv-to-line2 (k v)
  (format "[%s]\r\n%s" k (kv-to-line1 v)))

(defun kv-to-line (x)
  (s-join "\r\n" (ht-map 'kv-to-line2 x)))

(defun ini-write (value file section key)
  (f-write-text
   (kv-to-line
    (ini-set-value file section key value))
   'utf-16-le
   file))

(provide 'ini-parser)
