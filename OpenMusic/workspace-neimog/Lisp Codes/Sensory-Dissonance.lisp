

;; ;; =================================== DISSONANCE SENSORY => Mauricio Rodriguez after William A. Sethares ======================================

;;////////////////////////////////////////////
;;Common LISP version to get Dissonance curves
;;////////////////////////////////////////////
;;Mauricio Rodriguez after William A. Sethares
;;////////////////////////////////////////////
;;marod@stanford.edu - 2009
;;////////////////////////////////////////////


;;////////////////////////////////////////////
;;Main:
;;////////////////////////////////////////////


(defun dissonance (frequency-amplitude-list range increment)
  (dissonance* frequency-amplitude-list (alpha range increment)))


;;////////////////////////////////////////////
;;To get dissonance curve give a frequency-amplitude list, range and, resolution of the curve.
;;Chaco Canyon Rock example:
;;(dissonance '((1351 0.2) (2040 0.9) (2167 0.9) (4068 1.0) (5066 0.5) (7666 0.5)) 2.5 0.01)
;;////////////////////////////////////////////


(defun dissonance* (frequency-amplitude-list alpha-vector)
  (let ((frequency-list (mapcar #'(lambda(x) (first x)) frequency-amplitude-list))
        (amplitude-list (mapcar #'(lambda(x) (second x)) frequency-amplitude-list)))
  (if (endp alpha-vector) nil
      (cons (list (first alpha-vector) (group-dissonance (mapcar #'(lambda(x) (* (first alpha-vector) x)) 
                                      frequency-list)
                              amplitude-list
                              frequency-list))
            (dissonance* frequency-amplitude-list (rest alpha-vector))))))


(defun group-dissonance (frequency-list amplitude-list stock-list)
  (do ((reference-frequency frequency-list (rest reference-frequency))
       (reference-amplitude amplitude-list (rest reference-amplitude))
       (output 0 (+ (local-dissonance (first reference-frequency)
                                      stock-list
                                      (first reference-amplitude)
                                      amplitude-list)
                    output)))
      ((or (endp reference-frequency) (endp reference-amplitude)) output)))


(defun alpha (range increment)
  (loop for x from 1 to range by increment collect x))


(defun dissonance-measure (current-frequency 
                              reference-frequency
                              current-amplitude
                              reference-amplitude)
  (let ((dstar 0.24) 
        (s1 0.0207) 
        (s2 18.96) 
        (c1 5.0) 
        (c2 -5.0)
        (a1 -3.51) 
        (a2 -5.75)
        (lij nil)
        (fmin nil)
        (s nil)
        (fdif nil)
        (arg1 nil)
        (arg2 nil)
        (exp1 nil)
        (exp2 nil)
        (dnew nil))
    (progn (setf lij (min reference-amplitude current-amplitude))
           (setf fmin (if (< current-frequency reference-frequency)
                        current-frequency
                        reference-frequency))
           (setf s (/ dstar (+ (* s1 fmin) s2)))
           (setf fdif (abs (- current-frequency reference-frequency)))
           (setf arg1 (* a1 s fdif))
           (setf arg2 (* a2 s fdif))
           (setf exp1 (if (< arg1 -88.0) 0 (exp arg1)))
           (setf exp2 (if (< arg2 -88.0) 0 (exp arg2)))
           (setf dnew (* lij (+ (* c1 exp1) (* c2 exp2))))
           dnew)))


(defun local-dissonance (reference-frequency list-frequency reference-amplitude list-amplitude)
  (apply #'+ (mapcar #'(lambda(x y) 
                         (dissonance-measure x reference-frequency y reference-amplitude))
                     list-frequency
                     list-amplitude)))


;;////////////////////////////////////////////
;;To read DISSONANCE
;;////////////////////////////////////////////


(defun get-ratios-from-dissonance-curve (frequency-amplitude-list range increment)
  (mapcar #'(lambda(x) (first x)) 
          (get-minima (dissonance frequency-amplitude-list range increment))))


;;Minima ratio values of Chaco Canyon Rock Dissonance Curve:
;;(get-ratios-from-dissonance-curve '((1351 0.2) (2040 0.9) (2167 0.9) (4068 1.0) (5066 0.5) (7666 0.5)) 2.5 0.01)


(defun get-scale-from-dissonance-curve (frequency-amplitude-list range increment)
  (mapcar #'(lambda(x) (ratio->cents x)) 
        (mapcar #'(lambda(x) (first x)) 
                (get-minima (dissonance frequency-amplitude-list range increment)))))


;;Convert minima ratio values in cents to define scale steps;
;;(get-scale-from-dissonance-curve '((1351 0.2) (2040 0.9) (2167 0.9) (4068 1.0) (5066 0.5) (7666 0.5)) 2.5 0.01)


(defun get-minima (list)
  (remove-if #'nil-p  (get-minima** list)))


(defun nil-p (element)
  (if (eql element nil) t nil))


(defun get-minima** (list)
  (do ((stockpile (filtering-by-3 list) (rest stockpile))
       (output-list nil (cons (minima-p* (first stockpile)) output-list)))
      ((endp stockpile) (reverse output-list))))


(defun get-minima* (list)
  (do ((stockpile (filtering-by-3 list) (rest stockpile))
       (output-list nil (cons (minima-p (first stockpile)) output-list)))
      ((endp stockpile) (reverse output-list))))


(defun minima-p* (list)
  (if (and (>= (second (first list)) (second (second list)))
           (<= (second (second list)) (second (third list))))
    (second list)
    nil))


(defun minima-p (list)
  (if (and (>= (first list) (second list))
           (<= (second list) (third list)))
    (second list)
    nil))


(defun take-three (list)
  (unless (< (length list) 3)
    (reverse (do ((input-list list (rest input-list))
                  (result nil (cons (first input-list) result))
                  (counter 3 (- counter 1)))
                 ((= counter 0) result)))))


(defun filtering-by-3 (list)
 (if (< (length list) 3)
   nil
   (cons (take-three list) (filtering-by-3 (cdr list)))))


(defun cents->ratio (cents)
  (expt 10 (/ (* (log 2 10) cents) 1200)))


(defun ratio->cents (ratio)
  (* (/ 1200 (log 2)) (log ratio)))



