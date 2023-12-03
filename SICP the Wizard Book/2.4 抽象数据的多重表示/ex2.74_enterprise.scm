;;;; a)

#||
假设 file-division 能获取参数 personnel-file 中的部门名称
(get <op> <type>) 能返回对应的过程
部门名称就是 <type>
||#

(define (get-record employee-name personnel-file)
  ((get 'get-record (file-division personnel-file))
   employee-name
   personnel-file))

;;;; b)

(define (get-salary employee-record personnel-file)
  ((get 'get-salary (file-division personnel-file))
   employee-record))

;;;; c)

(define (find-employee-record employee-name files)
  (if (null? files)
      (error "No such employee:
              FIND-EMPLOYEE-RECORD"
             (list employee-name files))
      (or (get-record employee-name (car files))
          (find-employee-record employee-name (cdr files)))))

;;;; d)

#||
新公司需要
(put 'get-record <新公司每一个部门的名称> <通过员工名字和人事文件查找员工记录的过程>)
(put 'get-salary <新公司每一个部门的名称> <通过员工记录查找员工薪水的过程>)
||#