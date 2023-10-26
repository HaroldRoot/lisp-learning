(setq *PRINT-CASE* :capitalize)

(defvar *age* 5)

(defun get-school (age)
    (case age
        (5 (print "Kindergarten"))
        (6 (print "First Grade"))
        (otherwise (print "Middle School"))))

(get-school *age*)
;;; "Kindergarten"

(terpri)
;;; puts in a new line

(defvar *agenow* 18)
(defvar *num* 5)

(when (= *agenow* 18)
    (setf *num* 18)
    (format t "Go to college you're ~d now ~%" *num*))
;;; when ���ֻ���ڲ��Ա��ʽΪ��ʱ��ִ���ӱ��ʽ�����򷵻� nil
;;; Go to college you're 18 now 

(unless (not (= *agenow* 18))
    (setf *num* 18)
    (format t "Go to college you're ~d now ~%" *num*))
;;; unless ���ֻ���ڲ��Ա��ʽΪ��ʱ��ִ���ӱ��ʽ�����򷵻� nil
;;; Go to college you're 18 now 

#|
when ���� unless ��䶼�� if ���ı��壬���ǿ����� if �������ʾ�����磺
(when test-form body-forms...) == (if test-form (progn body-forms...) nil)
(unless test-form body-forms...) == (if test-form nil (progn body-forms...))
 |#