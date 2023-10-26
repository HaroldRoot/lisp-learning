(setq *print-case* :capitalize)

;;;; Structures 结构体

(defstruct customer name address id)

(defvar paulsmith (make-customer
    :name "Paul Smith"
    :address "123 Main"
    :id 1000))

(format t "~a ~%" (customer-name paulsmith))
;;; Paul Smith 

(setf (customer-address paulsmith) "125 main")

(write paulsmith)
;;; #S(Customer :Name "Paul Smith" :Address "125 main" :Id 1000)

(terpri)

(defvar sally-smith-1001 (make-customer
    :name "Sally Smith"
    :address "126 main"
    :id 1001))

(write sally-smith-1001)
;;; #S(Customer :Name "Sally Smith" :Address "126 main" :Id 1001)