(setq *PRINT-CASE* :capitalize)

#|
ΩÈ…‹ equalp µƒ”√∑®
 |#

(format t "(equalp 1.0 1) = ~d ~%" (equalp 1.0 1))
;;; (equalp 1.0 1) = T 

(format t "(equalp \"string\" \"String\") = ~d ~%" 
    (equalp "string" "String"))
;;; (equalp "string" "String") = T 