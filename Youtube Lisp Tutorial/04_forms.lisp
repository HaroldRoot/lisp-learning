(setq *PRINT-CASE* :capitalize)

(+ 5 4)
#|
+ is the function name
5 and 4 are the parameters or the attributes
 |#

(+ 5 (- 6 2))

(+ 5 4)
#|
[+] [5] [4] [nil]
 |#

(format t "~a" (+ 5 4))