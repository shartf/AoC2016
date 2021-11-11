(require "asdf")
(ql:quickload "str")
(ql:quickload "fiveam")
(use-package :5am)
(ql:quickload :array-operations)

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
  "Adds two coordinates"
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
      (setf ldir (turn ldir (char item 0)))
      (print (coord-x lcoord) ))
    lcoord))

(defun final (list-of-directions)
  (let ((result (count-coordinates list-of-directions)))
  (+ (abs (coord-x result))
     (abs (coord-y result)))))

(defun write-to-arr (coord arr idx)
  (setf (apply #'aref arr idx '(0)) (coord-x coord))
  (setf (apply #'aref arr idx '(1)) (coord-y coord))
  arr)

(defparameter arr (make-array '(3 2) :initial-contents '((2 3) (2 5) (6 4))))
(defparameter arr-to-add (make-array '(1 2) :initial-contents '((12 45))))
(defparameter stacked-arr (aops::stack 0 arr arr-to-add))
(defparameter test-coord (make-coord 2 5))
(defun search-in-array (coord arr)
  "Searches in an array for coordinates"
  (let ((new-arr (make-array (list 1 2))))
    (setf (apply #'aref new-arr 0 '(0)) (coord-x coord))
    (setf (apply #'aref new-arr 0 '(1)) (coord-y coord))
   ;; (dotimes (n (first (array-dimensions arr)))
    (loop
          for i below (array-dimension arr 0)
          do (if (and
                  (= (aref arr i 0) (aref new-arr 0 0))
                  (= (aref arr i 1) (aref new-arr 0 1)))
                 T
                 NIL))))

(defun create-intermediate (last-coord new-coord arr)
  (cond
    ((equal (coord-y last-coord) (coord-y new-coord))
     (loop
       for i from (coord-x last-coord) to (coord-x new-coord)
       do (setf arr (aops::stack 0 arr (make-array '(1 2) :initial-contents `((,i ,(coord-y last-coord))))))))
     ((equal (coord-x last-coord) (coord-x new-coord))
      (loop
        for i from (coord-y last-coord) to (coord-y new-coord)
        do (setf arr (aops::stack 0 arr (make-array '(1 2) :initial-contents `((,(coord-x last-coord) ,i))))))))
  arr)

(defun visit-twice (split-input)
  (let* ((ldir "N")
         (lcoord (make-coord 0 0))
         (larr (make-array '(1 2))))
    (loop
      for i below (list-length split-input)
      if (equal (search-in-array lcoord larr) T)
        do (print "NAHUY")
      else do (let ((ncoord (calculate-coordinates lcoord (char (nth i split-input) 0)
                                                   (parse-integer (string-left-trim "RL" (nth i split-input)))
                                                   ldir)))
                (print (search-in-array ncoord larr))
                "set ldir to the last direction, we will not not need it in that step anymore"
                (setf ldir (turn ldir (char (nth i split-input) 0)))
                "calculate and put new intermediate coordinates between lcoor and NCOORD into larr"
                (setf larr (create-intermediate lcoord ncoord larr))
                ;(print larr)
                "setf lcoord NCOORD"
                (setf lcoord ncoord)
                ))))


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
         (test-coord (make-coord 2 3))
         (test-coord-not (make-coord 3 3)))
    (is (equalp arr-test (write-to-arr test-coord arr 0)))
    (is-false (equalp arr-test (write-to-arr test-coord-not arr 0)))))
(test create-intermediate-test :in-system
  (let* ((arr (make-array '(1 2) :initial-contents '((1 3))))
         (last-coord (make-coord 2 3))
         (new-coord (make-coord 4 3))
         (new-arr (make-array '(4 2) :initial-contents '((1 3) (2 3) (3 3) (4 3)))))
    (is (equalp new-arr (create-intermediate last-coord new-coord arr)))))
(test search-in-array-test :in-system
  (let* ((arr (make-array '(4 2) :initial-contents '((2 4) (-14 30) (-190 12) (22 -10))))
         (first-coord (make-coord -14 30))
         (second-coord (make-coord 22 -10)))
    (is (equal T (search-in-array first-coord arr)))
    (is (equal T (search-in-array second-coord arr)))))
; run all tests
(fiveam:run!)
