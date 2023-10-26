(setq *PRINT-CASE* :capitalize)

(format t "(expt 4 2) = ~d ~%" (expt 4 2))
;;; (expt 4 2) = 16 
;;; 4的2次方

(format t "(sqrt 8) = ~d ~%" (sqrt 8))
;;; (sqrt 8) = 2.828427 

(format t "(exp 1) = ~d ~%" (exp 1))
;;; (exp 1) = 2.7182817 
;;; 接受整数或浮点数作为参数
;;; 返回自然对数的底数 e（约等于 2.71828）的幂

(format t "(log 1000 10) = ~d ~%" (log 1000 10))
;;; (log 1000 10) = 3.0 

(format t "(eq 'dog 'dog) = ~d ~%" (eq 'dog 'dog))
;;; (eq 'dog 'dog) = T

(format t "(floor 5.5) = ~d ~%" (floor 5.5))
;;; (floor 5.5) = 5 

(format t "(ceiling 5.5) = ~d ~%" (ceiling 5.5))
;;; (ceiling 5.5) = 6

(format t "(max 5 10) = ~d ~%" (max 5 10))
;;; (max 5 10) = 10 

(format t "(min 5 10) = ~d ~%" (min 5 10))
;;; (min 5 10) = 5 

(format t "(oddp 15) = ~d ~%" (oddp 15))
;;; (oddp 15) = T 

(format t "(evenp 15) = ~d ~%" (evenp 15))
;;; (evenp 15) = Nil

(format t "(numberp 2) = ~d ~%" (numberp 2))
;;; (numberp 2) = T 

(format t "(null nil) = ~d ~%" (null nil))
;;; (null nil) = T