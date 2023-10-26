(setq *print-case* :capitalize)

(loop for x from 1 to 5
    do (print x))
#|
1 
2 
3 
4 
5
 |#

(terpri)
(terpri)

(defvar x 1)

(loop 
    (format t "~d ~%" x)
    (setq x (+ x 1))
    (when (> x 5) (return x)))
#|
1 
2 
3 
4 
5
 |#

 (terpri)

(setq x 1)

(loop for x in '(Peter Paul Mary) do
    (format t "~d ~%" x))
#|
Peter 
Paul 
Mary
 |#

(loop for y from 100 to 105 do (print y))
;;; 注意 y 之前并没有定义过
#|
100
101
102
103
104
105
 |#