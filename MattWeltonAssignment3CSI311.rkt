
(define (getnodelist node)
  (if (equal? (car node) "L")
      (cdr node)
      (car (cdr (cdr (cdr node))))))
;define getnodelist function accepts a node
;If first (car node) element of list is "L" get list of values in leaf after the "L"
;Else return the list of nodes attached to the Root node

(define (getheadnode node)
  (begin
  (car (getnodelist node))))
;define getheadnode function that calls getnodelist and returns the first element.

(define (getmin node)
  (car (cdr node)))
;define getmin function that returns the second element of the list (Rootnode min)

(define (getmax node)
  (car (cdr (cdr node))))
;define getmax function that returns the third element of the list (Rootnode max)

(define (cdrgetnodelist node)
  (cdr (getnodelist node)))
;define cdrgetnodelist function that returns the cdr of getnodelist

(define (newtree node)
  (if (equal? (car node) "L")
  (cons "L" (cdrgetnodelist node)))
  (list "R" (getmin node) (getmax node) (cdrgetnodelist node)))
;define newtree function that tests for a leafnode
;if the first element of node is "L" construct a list containing "L" and (cdrgetnodelist)
;else (must be a root node) make a list containing "R" (min) (max) and the cdr of getnodelist (cdrgetnodelist)
;simulates popping off the head element being validated
 
(define (search node val)
  (if (searchroot node val)
       (begin
         (display "Value was found")
         (newline))
       (begin
         (display "Value was not found")
         (newline))))
;define search function accepts node and val
;call searchroot with node val if true print "Value was found"
;else print "Value was not found"
  




(define (searchroot node val)
  (if (equal? (car node) "L")
      (searchleaf node val)
      (if (null? (getnodelist node))
             #f
             (if (and (>= val (getmin node)) (<= val (getmax node)))
                 (if (searchroot (getheadnode node) val)
                     #t
                     (searchroot (newtree node) val))
                 (searchroot (newtree node) val)))))
;define searchroot function accepts node and val
;if the node is a leaf node, call searchleaf function
;else it is a root node, if the nodelist is empty, all nodes have been recursed through
;so return false, if the nodelist is not empty continue...
;if min <= val <= max search through first node in the nodelist (getheadnode) return true if it is = val
;else recurse with newtree (passed as searchroot's node)which has the rest of the remaining nodes in the nodelist
;do this until either val is found or nodelist is empty

(define (searchleaf node val)
  (if (null? (getnodelist node))
      #f
      (if (= (getheadnode node) val)
          #t
          (searchleaf (newtree node) val))))
;define searchleaf function accepts node and val
;if getnodelist node is empty return false
;if getheadnode node is the val we are looking for return true
;else call searchleaf again with newtree (passed as searchleaf's node) and val


(define tree '("R" 100 1500
                   (
                    ("R" 100 199
                         (("L" 120 140 160 180)))
                         ("R" 200 299
                              (("L" 220 240 260 280)))
                         ("R" 400 499
                              (("L" 410 450 475)))
                         ("R" 1200 1500
                              (("L" 1200 1400 1450)))
                         )
                   )
  )
      

 (search tree 1200)



