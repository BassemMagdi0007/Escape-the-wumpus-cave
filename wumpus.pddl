(define (domain wumpus)
  (:requirements :strips :typing :negative-preconditions :conditional-effects)
  
  ;; Define types
  (:types
    location
    agent pit pushable pickable wumpus wall - physob
    fireworks arrow - pickable
    crate halfcrate - pushable
  )
  
  ;; Define predicates.
  (:predicates
    (at ?o - physob ?l - location)
    
    (adjacent_north ?l1 - location ?l2 - location)  
    (adjacent_south ?l1 - location ?l2 - location)  
    (adjacent_east ?l1 - location ?l2 - location)  
    (adjacent_west ?l1 - location ?l2 - location)  
    
    (empty ?l - location)
    (emptyPit ?l - location)
    (halfPit ?l - location)
    (filledPit ?l - location)
    (blockedByWall ?l - wall)  
    
    (hasArrows ?s - agent ?a - arrow)
    (hasFireworks ?s - agent ?f - fireworks)

    (insideCave ?l - location)
    (exit_points ?l - location)
    (exit_map)
)
  
  ;; Define actions
  ; _____________________________Walk_________________________________________ 
  ;; ((((((((((((((    EAST    ))))))))))))))
  (:action walkEast
    :parameters (?s - agent ?l1 - location ?l2 - location ?a - arrow ?f - fireworks ?w - wumpus)
    :precondition (and 
      (at ?s ?l1) 
      (or (empty ?l2) (at ?a ?l2) (at ?f ?l2))
      (adjacent_east ?l1 ?l2)
      (not (at ?w ?l2))
      ; (or (hasFireworks ?s ?f) (not (hasFireworks ?s ?f)))
    )
    :effect (and 
      (at ?s ?l2)
      (not (at ?s ?l1))
      (empty ?l1)
      (not (empty ?l2))
      (when (at ?a ?l2) 
        (hasArrows ?s ?a)
      )
      (not (at ?a ?l2))
      ; (when (at ?f ?l2)
      ;     (hasFireworks ?s ?f)
      ; )
      ; (not (at ?f ?l2))
    )
  )  
  
  ;; ((((((((((((((    WEST    ))))))))))))))
  (:action walkWest
    :parameters (?s - agent ?l1 - location ?l2 - location ?a - arrow ?f - fireworks ?w - wumpus)
    :precondition (and 
      (at ?s ?l1) 
      (or (empty ?l2) (at ?a ?l2) (at ?f ?l2))
      (adjacent_west ?l1 ?l2)
      (not (at ?w ?l2))
      ; (or (hasFireworks ?s ?f) (not (hasFireworks ?s ?f)))
    )
    :effect (and 
      (at ?s ?l2)
      (not (at ?s ?l1))
      (empty ?l1)
      (not (empty ?l2))
      (when (at ?a ?l2) 
        (hasArrows ?s ?a)
      )
      (not (at ?a ?l2))
      ; (when (at ?f ?l2)
      ;     (hasFireworks ?s ?f)
      ; )
      ; (not (at ?f ?l2))
    )
  )  

  ;; ((((((((((((((    NORTH    ))))))))))))))
  (:action walkNorth
    :parameters (?s - agent ?l1 - location ?l2 - location ?a - arrow ?f - fireworks ?w - wumpus)
    :precondition (and 
      (at ?s ?l1) 
      (or (empty ?l2) (at ?a ?l2) (at ?f ?l2))
      (adjacent_north ?l1 ?l2)
      (not (at ?w ?l2))
      ; (or (hasFireworks ?s ?f) (not (hasFireworks ?s ?f)))
    )
    :effect (and 
      (at ?s ?l2)
      (not (at ?s ?l1))
      (empty ?l1)
      (not (empty ?l2))
      (when (at ?a ?l2) 
        (hasArrows ?s ?a)
      )
      (not (at ?a ?l2))
      ; (when (at ?f ?l2)
      ;     (hasFireworks ?s ?f)
      ; )
      ; (not (at ?f ?l2))
    )
  )  

  ;; ((((((((((((((    SOUTH    ))))))))))))))
  (:action walkSouth
    :parameters (?s - agent ?l1 - location ?l2 - location ?a - arrow ?f - fireworks ?w - wumpus)
    :precondition (and 
      (at ?s ?l1) 
      (or (empty ?l2) (at ?a ?l2) (at ?f ?l2))
      (adjacent_south ?l1 ?l2)
      (not (at ?w ?l2))
      ; (or (hasFireworks ?s ?f) (not (hasFireworks ?s ?f)))
    )
    :effect (and 
      (at ?s ?l2)
      (not (at ?s ?l1))
      (empty ?l1)
      (not (empty ?l2))
      (when (at ?a ?l2) 
        (hasArrows ?s ?a)
      )
      (not (at ?a ?l2))
      ; (when (at ?f ?l2)
      ;     (hasFireworks ?s ?f)
      ; )
      ; (not (at ?f ?l2))
    )
  )  

    ; _________________________Pick Up FireWorks_____________________________________     
    (:action pickUpFireworks
        :parameters (?s - agent ?l - location ?f - fireworks)
        :precondition (and 
          (at ?s ?l) 
          (at ?f ?l)
        )
        :effect (and
          (hasFireworks ?s ?f) 
          (not (at ?f ?l)) 
         )
    )

    ;; Handles both pushing one crate and one half crate 
    ; _____________________________PushCrate_________________________________________
    ;; ((((((((((((((    EAST    ))))))))))))))
    (:action pushEast
        :parameters (?s - agent ?o1 - pushable ?c - crate ?h - halfcrate ?f - fireworks ?a - arrow ?l1 - location ?l2 - location ?l3 - location ?p - pit)
        :precondition (and 
            (at ?s ?l1)
            (at ?o1 ?l2)
            (not (at ?p ?l2))
            (adjacent_east ?l1 ?l2)
            (adjacent_east ?l2 ?l3)
            ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
            (or (or (empty ?l3) (at ?a ?l3) (at ?f ?l3)) (at ?p ?l3))
            (not (exit_points ?l2))
        )
        :effect (and
            ;; SITUATION_1: Empty Square
            (when (or (empty ?l3) (at ?a ?l3) (at ?f ?l3))
                (and 
                    (at ?s ?l2) 
                    (not (at ?s ?l1)) 
                    (empty ?l1)

                    (at ?o1 ?l3) 
                    (not (at ?o1 ?l2)) 
                    (not (empty ?l3)) 
                )
            )
        
            ;; SITUATION_2: EmptyPit
            (when (at ?p ?l3) 
              (and
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1)

                  ; (not (emptyPit ?l3))

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and
                      (not (at ?c ?l2))
                      (empty ?l3)
                    )
                  )

                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2)
                    (and
                      (not (at ?h ?l2))
                      (halfPit ?l3)
                    )
                  )  
              )
            )
    
            ;; SITUATION_3: HalfPit
            (when (halfPit ?l3)
                (and 
                    (at ?s ?l2) 
                    (not (at ?s ?l1)) 
                    (empty ?l1) 

                    (not (halfPit ?l3))

                    ;; CASE1: object on l2 was crate
                    (when (at ?c ?l2)
                      (and 
                          (not (at ?c ?l2))
                          (blockedByWall ?l3) 
                      )
                    )
                    ;; CASE2: object on l2 was halfcrate
                    (when (at ?h ?l2) 
                        (and 
                            (not (at ?h ?l2)) 
                            (empty ?l3)
                        )
                    ) 
                )
            )
        )
    )

    ;; ((((((((((((((    WEST    ))))))))))))))
    (:action pushWest
        :parameters (?s - agent ?o1 - pushable ?c - crate ?h - halfcrate ?f - fireworks ?a - arrow ?l1 - location ?l2 - location ?l3 - location ?p - pit)
        :precondition (and 
            (at ?s ?l1)
            (at ?o1 ?l2)
            (not (at ?p ?l2))
            (adjacent_west ?l1 ?l2)
            (adjacent_west ?l2 ?l3)
            ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
            (or (or (empty ?l3) (at ?a ?l3) (at ?f ?l3)) (at ?p ?l3))
            (not (exit_points ?l2))
        )
        :effect (and
            ;; SITUATION_1: Empty Square
            (when (or (empty ?l3) (at ?a ?l3) (at ?f ?l3))
                (and 
                    (at ?s ?l2) 
                    (not (at ?s ?l1)) 
                    (empty ?l1)

                    (at ?o1 ?l3) 
                    (not (at ?o1 ?l2)) 
                    (not (empty ?l3)) 
                )
            )
        
            ;; SITUATION_2: EmptyPit
            (when (at ?p ?l3) 
              (and
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1)

                  ; (not (emptyPit ?l3))

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and
                      (not (at ?c ?l2))
                      (empty ?l3)
                    )
                  )

                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2)
                    (and
                      (not (at ?h ?l2))
                      (halfPit ?l3)
                    )
                  )  
              )
            )
    
            ;; SITUATION_3: HalfPit
            (when (halfPit ?l3)
                (and 
                    (at ?s ?l2) 
                    (not (at ?s ?l1)) 
                    (empty ?l1) 

                    (not (halfPit ?l3))

                    ;; CASE1: object on l2 was crate
                    (when (at ?c ?l2)
                      (and 
                          (not (at ?c ?l2))
                          (blockedByWall ?l3) 
                      )
                    )
                    ;; CASE2: object on l2 was halfcrate
                    (when (at ?h ?l2) 
                        (and 
                            (not (at ?h ?l2)) 
                            (empty ?l3)
                        )
                    ) 
                )
            )
        )
    )
    
    ;; ((((((((((((((    NORTH    ))))))))))))))
    (:action pushNorth
        :parameters (?s - agent ?o1 - pushable ?c - crate ?h - halfcrate ?f - fireworks ?a - arrow ?l1 - location ?l2 - location ?l3 - location ?p - pit)
        :precondition (and 
            (at ?s ?l1)
            (at ?o1 ?l2)
            (not (at ?p ?l2))
            (adjacent_north ?l1 ?l2)
            (adjacent_north ?l2 ?l3)
            ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
            (or (or (empty ?l3) (at ?a ?l3) (at ?f ?l3)) (at ?p ?l3))
            (not (exit_points ?l2))
        )
        :effect (and
            ;; SITUATION_1: Empty Square
            (when (or (empty ?l3) (at ?a ?l3) (at ?f ?l3))
                (and 
                    (at ?s ?l2) 
                    (not (at ?s ?l1)) 
                    (empty ?l1)

                    (at ?o1 ?l3) 
                    (not (at ?o1 ?l2)) 
                    (not (empty ?l3)) 
                )
            )
        
            ;; SITUATION_2: EmptyPit
            (when (at ?p ?l3) 
              (and
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1)

                  ; (not (emptyPit ?l3))

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and
                      (not (at ?c ?l2))
                      (empty ?l3)
                    )
                  )

                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2)
                    (and
                      (not (at ?h ?l2))
                      (halfPit ?l3)
                    )
                  )  
              )
            )
    
            ;; SITUATION_3: HalfPit
            (when (halfPit ?l3)
                (and 
                    (at ?s ?l2) 
                    (not (at ?s ?l1)) 
                    (empty ?l1) 

                    (not (halfPit ?l3))

                    ;; CASE1: object on l2 was crate
                    (when (at ?c ?l2)
                      (and 
                          (not (at ?c ?l2))
                          (blockedByWall ?l3) 
                      )
                    )
                    ;; CASE2: object on l2 was halfcrate
                    (when (at ?h ?l2) 
                        (and 
                            (not (at ?h ?l2)) 
                            (empty ?l3)
                        )
                    ) 
                )
            )
        )
    )

    ;; ((((((((((((((    SOUTH    ))))))))))))))
    (:action pushSouth
        :parameters (?s - agent ?o1 - pushable ?c - crate ?h - halfcrate ?f - fireworks ?a - arrow ?l1 - location ?l2 - location ?l3 - location ?p - pit)
        :precondition (and 
            (at ?s ?l1)
            (at ?o1 ?l2)
            (not (at ?p ?l2))
            (adjacent_south ?l1 ?l2)
            (adjacent_south ?l2 ?l3)
            ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
            (or (or (empty ?l3) (at ?a ?l3) (at ?f ?l3)) (at ?p ?l3))
            (not (exit_points ?l2))
        )
        :effect (and
            ;; SITUATION_1: Empty Square
            (when (or (empty ?l3) (at ?a ?l3) (at ?f ?l3))
                (and 
                    (at ?s ?l2) 
                    (not (at ?s ?l1)) 
                    (empty ?l1)

                    (at ?o1 ?l3) 
                    (not (at ?o1 ?l2)) 
                    (not (empty ?l3)) 
                )
            )
        
            ;; SITUATION_2: EmptyPit
            (when (at ?p ?l3) 
              (and
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1)

                  ; (not (emptyPit ?l3))

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and
                      (not (at ?c ?l2))
                      (empty ?l3)
                    )
                  )

                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2)
                    (and
                      (not (at ?h ?l2))
                      (halfPit ?l3)
                    )
                  )  
              )
            )
    
            ;; SITUATION_3: HalfPit
            (when (halfPit ?l3)
                (and 
                    (at ?s ?l2) 
                    (not (at ?s ?l1)) 
                    (empty ?l1) 

                    (not (halfPit ?l3))

                    ;; CASE1: object on l2 was crate
                    (when (at ?c ?l2)
                      (and 
                          (not (at ?c ?l2))
                          (blockedByWall ?l3) 
                      )
                    )
                    ;; CASE2: object on l2 was halfcrate
                    (when (at ?h ?l2) 
                        (and 
                            (not (at ?h ?l2)) 
                            (empty ?l3)
                        )
                    ) 
                )
            )
        )
    )
    
  ; _____________________________Shoot_________________________________________ 
  ;; ((((((((((((((    EAST    ))))))))))))))
  (:action shootEast
    :parameters (?s - agent ?a - arrow ?w - wumpus ?l1 - location ?l2 - location)
    :precondition (and 
      (at ?s ?l1)
      (at ?w ?l2)
      (hasArrows ?s ?a)
      (adjacent_east ?l1 ?l2)
    )
    :effect (and 
      (not (at ?w ?l2))
      (empty ?l2)
      (not (hasArrows ?s ?a))
    )
  )  

  ;; ((((((((((((((    WEST    ))))))))))))))
  (:action shootWest
    :parameters (?s - agent ?a - arrow ?w - wumpus ?l1 - location ?l2 - location)
    :precondition (and 
      (at ?s ?l1)
      (at ?w ?l2)
      (hasArrows ?s ?a)
      (adjacent_west ?l1 ?l2)
    )
    :effect (and 
      (not (at ?w ?l2))
      (empty ?l2)
      (not (hasArrows ?s ?a))
    )
  ) 

  ;; ((((((((((((((    NORTH    ))))))))))))))
  (:action shootNorth
    :parameters (?s - agent ?a - arrow ?w - wumpus ?l1 - location ?l2 - location)
    :precondition (and 
      (at ?s ?l1)
      (at ?w ?l2)
      (hasArrows ?s ?a)
      (adjacent_north ?l1 ?l2)
    )
    :effect (and 
      (not (at ?w ?l2))
      (empty ?l2)
      (not (hasArrows ?s ?a))
    )
  )  

  ;; ((((((((((((((    SOUTH    ))))))))))))))
  (:action shootSouth
    :parameters (?s - agent ?a - arrow ?w - wumpus ?l1 - location ?l2 - location)
    :precondition (and 
      (at ?s ?l1)
      (at ?w ?l2)
      (hasArrows ?s ?a)
      (adjacent_south ?l1 ?l2)
    )
    :effect (and 
      (not (at ?w ?l2))
      (empty ?l2)
      (not (hasArrows ?s ?a))
    )
  )
    ; _____________________________Scare________________________________________
    ;; ((((((((((((((    EAST    ))))))))))))))
    (:action scareEast
      :parameters (?s - agent ?a - arrow ?f - fireworks ?w - wumpus ?l1 - location ?l2 - location ?l3 - location)
      :precondition (and
        (at ?s ?l1)
        (or (at ?w ?l2) (and (at ?w ?l2) (at ?f ?l2)) (and (at ?w ?l2) (at ?a ?l2)))
        (adjacent_east ?l1 ?l2)
        (adjacent_east ?l2 ?l3)
        (not (at ?w ?l3))
        (not (exit_points ?l2))
        (hasFireworks ?s ?f)
        (or (empty ?l3) (and (at ?f ?l3) (not (at ?w ?l3))) (and (at ?a ?l3) (not (at ?w ?l3)))) 
        (not (blockedByWall ?l3))
      )
      :effect (and 
        ; when l3 either is empty or has fireworks or arrows and no wumpus in both cases, the wumpus can move. 
        (when (or (empty ?l3) (and (at ?f ?l3) (not (at ?w ?l3))) (and (at ?a ?l3) (not (at ?w ?l3))))
          (at ?w ?l3)
        )
        ; when the wumpus is at l3 alone or es gibt fireworks oder arrow damit then l3 is not empty 
        (when (or (at ?w ?l3) (and (at ?w ?l3) (at ?f ?l3)) (and (at ?w ?l3) (at ?a ?l3)))
          (not (empty ?l3))
        )  
        (not (at ?w ?l2))
        (empty ?l2)
        ; if wumpus no longer at l2, then l2 is empty  
        ; (when (not (at ?w ?l2))
        ;   (empty ?l2)
        ; )
        ; if wumpus no longer at l2 and there is firewworks at l2, then l2 is empty and has fireworks 
        (when (at ?f ?l2)
          (and
           (empty ?l2) 
           (at ?f ?l2)
          )
        )
        ; if wumpus no longer at l2 and there is arrow at l2, then l2 is empty and has arrow 
        (when (at ?a ?l2)
          (and
           (empty ?l2) 
           (at ?a ?l2)
          )
        )
        (not (hasFireworks ?s ?f)) 
      )
    )

    ;; ((((((((((((((    WEST    ))))))))))))))
    (:action scareWest
      :parameters (?s - agent ?a - arrow ?f - fireworks ?w - wumpus ?l1 - location ?l2 - location ?l3 - location)
      :precondition (and
        (at ?s ?l1)
        (or (at ?w ?l2) (and (at ?w ?l2) (at ?f ?l2)) (and (at ?w ?l2) (at ?a ?l2)))
        (adjacent_west ?l1 ?l2)
        (adjacent_west ?l2 ?l3)
        (not (at ?w ?l3))
        (not (exit_points ?l2))
        (hasFireworks ?s ?f)
        (or (empty ?l3) (and (at ?f ?l3) (not (at ?w ?l3))) (and (at ?a ?l3) (not (at ?w ?l3)))) 
        (not (blockedByWall ?l3))
      )
      :effect (and 
        ; when l3 either is empty or has fireworks or arrows and no wumpus in both cases, the wumpus can move. 
        (when (or (empty ?l3) (and (at ?f ?l3) (not (at ?w ?l3))) (and (at ?a ?l3) (not (at ?w ?l3))))
          (at ?w ?l3)
        )
        ; when the wumpus is at l3 alone or es gibt fireworks oder arrow damit then l3 is not empty 
        (when (or (at ?w ?l3) (and (at ?w ?l3) (at ?f ?l3)) (and (at ?w ?l3) (at ?a ?l3)))
          (not (empty ?l3))
        )  
        (not (at ?w ?l2))
        (empty ?l2)
        ; if wumpus no longer at l2, then l2 is empty  
        ; (when (not (at ?w ?l2))
        ;   (empty ?l2)
        ; )
        ; if wumpus no longer at l2 and there is firewworks at l2, then l2 is empty and has fireworks 
        (when (at ?f ?l2)
          (and
           (empty ?l2) 
           (at ?f ?l2)
          )
        )
        ; if wumpus no longer at l2 and there is arrow at l2, then l2 is empty and has arrow 
        (when (at ?a ?l2)
          (and
           (empty ?l2) 
           (at ?a ?l2)
          )
        )
        (not (hasFireworks ?s ?f)) 
      )
    )
    
    ;; ((((((((((((((    NORTH    ))))))))))))))
    (:action scareNorth
      :parameters (?s - agent ?a - arrow ?f - fireworks ?w - wumpus ?l1 - location ?l2 - location ?l3 - location)
      :precondition (and
        (at ?s ?l1)
        (or (at ?w ?l2) (and (at ?w ?l2) (at ?f ?l2)) (and (at ?w ?l2) (at ?a ?l2)))
        (adjacent_north ?l1 ?l2)
        (adjacent_north ?l2 ?l3)
        (not (at ?w ?l3))
        (not (exit_points ?l2))
        (hasFireworks ?s ?f)
        (or (empty ?l3) (and (at ?f ?l3) (not (at ?w ?l3))) (and (at ?a ?l3) (not (at ?w ?l3)))) 
        (not (blockedByWall ?l3))
      )
      :effect (and 
        ; when l3 either is empty or has fireworks or arrows and no wumpus in both cases, the wumpus can move. 
        (when (or (empty ?l3) (and (at ?f ?l3) (not (at ?w ?l3))) (and (at ?a ?l3) (not (at ?w ?l3))))
          (at ?w ?l3)
        )
        ; when the wumpus is at l3 alone or es gibt fireworks oder arrow damit then l3 is not empty 
        (when (or (at ?w ?l3) (and (at ?w ?l3) (at ?f ?l3)) (and (at ?w ?l3) (at ?a ?l3)))
          (not (empty ?l3))
        )  
        (not (at ?w ?l2))
        (empty ?l2)
        ; if wumpus no longer at l2, then l2 is empty  
        ; (when (not (at ?w ?l2))
        ;   (empty ?l2)
        ; )
        ; if wumpus no longer at l2 and there is firewworks at l2, then l2 is empty and has fireworks 
        (when (at ?f ?l2)
          (and
           (empty ?l2) 
           (at ?f ?l2)
          )
        )
        ; if wumpus no longer at l2 and there is arrow at l2, then l2 is empty and has arrow 
        (when (at ?a ?l2)
          (and
           (empty ?l2) 
           (at ?a ?l2)
          )
        )
        (not (hasFireworks ?s ?f)) 
      )
    )
    
    ;; ((((((((((((((    SOUTH    ))))))))))))))
    (:action scareSouth
      :parameters (?s - agent ?a - arrow ?f - fireworks ?w - wumpus ?l1 - location ?l2 - location ?l3 - location)
      :precondition (and
        (at ?s ?l1)
        (or (at ?w ?l2) (and (at ?w ?l2) (at ?f ?l2)) (and (at ?w ?l2) (at ?a ?l2)))
        (adjacent_south ?l1 ?l2)
        (adjacent_south ?l2 ?l3)
        (not (at ?w ?l3))
        (not (exit_points ?l2))
        (hasFireworks ?s ?f)
        (or (empty ?l3) (and (at ?f ?l3) (not (at ?w ?l3))) (and (at ?a ?l3) (not (at ?w ?l3)))) 
        (not (blockedByWall ?l3))
      )
      :effect (and 
        ; when l3 either is empty or has fireworks or arrows and no wumpus in both cases, the wumpus can move. 
        (when (or (empty ?l3) (and (at ?f ?l3) (not (at ?w ?l3))) (and (at ?a ?l3) (not (at ?w ?l3))))
          (at ?w ?l3)
        )
        ; when the wumpus is at l3 alone or es gibt fireworks oder arrow damit then l3 is not empty 
        (when (or (at ?w ?l3) (and (at ?w ?l3) (at ?f ?l3)) (and (at ?w ?l3) (at ?a ?l3)))
          (not (empty ?l3))
        )  
        (not (at ?w ?l2))
        (empty ?l2)
        ; if wumpus no longer at l2, then l2 is empty  
        ; (when (not (at ?w ?l2))
        ;   (empty ?l2)
        ; )
        ; if wumpus no longer at l2 and there is firewworks at l2, then l2 is empty and has fireworks 
        (when (at ?f ?l2)
          (and
           (empty ?l2) 
           (at ?f ?l2)
          )
        )
        ; if wumpus no longer at l2 and there is arrow at l2, then l2 is empty and has arrow 
        (when (at ?a ?l2)
          (and
           (empty ?l2) 
           (at ?a ?l2)
          )
        )
        (not (hasFireworks ?s ?f)) 
      )
    )

  ; _____________________________PushHalfCrate_________________________________________
  ;; ((((((((((((((    EAST    ))))))))))))))
  (:action pushHalfCrateEast
      :parameters (?s - agent ?h1 - halfcrate ?h2 - halfcrate ?a - arrow ?f - fireworks ?l1 - location ?l2 - location ?l3 - location ?l4 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (at ?h1 ?l2)
          (not (at ?p ?l2))
          (at ?h2 ?l3)
          (not (at ?p ?l3))
          (adjacent_east ?l1 ?l2)
          (adjacent_east ?l2 ?l3)
          (adjacent_east ?l3 ?l4)
          (not (exit_points ?l3))
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (or (empty ?l4) (at ?a ?l4) (at ?f ?l4)) (at ?p ?l4))
          
      )
       :effect (and
          ;; Empty Square
          (when (or (empty ?l4) (at ?a ?l4) (at ?f ?l4)) 
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))
                (at ?h2 ?l4)
                (not (at ?h2 ?l3))
                (not (empty ?l4))
              )
          )
       
          ;; EmptyPit
          (when (at ?p ?l4)  
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))

                (not (at ?h2 ?l3))
                (halfPit ?l4) 
              )
          )
      
          ;; HalfPit
          (when (halfPit ?l4) 
              (and 
                (at ?s ?l2) 
                (not (at ?s ?l1)) 
                (empty ?l1)

                (at ?h1 ?l3) 
                (not (at ?h1 ?l2)) 

                (not (at ?h2 ?l3)) 
                (not (halfPit ?l4)) 
                (empty ?l4)
              )
          )
      )
  ) 

  ;; ((((((((((((((    WEST    ))))))))))))))
    (:action pushHalfCrateWest
      :parameters (?s - agent ?h1 - halfcrate ?h2 - halfcrate ?a - arrow ?f - fireworks ?l1 - location ?l2 - location ?l3 - location ?l4 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (at ?h1 ?l2)
          (not (at ?p ?l2))
          (at ?h2 ?l3)
          (not (at ?p ?l3))
          (adjacent_west ?l1 ?l2)
          (adjacent_west ?l2 ?l3)
          (adjacent_west ?l3 ?l4)
          (not (exit_points ?l3))
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (or (empty ?l4) (at ?a ?l4) (at ?f ?l4)) (at ?p ?l4))
      )
       :effect (and
          ;; Empty Square
          (when (or (empty ?l4) (at ?a ?l4) (at ?f ?l4)) 
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))
                (at ?h2 ?l4)
                (not (at ?h2 ?l3))
                (not (empty ?l4))
              )
          )
       
          ;; EmptyPit
          (when (at ?p ?l4)  
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))

                (not (at ?h2 ?l3))
                (halfPit ?l4) 
              )
          )
      
          ;; HalfPit
          (when (halfPit ?l4) 
              (and 
                (at ?s ?l2) 
                (not (at ?s ?l1)) 
                (empty ?l1)

                (at ?h1 ?l3) 
                (not (at ?h1 ?l2)) 

                (not (at ?h2 ?l3)) 
                (not (halfPit ?l4)) 
                (empty ?l4)
              )
          )
      )
  )

  ;; ((((((((((((((    NORTH    ))))))))))))))
    (:action pushHalfCrateNorth
      :parameters (?s - agent ?h1 - halfcrate ?h2 - halfcrate ?a - arrow ?f - fireworks ?l1 - location ?l2 - location ?l3 - location ?l4 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (at ?h1 ?l2)
          (not (at ?p ?l2))
          (at ?h2 ?l3)
          (not (at ?p ?l3))
          (adjacent_north ?l1 ?l2)
          (adjacent_north ?l2 ?l3)
          (adjacent_north ?l3 ?l4)
          (not (exit_points ?l3))
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (or (empty ?l4) (at ?a ?l4) (at ?f ?l4)) (at ?p ?l4))
      )
       :effect (and
          ;; Empty Square
          (when (or (empty ?l4) (at ?a ?l4) (at ?f ?l4)) 
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))
                (at ?h2 ?l4)
                (not (at ?h2 ?l3))
                (not (empty ?l4))
              )
          )
       
          ;; EmptyPit
          (when (at ?p ?l4)  
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))

                (not (at ?h2 ?l3))
                (halfPit ?l4) 
              )
          )
      
          ;; HalfPit
          (when (halfPit ?l4) 
              (and 
                (at ?s ?l2) 
                (not (at ?s ?l1)) 
                (empty ?l1)

                (at ?h1 ?l3) 
                (not (at ?h1 ?l2)) 

                (not (at ?h2 ?l3)) 
                (not (halfPit ?l4)) 
                (empty ?l4)
              )
          )
      )
  )

  ;; ((((((((((((((    SOUTH    ))))))))))))))
    (:action pushHalfCrateSouth
      :parameters (?s - agent ?h1 - halfcrate ?h2 - halfcrate ?a - arrow ?f - fireworks ?l1 - location ?l2 - location ?l3 - location ?l4 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (at ?h1 ?l2)
          (not (at ?p ?l2))
          (at ?h2 ?l3)
          (not (at ?p ?l3))
          (adjacent_south ?l1 ?l2)
          (adjacent_south ?l2 ?l3)
          (adjacent_south ?l3 ?l4)
          (not (exit_points ?l3))
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (or (empty ?l4) (at ?a ?l4) (at ?f ?l4)) (at ?p ?l4))
      )
       :effect (and
          ;; Empty Square
          (when (or (empty ?l4) (at ?a ?l4) (at ?f ?l4)) 
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))
                (at ?h2 ?l4)
                (not (at ?h2 ?l3))
                (not (empty ?l4))
              )
          )
       
          ;; EmptyPit
          (when (at ?p ?l4)  
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))

                (not (at ?h2 ?l3))
                (halfPit ?l4) 
              )
          )
      
          ;; HalfPit
          (when (halfPit ?l4) 
              (and 
                (at ?s ?l2) 
                (not (at ?s ?l1)) 
                (empty ?l1)

                (at ?h1 ?l3) 
                (not (at ?h1 ?l2)) 

                (not (at ?h2 ?l3)) 
                (not (halfPit ?l4)) 
                (empty ?l4)
              )
          )
      )
  )

  ; _____________________________ExitMap_________________________________________  
  (:action exit_map
    :parameters (?s - agent ?l - location)
    :precondition 
    (and 
      (at ?s ?l) 
      (exit_points ?l)    
    )
    :effect 
    (and 
      (exit_map)
    )
  )
)