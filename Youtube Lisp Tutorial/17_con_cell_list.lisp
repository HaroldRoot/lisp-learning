(setq *print-case* :capitalize)

(cons 'superman 'batman)

(list 'superman 'batman 'flash)

(cons 'aquaman '(superman batman))

(format t "First = ~a ~%" (car '(superman batman aquaman)))
;;; Contents of the Address part of the Register
;;; First = Superman 

(format t "Everything Else = ~a ~%" (cdr '(superman batman aquaman)))
;;; Everything Else = (Batman Aquaman)

(format t "2nd Item = ~a ~%" (cadr '(superman batman aquaman flash joker)))
;;; 2nd Item = Batman

(format t "4nd Item = ~a ~%" (cadddr '(superman batman aquaman flash joker)))
;;; 4nd Item = Flash
;;; c和r之间只能有4个a/d

