#lang racket
(require racket/vector)
;(require test-engine/racket-tests)
(require rackunit)

; Input field
; TODO I should read out it directly with token via http
(define input "R2, L5, L4, L5, R4, R1, L4, R5, R3, R1, L1, L1, R4, L4, L1, R4, L4, R4, L3, R5, R4, R1, R3, L1, L1, R1, L2, R5, L4, L3, R1, L2, L2, R192, L3, R5, R48, R5, L2, R76, R4, R2, R1, L1, L5, L1, R185, L5, L1, R5, L4, R1, R3, L4, L3, R1, L5, R4, L4, R4, R5, L3, L1, L2, L4, L3, L4, R2, R2, L3, L5, R2, R5, L1, R1, L3, L5, L3, R4, L4, R3, L1, R5, L3, R2, R4, R2, L1, R3, L1, L3, L5, R4, R5, R2, R2, L5, L3, L1, L1, L5, L2, L3, R3, R3, L3, L4, L5, R2, L1, R1, R3, R4, L2, R1, L1, R3, R3, L4, L2, R5, R5, L1, R4, L5, L5, R1, L5, R4, R2, L1, L4, R1, L1, L1, L5, R3, R4, L2, R1, R2, R1, R1, R3, L5, R1, R4")

; A struct for holding x and y coordinates
(struct coordinates (x y))

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
                                            (+ last-state-numberic 1) (vector*-length STATE)))])))

(check-equal? (turn "S" "R") "W")
(check-equal? (turn "S" "L") "E")
(check-equal? (turn "E" "L") "N")
(check-equal? (turn "N" "R") "E")
