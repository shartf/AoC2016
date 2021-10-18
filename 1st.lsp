(require "asdf")
(require "str")
(ql:quickload "fiveam")
(use-package :5am)

(defvar input "R2, L5, L4, L5, R4, R1, L4, R5, R3, R1, L1, L1, R4, L4, L1, R4, L4, R4, L3, R5, R4, R1, R3, L1, L1, R1, L2, R5, L4, L3, R1, L2, L2, R192, L3, R5, R48, R5, L2, R76, R4, R2, R1, L1, L5, L1, R185, L5, L1, R5, L4, R1, R3, L4, L3, R1, L5, R4, L4, R4, R5, L3, L1, L2, L4, L3, L4, R2, R2, L3, L5, R2, R5, L1, R1, L3, L5, L3, R4, L4, R3, L1, R5, L3, R2, R4, R2, L1, R3, L1, L3, L5, R4, R5, R2, R2, L5, L3, L1, L1, L5, L2, L3, R3, R3, L3, L4, L5, R2, L1, R1, R3, R4, L2, R1, L1, R3, R3, L4, L2, R5, R5, L1, R4, L5, L5, R1, L5, R4, R2, L1, L4, R1, L1, L1, L5, R3, R4, L2, R1, R2, R1, R1, R3, L5, R1, R4")
(defparameter split-input (str:split ", " input))

; Structure to hold coordinates
; Default values are 0 0
(defstruct (coord (:constructor make-coord (x y)))
  (x)
  (y))

(defun turn (prev-state turn-direction)
   "A function which handles turns
    N + R -> E; N + L -> W
    E + R -> S; E + L -> N
    S + R -> W; S + L -> E
    W + R -> N; W + L -> S"
  (cond ((equal prev-state "E")
         (cond
           ((equal turn-direction "R") "S")
           ((equal turn-direction "L") "N")))
        ((equal prev-state "S")
         (cond
           ((equal turn-direction "R") "W")
           ((equal turn-direction "L") "E")))
        ((equal prev-state "W")
         (cond
           ((equal turn-direction "R") "N")
           ((equal turn-direction "L") "S")))
        ((equal prev-state "N")
         (cond
           ((equal turn-direction "R") "E")
           ((equal turn-direction "L") "W")))))

(defun add-coordinates (coord-one coord-two)
  (let ((new-coord (make-coord 0 0)))
  (setf (coord-x new-coord) (+ (coord-x coord-one) (coord-x coord-two)))
  (setf (coord-y new-coord) (+ (coord-y coord-one) (coord-y coord-two)))
  new-coord))

(defun calculate-coordinates (position direction-to-turn distance last-direction)
  "Calculates coordinates. Takes a coordinate stucture position, distance, turn direction and last direction and returns a new posn"
  (let ((new-direction (turn last-direction direction-to-turn)))
    (cond
      ((string= new-direction "E") (setf (coord-x position)
                                                  (+ (coord-x position) distance)))
      ((string= new-direction "S") (setf (coord-y position)
                                                  (- (coord-y position) distance)))
      ((string= new-direction "W") (setf (coord-x position)
                                                  (- (coord-x position) distance)))
      ((string= new-direction "N") (setf (coord-y position)
                                                  (+ (coord-y position) distance))))
    position))

; Test the turn function
(def-suite in-system
  :description "Tests for the first day")
(test turns-test :in-system
  (is (string= "S" (turn "E" "R")))
  (is (string= "N" (turn "E" "L")))
  (is (string= "W" (turn "S" "R")))
  (is (string= "E" (turn "S" "L")))
  (is (string= "N" (turn "W" "R")))
  (is (string= "S" (turn "W" "L")))
  (is (string= "E" (turn "N" "R")))
  (is (string= "W" (turn "N" "L"))))
(test calculate-coordinates-test :in-system
  (is (equalp (make-coord 2 0) (calculate-coordinates (make-coord 0 0) "R" 2 "N")))
  (is (equalp (make-coord -2 0) (calculate-coordinates (make-coord 0 0) "L" 2 "N")))
  (is (equalp (make-coord 0 2) (calculate-coordinates (make-coord 0 0) "L" 2 "E"))))
; run all tests
(fiveam:run!)
