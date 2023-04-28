;System to evaluate and recommend football players

;Knowledge Base - Defining the templates
(deftemplate candidate
  (slot age (default 0))
  (slot experience (default 0))
  (slot pace-score (default 0))
  (slot passing-score (default 0))
  (slot fitness-score (default 0))
)

(deftemplate question 
  (slot text) 
  (slot type) 
  (slot ident)
)

(deftemplate answer 
  (slot ident) 
  (slot text)
)

(deftemplate rating 
  (slot score)
)

(deftemplate recommendation 
  (slot rating) 
  (slot explanation)
)

;Initialize a function to get the necessary details for evaluation from the user
(deffunction ask-user (?question)
  "Ask a question, and return the answer"
  (printout t ?question " ")
  (return (read))
)

;Module containing the rule to assert the answers given by the user to the question asked
(defmodule ask)
  ;Rule 1
  (defrule ask::ask-question-by-id
    "Ask a question and assert the answer"
    (declare (auto-focus TRUE))
    (MAIN::question (ident ?id) (text ?text) (type ?type))
    (not (MAIN::answer (ident ?id)))
    ?ask <- (MAIN::ask ?id)
    =>
    (bind ?answer (ask-user ?text ?type))
    (assert (MAIN::answer (ident ?id) (text ?answer)))
    (retract ?ask)
    (return)
  )

; Prints the welcome message to the user
(defmodule welcome-module)
  ;Rule 2
  (defrule welcome-user
    =>
    (printout t "Welcome to a system to evaluate football player!" crlf)
    (printout t crlf)
    (printout t "Type the name of the player and press Enter> ")
    (bind ?name (read))
    (printout t crlf)
    (printout t "Evaluation for " ?name "." crlf)
    (printout t crlf)
    (printout t "Please provide the required information for the football player." crlf)
    (printout t crlf)
  )

;Knowledge Base - Facts -- Questions to ask the user

(deffacts questions
  "The questions that are asked to the user by the system."
  (question (ident age) (type number)
  (text "What is the age of the player?"))
  (question (ident experience) (type number)
  (text "How many years of experience does the player have that is relevant?"))
  (question (ident pace-score) (type number)
  (text "What was the player's pace test score [Between 0 & 10] ?"))
  (question (ident passing-score) (type number)
  (text "What was the player's passing test score [Between 0 & 10] ?"))
  (question (ident fitness-score) (type number)
  (text "What was the player's fitness test score [Between 0 & 10] ?"))
)

; A module that contains the rules to request various details of a player
; and assert relevant answers based on the different questions asked
(defmodule request-user-details)
;Rule 3
(defrule request-age
  =>
  (assert (ask age))
)

;Rule 4
(defrule request-experience
  =>
  (assert (ask experience))
)

;Rule 5
(defrule request-pace-score
  =>
  (assert (ask pace-score))
)

;Rule 6
(defrule request-passing-score
  =>
  (assert (ask passing-score))
)

;Rule 7
(defrule request-fitness-score
  =>
  (assert (ask fitness-score))
)

;Rule 8
(defrule assert-candidate-fact
  (answer (ident age) (text ?a))
  (answer (ident experience) (text ?e))
  (answer (ident pace-score) (text ?paces))
  (answer (ident passing-score) (text ?pass_s))
  (answer (ident fitness-score) (text ?fit_s))
  =>
  (assert (candidate (age ?a) (experience ?e) (pace-score ?paces) (passing-score ?pass_s) (fitness-score ?fit_s)))
)

; Defining a module that contains the rules to determine what rating and evaluation the player 
; will get depending on the ratings entered and the various combinations of these ratings in the answers
(defmodule player-recommendation)
;Rule 9
(defrule rating-combination1
  (candidate (age ?a&:(> ?a 19)&:(< ?a 26))
  (experience ?e&:(< ?e (- ?a 15))&:(< ?e 4))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 4)
  (bind ?normalized-XP 4)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  ; (printout t "rating-combination1")
  (find-verdict ?calculated-rating)
)

;Rule 10
(defrule rating-combination2
  (candidate (age ?a&:(> ?a 19)&:(< ?a 26))
    (experience ?e&:(< ?e (- ?a 15))&:(> ?e 3)&:(< ?e 9))
    (pace-score ?paces)
    (passing-score ?pass_s)
    (fitness-score ?fit_s)
  )
  =>
  (bind ?normalized-age 4)
  (bind ?normalized-XP 6)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))

  ; (printout t "rating-combination2")

  (find-verdict ?calculated-rating)
)

;Rule 11
(defrule rating-combination3
  (candidate (age ?a&:(> ?a 19)&:(< ?a 26))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 8)&:(< ?e 14))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 4)
  (bind ?normalized-XP 8)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination3")

  ( find-verdict ?calculated-rating)
)

;Rule 12
(defrule rating-combination4
  (candidate (age ?a&:(> ?a 19)&:(< ?a 26))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 13))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 4)
  (bind ?normalized-XP 10)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
 
  ; (printout t "rating-combination4")
  
  ( find-verdict ?calculated-rating)
)

;Rule 13
(defrule rating-combination5
  (candidate (age ?a&:(> ?a 25)&:(< ?a 31))
  (experience ?e&:(< ?e (- ?a 15))&:(< ?e 4))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 6)
  (bind ?normalized-XP 4)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination5")
  
  ( find-verdict ?calculated-rating)
)

;Rule 14
(defrule rating-combination6
  (candidate (age ?a&:(> ?a 25)&:(< ?a 31))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 3)&:(< ?e 9))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 6)
  (bind ?normalized-XP 6)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination6")
  
  ( find-verdict ?calculated-rating)
)

;Rule 15
(defrule rating-combination7
  (candidate (age ?a&:(> ?a 25)&:(< ?a 31))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 8)&:(< ?e 14))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 6)
  (bind ?normalized-XP 8)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  (printout t "rating-combination7")

  (find-verdict ?calculated-rating)
)

;Rule 16
(defrule rating-combination8
  (candidate (age ?a&:(> ?a 25)&:(< ?a 31))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 13))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 6)
  (bind ?normalized-XP 10)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination8")
  
  ( find-verdict ?calculated-rating)
)

;Rule 17
(defrule rating-combination9
  (candidate (age ?a&:(> ?a 29)&:(< ?a 36))
  (experience ?e&:(< ?e (- ?a 15))&:(< ?e 4))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 8)
  (bind ?normalized-XP 4)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination9")
  
  ( find-verdict ?calculated-rating)
)

;Rule 18
(defrule rating-combination10
  (candidate (age ?a&:(> ?a 29)&:(< ?a 36))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 3)&:(< ?e 9))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 8)
  (bind ?normalized-XP 6)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination10")
  
  ( find-verdict ?calculated-rating)
)

;Rule 19
(defrule rating-combination11
  (candidate (age ?a&:(> ?a 29)&:(< ?a 36))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 8)&:(< ?e 14))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 8)
  (bind ?normalized-XP 8)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination11")
  
  ( find-verdict ?calculated-rating)
)

;Rule 20
(defrule rating-combination12
  (candidate (age ?a&:(> ?a 29)&:(< ?a 36))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 13))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 8)
  (bind ?normalized-XP 10)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination12")
  
  ( find-verdict ?calculated-rating)
)

;Rule 21
(defrule rating-combination13
  (candidate (age ?a&:(> ?a 35)&:(< ?a 51))
  (experience ?e&:(< ?e (- ?a 15))&:(< ?e 4))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 10)
  (bind ?normalized-XP 4)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination13")
  
  ( find-verdict ?calculated-rating)
)

;Rule 22
(defrule rating-combination14
  (candidate (age ?a&:(> ?a 35)&:(< ?a 51))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 3)&:(< ?e 9))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 10)
  (bind ?normalized-XP 6)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))

  ; (printout t "rating-combination14")

  ( find-verdict ?calculated-rating)
)

;Rule 23
(defrule rating-combination15
  (candidate (age ?a&:(> ?a 35)&:(< ?a 51))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 8)&:(< ?e 14))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 10)
  (bind ?normalized-XP 8)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination15")
  
  ( find-verdict ?calculated-rating)
)

;Rule 24
(defrule rating-combination16
  (candidate (age ?a&:(> ?a 35)&:(< ?a 51))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 13))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 10)
  (bind ?normalized-XP 10)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))

  ; (printout t "rating-combination16")

  ( find-verdict ?calculated-rating)
)

;Rule 25
(defrule rating-combination17
  (candidate (age ?a&:(> ?a 50))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 3)&:(< ?e 9))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 5)
  (bind ?normalized-XP 6)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination17")
  
  ( find-verdict ?calculated-rating)
)

;Rule 26
(defrule rating-combination18
  (candidate (age ?a&:(> ?a 50))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 8)&:(< ?e 14))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 5)
  (bind ?normalized-XP 8)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination18")
  
  ( find-verdict ?calculated-rating)
)

;Rule 27
(defrule rating-combination19
  (candidate (age ?a&:(> ?a 50))
  (experience ?e&:(< ?e (- ?a 15))&:(> ?e 13))
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (bind ?normalized-age 5)
  (bind ?normalized-XP 10)
  (bind ?calculated-rating (integer (+ (* 0.3 ?fit_s) (* .25 ?normalized-XP) (* .15 ?paces) (* .15 ?pass_s) (* .15 ?normalized-age))))
  
  ; (printout t "rating-combination19")
  
  ( find-verdict ?calculated-rating)
)

;Rule 28
(defrule check-experience
  (candidate (age ?a)
  (experience ?e)
  (pace-score ?paces)
  (passing-score ?pass_s)
  (fitness-score ?fit_s))
  =>
  (if (> ?e (- ?a 15)) then
    (printout t crlf)
    (printout t "Experience value is incorrect. It is not logically correct with respect to the entered age." crlf)))




;Module to print out the result of the player evaluation
(defmodule result)
;Rule 29
(defrule print-result
  ?p1 <- (recommendation (rating ?r1) (explanation ?e))
  =>
  (printout t "=== Player rating: " ?r1 crlf)
  (printout t "Explanation: " ?e crlf crlf)
)

;Run the different modules of the application
(deffunction run-application ()
  (reset)
  (focus welcome-module request-user-details player-recommendation result)
  (run)
)

;Function to evaluate the player based on their rating
(deffunction find-verdict (?calculated-rating)
  (
    if(eq ?calculated-rating 7) then
    ; (printout t "cr: " ?calculated-rating crlf)
    (assert 
      (recommendation
        (rating ?calculated-rating)
        (explanation "Low Performance, Not Suitable for team")
      )
    )

    else
      (printout t "")
  )

  (
    if(eq ?calculated-rating 8) then
    ; (printout t "cr: " ?calculated-rating crlf)
    (assert 
      (recommendation
        (rating ?calculated-rating)
        (explanation "Good Performance, Recommended for team")
      )
    )

    else
      (printout t "")
  )

  (
    if(eq ?calculated-rating 9) then
    ; (printout t "cr: " ?calculated-rating crlf)
    (assert 
      (recommendation
        (rating ?calculated-rating)
        (explanation "High Performance, Good Fit for team")
      )
    )

    else
      (printout t "")
  )

  (
    if(eq ?calculated-rating 10) then
    ; (printout t "cr: " ?calculated-rating crlf)
    (assert 
      (recommendation
        (rating ?calculated-rating)
        (explanation "High Performance, Perfect for team")
      )
    )

    else
      (printout t "")
  )
)

(while TRUE
  (run-application)
)