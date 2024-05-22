(define (ascending? s) 
(or (null? s)
    (null? (cdr s))
        (and (<= (car s) (car (cdr s)))
            (ascending? (cdr s))))
)


(define (my-filter pred s) 
(define (even? n)
    (if (= n 0)
        #t
        (odd? (- n 1))))
(define (odd? n)
    (if (= n 0)
        #f
        (even? (- n 1))))

(cond ((null? s) nil)
    ((pred (car s))
    (cons (car s) (my-filter pred (cdr s))))
    (else (my-filter pred (cdr s))))
)

(define (interleave lst1 lst2) 
    (if (null? lst1)
        lst2
        (if (null? lst2)
            lst1
            (cons (car lst1)
                (interleave lst2 (cdr lst1)))))

)

(define (no-repeats s) 
(define (member element lst)
    (cond ((null? lst) #f)
        ((equal? element (car lst)) #t)
        (else (member element (cdr lst)))))
  
(define (helper seen lst)
    (cond ((null? lst) nil)
        ((member (car lst) seen) (helper seen (cdr lst)))
        (else (cons (car lst) (helper (cons (car lst) seen) (cdr lst))))))
  
(helper nil s)
)
