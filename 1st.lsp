(require "asdf")
(require "str")
(ql:quickload "fiveam")
(ql:quickload "iterate")
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
  (cond ((string= prev-state "E")
         (cond
           ((string= turn-direction "R") "S")
           ((string= turn-direction "L") "N")))
        ((string= prev-state "S")
         (cond
           ((string= turn-direction "R") "W")
           ((string= turn-direction "L") "E")))
        ((string= prev-state "W")
         (cond
           ((string= turn-direction "R") "N")
           ((string= turn-direction "L") "S")))
        ((string= prev-state "N")
         (cond
           ((string= turn-direction "R") "E")
           ((string= turn-direction "L") "W")))))

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

(defun count-coordinates (split-input)
  "Takes a list of coordinates and returns coordinates with distance (structure)"
  (let* ((ldir "N")
        (lcoord (make-coord 0 0)))
    (dolist (item split-input)
      (setf lcoord (calculate-coordinates lcoord
                    (char item 0)
                    (parse-integer (string-left-trim "RL" item))
                    ldir))
      (setf ldir (turn ldir (char item 0))))
    lcoord))

(defun final (list-of-directions)
  (let ((result (count-coordinates list-of-directions)))
  (+ (abs (coord-x result))
     (abs (coord-y result)))))

(defun write-to-arr (coord arr idx)
  (setf (apply #'aref arr idx '(0)) (coord-x coord))
  (setf (apply #'aref arr idx '(1)) (coord-y coord))
  arr)

(defun search-in-array (coord arr)
  "Searches in an array for coordinates"
  (let ((new-arr (make-array (list 1 2))))
    (setf (apply #'aref new-arr 0 '(0)) (coord-x coord))
    (setf (apply #'aref new-arr 0 '(1)) (coord-y coord))
    ;; compare new-array against the existing array. Return true if found.
    (dotimes (n (first (array-dimensions arr)))
      (print (aref arr n '(1))))
      ))

(defun visit-twice (split-input)
  "Takes a list of coordinates and returns coordinates with distance (structure)"
  (let* ((ldir "N")
         (lcoord (make-coord 0 0))
         (larr (make-array (list (list-length split-input) 2))))
    (loop
      for i from 0 upto (list-length split-input) collect i
      do ((setf lcoord (calculate-coordinates lcoord
                    (char (nth i split-inpunt) 0)
                    (parse-integer (string-left-trim "RL" (nth i split-inpunt)))
                    ldir))
          (setf ldir (turn ldir (char (nth i split-inpunt) 0))))
         ;; if larr has length 0, write to it, else check for contents and breack out in case of match
         (when (nil) ;;tests for coordinates in array
           (return lcoord)
           (write-to-arr lcoord larr i))
      )))


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
(test write-to-arr :in-system
  (let* ((arr (make-array '(1 2)))
         (arr-test (make-array '(1 2) :initial-contents '((2 3))))
         (test-coord (make-coord 2 3)))
    (is (equalp arr-test (write-to-arr test-coord arr 0)))))
; run all tests
(fiveam:run!)
