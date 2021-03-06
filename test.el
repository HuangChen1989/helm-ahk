(require 'ht)

;(s-equals? (car (s-split "=" (caar (s-match-strings-all "^[^\[].*=.*" (f-read-text "myfile.ini" 'utf-8))))) "key2")

(setq table (ht-create 's-equals))
(dolist (x (s-match-strings-all "^[^\[].*=.*" (f-read-text "myfile.ini" 'utf-8)))
  (let* ((ab (s-split "=" (car x)))
	     (a (s-trim (car ab)))
	     (b (s-trim (cadr ab))))
    (ht-set! table a b)))
(ht-get table "key2")
(equal "key2" "key2")
(ht-set! table "key2" "sdfs")
(ht-set! table "key2" "sefwfwef")


(defun IniRead0 (table file)
  (let* ((file-text (f-read-text file 'utf-16))
	 (lines (s-match-strings-all "^[^\[].*=.*" file-text)))
    (dolist (x lines)
      (let* ((ab (s-split "=" (car x)))
	     (a (car ab))
	     (b (cadr ab)))
	    (ht-set! table a b)))))


(defun IniRead (file key)
  (let ((table (ht-create)))
    (progn (IniRead0 table file)
	  (ht-get table key))))

(defun IniWrite (value file key)
  (let ((table (ht-create)))
    (progn
      (IniRead0 table file)
      (ht-set! table key value)
      (f-write "[values]\n" 'utf-16 file)
      (ht-map
       (lambda (k v)
	 (f-append (format "%s=%s\n" k v) 'utf-16 file))
       table))))

;(IniWrite "this is 8" "myfile.ini" "key2")
;(IniRead "myfile.ini" "key2")

;(let ((table (ht-create)))
;  (progn
;    (IniRead0 table "myfile.ini")
;     (ht-get table "key2")))
