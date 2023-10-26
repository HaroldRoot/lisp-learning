(setq *print-case* :capitalize)

;;;; Hash Table 哈希表

(defparameter people (make-hash-table))

(setf (gethash '102 people) '(Paul Smith))
(setf (gethash '103 people) '(Sam Smith))

(format t "~a ~%" (gethash '102 people))
;;; (Paul Smith)

(maphash #'(lambda (k v) (format t "~a = ~a ~%" k v)) people)
#|
102 = (Paul Smith) 
103 = (Sam Smith)
 |#

(remhash '103 people)
(maphash #'(lambda (k v) (format t "~a = ~a ~%" k v)) people)
;;; 102 = (Paul Smith)