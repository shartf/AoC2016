#lang debug racket
(require racket/vector)
;(require test-engine/racket-tests)
(require rackunit)
(require racket/trace)
(require racket/local)
; Input field
; TODO I should read out it directly with token via http
(define input "R2, L5, L4, L5, R4, R1, L4, R5, R3, R1, L1, L1, R4, L4, L1, R4, L4, R4, L3, R5, R4, R1, R3, L1, L1, R1, L2, R5, L4, L3, R1, L2, L2, R192, L3, R5, R48, R5, L2, R76, R4, R2, R1, L1, L5, L1, R185, L5, L1, R5, L4, R1, R3, L4, L3, R1, L5, R4, L4, R4, R5, L3, L1, L2, L4, L3, L4, R2, R2, L3, L5, R2, R5, L1, R1, L3, L5, L3, R4, L4, R3, L1, R5, L3, R2, R4, R2, L1, R3, L1, L3, L5, R4, R5, R2, R2, L5, L3, L1, L1, L5, L2, L3, R3, R3, L3, L4, L5, R2, L1, R1, R3, R4, L2, R1, L1, R3, R3, L4, L2, R5, R5, L1, R4, L5, L5, R1, L5, R4, R2, L1, L4, R1, L1, L1, L5, R3, R4, L2, R1, R2, R1, R1, R3, L5, R1, R4")
(define split (string-split input ", "))

; A struct for holding x and y coordinates
(struct coord (x y) #:transparent #:mutable)
;(define posn (coord 0 0))
;(coord? posn)
;(set-coord-x! posn 2)
; A vector containing the states
(define STATE (vector "E" "S" "W" "N"))

; Function turn for managing state transition
; Following states are allowed: E, S, W, N
; Following turn directions are allowed: L and R (left and right)
; L always distracts state by index of a vector by 1, R adds by 1
; State E = x + n
; State S = y - n
; State W = x - n
; State N = y + n

(define (turn last-state turn-to)
  (let ([last-state-numberic (vector-member last-state STATE)])
    (cond
      [(eq? turn-to "L") (vector-ref STATE (modulo
                                            (- last-state-numberic 1) (vector-length STATE)))]
      [(eq? turn-to "R") (vector-ref STATE (modulo
                                            (+ last-state-numberic 1) (vector-length STATE)))])))

(check-equal? (turn "S" "R") "W")
(check-equal? (turn "S" "L") "E")
(check-equal? (turn "E" "L") "N")
(check-equal? (turn "N" "R") "E")

; Function add-coord
; Takes 2 coordinates stuctures, coord-one and coord-two
; Returns a third coordinate

(define (add-coord coord-one coord-two)
  (define new-coord (coord 0 0))
  (set-coord-x! new-coord (+ (coord-x coord-one) (coord-x coord-two)))
  (set-coord-y! new-coord (+ (coord-y coord-one) (coord-y coord-two)))
  new-coord)

; Function calculate-coordinates
; Takes a coordinate stucture posn, distance, turn direction and last stare and returns a new posn
(define (calculate-coordinates posn turn-direction distance last-state)
  (let ([new-state (turn last-state turn-direction)])
        (cond
          [(eq? new-state "E") (set-coord-x! posn
                                             (+ (coord-x posn) distance))]
          [(eq? new-state "S") (set-coord-y! posn
                                             (- (coord-y posn) distance))]
          [(eq? new-state "W") (set-coord-x! posn
                                             (- (coord-x posn) distance))]
          [(eq? new-state "N") (set-coord-y! posn
                                             (+ (coord-y posn) distance))])
        posn))

(check-equal? (calculate-coordinates (coord 0 0) "R" 2 "N")  (coord 2 0))
(check-equal? (calculate-coordinates (coord 0 0) "L" 2 "N")  (coord -2 0))
(check-equal? (calculate-coordinates (coord 0 0) "L" 2 "E")  (coord 0 2))

; Count-distance counts the distance to HQ
; takes initial position init-posn
; list of directions
;

(define (count-distance2  directions)
  (cond
    [(empty? directions) empty]
    [#RR(empty? (rest directions))
     (calculate-coordinates (coord 0 0)
                            #RR(substring
                                (first directions) 0 1)
                            (substring
                                (first directions) 1 (string-length (first directions)))
                            "N")]
    [else
     (add-coord
      (calculate-coordinates )
      (count-distance2  (rest directions)))]))

(define (for-count directions)
  (let* ([last-distance (coord 0 0)]
         [last-direction "N"]
         [results (coord 0 0)])
  (for/list ([i directions])
    ; add last coordinates with coordinates-fun results
    (set! results (add-coord last-distance
                               (calculate-coordinates
                                last-distance
                                (substring i 0 1)
                                (substring i 1 (string-length i))
                                last-direction)))
    ; save distance as last distance
    (set! last-distance (calculate-coordinates
                          last-distance
                          (substring i 0 1)
                          (substring i 1 (string-length i))
                          last-direction))
    ; save direction as last direction
    (set! last-direction (turn last-direction (substring i 0 1)))
    (display results))))


(define fi (coord 1 1))
(define sn (coord 2 2))
(add-coord fi sn)
(define test-input "R4, R3")
(define test-split (string-split test-input ", "))
(trace count-distance2)
;(count-distance2 test-split)
(trace for-count)
(for-count test-split)
