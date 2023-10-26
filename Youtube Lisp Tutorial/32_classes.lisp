(setq *print-case* :capitalize)

;;;; Classes 类 面向对象编程（OOP）和泛型函数

;;; _________________________________________________________
;;; （1）定义一个animal类，创建一个实例对象dog，输出对象的成员变量

(defclass animal()
    (name
    sound))

(defparameter *dog* (make-instance 'animal))

(setf (slot-value *dog* 'name) "Spot")

(setf (slot-value *dog* 'sound) "Woof")

(format t "~a says ~a ~%"
    (slot-value *dog* 'name) 
    (slot-value *dog* 'sound))
;;; Spot says Woof

;;; _________________________________________________________
;;; （2）定义一个mammal类，指定属性的初始化参数等

(defclass mammal()
    ((name 
        :initarg :name
        :initform (error "Must provide a name"))
    (sound 
        :initarg :sound
        :initform "No sound"
        :accessor mammal-sound)))
#||
(defclass mammal () ...)
使用defclass宏来创建一个新类。
空的括号()中没有指定基类，
这表示mammal类不继承任何其他类。

(name ...) 和 (sound ...)
这部分定义了类的两个实例变量，也就是类的属性。
属性在Common Lisp中被称为"slots"。

每个属性由以下几个部分组成：

name 和 sound 是属性的名称。

:initarg 用于指定属性的初始化参数，
这是一个关键字参数，用于在创建对象实例时传递相应的值。

:initform 用于指定属性的默认初始值。
如果在创建对象实例时没有提供初始化参数，
那么将使用这个默认值。

:accessor 用于定义一个访问器函数，
允许你读取和修改属性的值。
在这里，mammal-sound 是sound属性的访问器函数。
||#

;;; _________________________________________________________
;;; （3）给animal类实例化2个对象，king-kong和fluffy

;; 创建一个名为 *king-kong* 的 mammal 类的实例。
;; make-instance 函数用于创建一个新的类实例，
(defparameter *king-kong*
    (make-instance 'mammal :name "King Kong" :sound "Rawr"))

(format t "~a says ~a ~%"
    (slot-value *king-kong* 'name) 
    (slot-value *king-kong* 'sound))
;;; King Kong says Rawr 

(defparameter *fluffy*
    (make-instance 'mammal :name "Fluffy" :sound "Meow"))

;;; _________________________________________________________
;;; （4）定义泛型函数make-sound，定义它的mammal参数版本，使用该版本

;; 定义泛型函数 make-sound
(defgeneric make-sound (anything))
;; anything 是一个参数名称，
;; 它在泛型函数定义中用于说明该函数将接受一个名为 anything 的参数。
;; 这有助于代码的可读性，但 anything 不必在其他地方使用或引用。

;; 定义泛型函数 make-sound 的方法
;; 该方法接受一个mammal对象作为参数。
(defmethod make-sound ((the-mammal mammal))
    (format t "~a says ~a ~%"
    (slot-value the-mammal 'name) 
    (slot-value the-mammal 'sound)))

(make-sound *king-kong*)
;;; King Kong says Rawr

(make-sound *fluffy*)
;;; Fluffy says Meow

;;; _________________________________________________________
;;; （5）用泛型函数定义访问器和修改器方法

(defgeneric (setf accessor-name) (value the-mammal))
#||
在Common Lisp中，setter函数的名称通常采用 (setf accessor-name) 的形式，
其中 accessor-name 是对应的getter函数的名称。
||#

(defmethod (setf mammal-name) (value (the-mammal mammal))
    (setf (slot-value the-mammal 'name) value))

(defgeneric mammal-name (the-mammal))

(defmethod mammal-name ((the-mammal mammal))
    (slot-value the-mammal 'name))

(setf (mammal-name *king-kong*) "Kong")

(format t "I am ~a ~%" (mammal-name *king-kong*))
;;; I am Kong

(setf (mammal-sound *king-kong*) "Rawwwwwr")

(format t "Kong says ~a ~%" (mammal-sound *king-kong*))
;;; Kong says Rawwwwwr

;;; _________________________________________________________
;;; （6）继承 Inheritance

(defclass dog (mammal) ())

(defparameter *rover*
    (make-instance 'dog :name "Rover" :sound "Woof"))

(make-sound *rover*)
;; Rover says Woof