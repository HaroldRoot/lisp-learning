(setq *PRINT-CASE* :capitalize)

(defparameter *name* 'Derek)
;;; 'Derek is a symbol

(format t "(eq *name* 'Derek) = ~d ~%" (eq *name* 'Derek))
;;; (eq *name* 'Derek) = T 

;;; symbols ������� eq ����ѯ
;;; ������һ���� equal ������ eq

(format t "(equal 'car 'truck) = ~d ~%" (equal 'car 'truck))
;;; (equal 'car 'truck) = Nil

(format t "(equal 67 67) = ~d ~%" (equal 67 67))
;;; (equal 67 67) = T 

(format t "(equal 6.7 6.7) = ~d ~%" (equal 6.7 6.7))
;;; (equal 6.7 6.7) = T 

(format t "(equal \"string\" \"String\") = ~d ~%" 
    (equal "string" "String"))
;;; (equal "string" "String") = Nil 


;;; (equal (list 1 2 3) (list 1 2 3)) = T 

;;; ����һ���� eq ������

(format t "(eq 67 67) = ~d ~%" (eq 67 67))
(format t "(eq 6.7 6.7) = ~d ~%" (eq 6.7 6.7))
(format t "(eq \"string\" \"String\") = ~d ~%" 
    (eq "string" "String"))
(format t "(eq (list 1 2 3) (list 1 2 3)) = ~d ~%" 
    (eq (list 1 2 3) (list 1 2 3)))
#|
(eq 67 67) = T 
(eq 6.7 6.7) = Nil ��������
(eq "string" "String") = Nil 
(eq (list 1 2 3) (list 1 2 3)) = Nil ��������
����������ֻ�� symbols �� eq
 |#