(define (square n) (* n n))

(define (pow base exp) 
  (cond
    ((= exp 0) 1)                              
    ((even? exp) (square (pow base (/ exp 2)))) 
    (else (* base (pow base (- exp 1))))      
  )
)

(define (repeatedly-cube n x)
  (if (zero? n)
      x
      (let ((y (* x x x))) 
         (repeatedly-cube (- n 1) y))))

(define (cddr s) (cdr (cdr s)))

(define (cadr s) 
  (car (cdr s))

)

(define (caddr s) 
  (car (cdr (cdr s)))
)
