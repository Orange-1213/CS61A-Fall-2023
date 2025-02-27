(define (curry-cook formals body) 
(if (null? (cdr formals))
  (list 'lambda formals body)
    (list 'lambda (list (car formals))
      (curry-cook (cdr formals) body)))
)

(define (curry-consume curry args)
  (if (null? args)
    curry
    (curry-consume (apply curry (list (car args))) (cdr args)))
)

(define-macro (switch expr cases)
  (switch-to-cond (list 'switch expr cases)))

(define (switch-to-cond switch-expr)
  (cons 'cond
        (map
         (lambda (case) (cons (list 'equal? (car (cdr switch-expr)) (car case)) (cdr case)))
         (car (cdr (cdr switch-expr))))))

(define (min x y)
  (if (< x y)
      x
      y))

(define (count f n i)
  (if (= i 0)
      0
      (+ (if (f n i)
             1
             0)
         (count f n (- i 1)))))

(define (is-factor dividend divisor)
  (if (equal? (modulo dividend divisor) 0)
      #t
      #f))

(define (switch-factors n)
  (switch (min (count is-factor n n) 3)
          ((1 'one)
           (2 (if (= n 1) 'one 'prime))
           (3 'composite))))