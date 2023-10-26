(setq *print-case* :capitalize)

;;;; An association list, or alist for short, records a mapping from keys to values.

(defparameter *heroes*
    '((Superman (Clark Kent))
    (Flash (Barry Allen))
    (Batman (Bruce Wayne))))

(format t "Superman Data ~a ~%" (assoc 'superman *heroes*))
;;; Superman Data (Superman (Clark Kent)) 
#|
assoc 函数通常采用以下形式：
(assoc key alist)
assoc 函数返回一个包含键值对的列表，其中匹配到的第一个键与 key 匹配。
如果没有找到匹配的键，它返回 nil。
 |#

(format t "Superman is ~a ~%" (cadr (assoc 'superman *heroes*)))
;;; Superman is (Clark Kent)

(format t "Superman is ~a ~%" (cdr (assoc 'superman *heroes*)))
;;; Superman is ((Clark Kent)) 

(format t "Superman is ~a ~%" (caadr (assoc 'superman *heroes*)))
;;; Superman is Clark 

(defparameter *hero-size*
    '((Superman (6 ft 3 in) (230 lbs))
    (Flash (6 ft 0 in) (190 lbs))
    (Batman (6 ft 2 in) (210 lbs))))
#|
ft 英尺，in 英寸，lbs 磅
 |#

(format t "Superman is ~a ~%" (cadr (assoc 'Superman *hero-size*)))
;;; Superman is (6 Ft 3 In) 


