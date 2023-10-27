(defun main () 
    (let ((s (read)) (v 0)) (setq v (read)) 
        (let ((time (ceiling (/ s v)))) (setq time (+ time 10)) ; time 表示从家到学校需要的时间（分钟） 
            (let ((ans (- 480 time))) ; ans 表示最晚出发时间，用分钟表示
                (if (>= ans 0)
                    (let ((hour (floor ans 60)) (minute (mod ans 60)))
                        (format t "~2,'0d:~2,'0d~%" hour minute))
                    (let ((hour (- (floor (+ 24 (/ ans 60))) 1)) (minute (+ 60 (mod ans 60))))
                        (format t "~2,'0d:~2,'0d~%" hour minute)))))))

(main)