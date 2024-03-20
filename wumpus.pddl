(define (domain wumpus)
  (:requirements :strips :typing :negative-preconditions :disjunctive-preconditions :conditional-effects)
  
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

    (exit_points ?l - location)
    (exit_map)
)
  
  ;; Define actions

  ; _____________________________Walk_________________________________________ DONE
  ;; ((((((((((((((    EAST    ))))))))))))))
  (:action walkEast
    :parameters (?s - agent ?l1 - location ?l2 - location)
    :precondition (and 
    (at ?s ?l1) 
    (empty ?l2)
    (adjacent_east ?l1 ?l2)
    )
    :effect (and 
    (at ?s ?l2)
    (not (at ?s ?l1))
    (empty ?l1)
    (not (empty ?l2))
    )
  )  
  
  ;; ((((((((((((((    WEST    ))))))))))))))
  (:action walkWest
    :parameters (?s - agent ?l1 - location ?l2 - location)
    :precondition (and 
    (at ?s ?l1) 
    (empty ?l2)
    (adjacent_west ?l1 ?l2)
    )
    :effect (and 
    (at ?s ?l2)
    (not (at ?s ?l1))
    (empty ?l1)
    (not (empty ?l2))
    )
  )

  ;; ((((((((((((((    NORTH    ))))))))))))))
  (:action walkNorth
    :parameters (?s - agent ?l1 - location ?l2 - location)
    :precondition (and 
    (at ?s ?l1) 
    (empty ?l2)
    (adjacent_north ?l1 ?l2)
    )
    :effect (and 
    (at ?s ?l2)
    (not (at ?s ?l1))
    (empty ?l1)
    (not (empty ?l2))
    )
  )

  ;; ((((((((((((((    SOUTH    ))))))))))))))
  (:action walkSouth
    :parameters (?s - agent ?l1 - location ?l2 - location)
    :precondition (and 
    (at ?s ?l1) 
    (empty ?l2)
    (adjacent_south ?l1 ?l2)
    )
    :effect (and 
    (at ?s ?l2)
    (not (at ?s ?l1))
    (empty ?l1)
    (not (empty ?l2))
    )
  )

  ; ___________________________Pick Fireworks______________________________________ (DONE)
  (:action PickFireworks
    :parameters (?s - agent ?f - fireworks ?l - location)
    :precondition (and 
      (at ?s ?l)
      (at ?f ?l)
    )
    :effect (and 
      (hasFireworks ?s ?f)
      (not (at ?f ?l))
    )
  )

  ; _____________________________Scare________________________________________ (DONE)
  ;; ((((((((((((((    EAST    ))))))))))))))
  (:action scareEast
    :parameters (?s - agent ?f - fireworks ?w - wumpus ?l1 - location ?l2 - location ?l3 - location)
    :precondition (and
      (at ?s ?l1)
      (adjacent_east ?l1 ?l2)
      (adjacent_east ?l2 ?l3)
      (empty ?l3)
      (at ?w ?l2)
      (hasFireworks ?s ?f)
      (not (blockedByWall ?l3))
    )
    :effect (and 
      (at ?w ?l3)
      (not (at ?w ?l2))
      (not (hasArrows ?s ?f)) 
      (empty ?l2)
      (not (empty ?l3))
    )

  ) 

  ;; ((((((((((((((    WEST    ))))))))))))))
  (:action scareWest
    :parameters (?s - agent ?f - fireworks ?w - wumpus ?l1 - location ?l2 - location ?l3 - location)
    :precondition (and
      (at ?s ?l1)
      (adjacent_west ?l1 ?l2)
      (adjacent_west ?l2 ?l3)
      (empty ?l3)
      (at ?w ?l2)
      (hasFireworks ?s ?f)
      (not (blockedByWall ?l3))
    )
    :effect (and 
      (at ?w ?l3)
      (not (at ?w ?l2))
      (not (hasArrows ?s ?f)) 
      (empty ?l2)
      (not (empty ?l3))
    )

  )
  
  ;; ((((((((((((((    NORTH    ))))))))))))))
  (:action scareNorth
    :parameters (?s - agent ?f - fireworks ?w - wumpus ?l1 - location ?l2 - location ?l3 - location)
    :precondition (and
      (at ?s ?l1)
      (adjacent_north ?l1 ?l2)
      (adjacent_north ?l2 ?l3)
      (empty ?l3)
      (at ?w ?l2)
      (hasFireworks ?s ?f)
      (not (blockedByWall ?l3))
    )
    :effect (and 
      (at ?w ?l3)
      (not (at ?w ?l2))
      (not (hasArrows ?s ?f)) 
      (empty ?l2)
      (not (empty ?l3))
    )
  )  
  
  ;; ((((((((((((((    SOUTH    ))))))))))))))
  (:action scareSouth
    :parameters (?s - agent ?f - fireworks ?w - wumpus ?l1 - location ?l2 - location ?l3 - location)
    :precondition (and
      (at ?s ?l1)
      (adjacent_south ?l1 ?l2)
      (adjacent_south ?l2 ?l3)
      (empty ?l3)
      (at ?w ?l2)
      (hasFireworks ?s ?f)
      (not (blockedByWall ?l3))
    )
    :effect (and 
      (at ?w ?l3)
      (not (hasArrows ?s ?f)) 
      (not (at ?w ?l2))
      (empty ?l2)
      (not (empty ?l3))
    )
  )
  ; ___________________________Pick Arrow______________________________________ (DONE)
  (:action PickArrow
    :parameters (?s - agent ?a - arrow ?l - location)
    :precondition (and 
      (at ?s ?l)
      (at ?a ?l)
    )
    :effect (and 
      (hasArrows ?s ?a)
      (not (at ?a ?l))
    )
  )

  ; _____________________________Shoot_________________________________________ (DONE)
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

  ; _____________________________PushCrate_________________________________________
  ;; ((((((((((((((    EAST    ))))))))))))))
  (:action pushCrateEast
      :parameters (?s - agent ?o1 - pushable ?o2 - pickable ?f - fireworks ?a - arrow ?c - crate ?l1 - location ?l2 - location ?l3 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (adjacent_east ?l1 ?l2)
          (at ?o1 ?l2)
          (not (at ?p ?l2))
          (adjacent_east ?l2 ?l3)
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (and (at ?p ?l3) (not (blockedByWall ?l3))) (empty ?l3))
      )
      :effect (and
          ;; SITUATION_1: Empty Square
          (when (empty ?l3) 
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
          (when (and (at ?p ?l3) (emptyPit ?l3)) 
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1) 

                  (not (at ?o1 ?l2)) 
                  (not (emptyPit ?l3)) 

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and
                      (filledPit ?l3)
                      (empty ?l3)
                      (not (at ?p ?l3))
                      (not (at ?c ?l2))
                      (not (at ?o1 ?l3))
                    )
                  )

                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2)
                    (and
                      (at ?o1 ?l3)
                      (halfPit ?l3)
                    )
                  )  
              )
          )
          
          ;; SITUATION_3: HalfPit
          (when (and (at ?p ?l3) (halfPit ?l3)) 
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1) 

                  (not (at ?o1 ?l2)) 
                  (not (halfPit ?l3))

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and 
                        (at ?o1 ?l3)
                        (blocked ?l3) 
                    )
                  )
                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2) 
                      (and 
                          (filledPit ?l3) 
                          (not (at ?h ?l3)) 
                          (not (at ?o1 ?l3)) 
                          (not (at ?p ?l3))
                          (empty ?l3)
                      )
                  ) 
              )
          )

          ;; Possible Error
          ;; SITUATION_4: Pickable 
          (when (at ?o2 ?l3)  
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1)

                  (at ?o1 ?l3) 
                  (not (at ?o1 ?l2)) 
                  (not (empty ?l3))

                  ;; CASE1 : Arrow at l3
                  (when (at ?a ?l3)
                    (and
                      (hasArrows ?s ?a)
                      (not (at ?a ?l3))                     
                    )
                  )
                  ;; CASE2 : fireworks at l3
                  (when (at ?f ?l3)
                    (and
                      (hasFireworks ?s ?f)
                      (not (at ?f ?l3))   
                    )
                  )
              )
          )
      )
  )   

  ;; ((((((((((((((    WEST    ))))))))))))))
(:action pushCrateWest
      :parameters (?s - agent ?o1 - pushable ?o2 - pickable ?f - fireworks ?a - arrow ?c - crate ?l1 - location ?l2 - location ?l3 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (adjacent_west ?l1 ?l2)
          (at ?o1 ?l2)
          (not (at ?p ?l2))
          (adjacent_west ?l2 ?l3)
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (and (at ?p ?l3) (not (blockedByWall ?l3))) (empty ?l3))
      )
      :effect (and
          ;; SITUATION_1: Empty Square
          (when (empty ?l3) 
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
          (when (and (at ?p ?l3) (emptyPit ?l3)) 
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1) 

                  (not (at ?o1 ?l2)) 
                  (not (emptyPit ?l3)) 

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and
                      (filledPit ?l3)
                      (empty ?l3)
                      (not (at ?p ?l3))
                      (not (at ?c ?l2))
                      (not (at ?o1 ?l3))
                    )
                  )

                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2)
                    (and
                      (at ?o1 ?l3)
                      (halfPit ?l3)
                    )
                  )  
              )
          )
          
          ;; SITUATION_3: HalfPit
          (when (and (at ?p ?l3) (halfPit ?l3)) 
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1) 

                  (not (at ?o1 ?l2)) 
                  (not (halfPit ?l3))

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and 
                        (at ?o1 ?l3)
                        (blocked ?l3) 
                    )
                  )
                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2) 
                      (and 
                          (filledPit ?l3) 
                          (not (at ?h ?l3)) 
                          (not (at ?o1 ?l3)) 
                          (not (at ?p ?l3))
                          (empty ?l3)
                      )
                  ) 
              )
          )

          ;; Possible Error
          ;; SITUATION_4: Pickable 
          (when (at ?o2 ?l3)  
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1)

                  (at ?o1 ?l3) 
                  (not (at ?o1 ?l2)) 
                  (not (empty ?l3))

                  ;; CASE1 : Arrow at l3
                  (when (at ?a ?l3)
                    (and
                      (hasArrows ?s ?a)
                      (not (at ?a ?l3))                     
                    )
                  )
                  ;; CASE2 : fireworks at l3
                  (when (at ?f ?l3)
                    (and
                      (hasFireworks ?s ?f)
                      (not (at ?f ?l3))   
                    )
                  )
              )
          )
      )
  ) 
  
  ;; ((((((((((((((    NORTH    ))))))))))))))
(:action pushCrateNorth
      :parameters (?s - agent ?o1 - pushable ?o2 - pickable ?f - fireworks ?a - arrow ?c - crate ?l1 - location ?l2 - location ?l3 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (adjacent_north ?l1 ?l2)
          (at ?o1 ?l2)
          (not (at ?p ?l2))
          (adjacent_north ?l2 ?l3)
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (and (at ?p ?l3) (not (blockedByWall ?l3))) (empty ?l3))
      )
      :effect (and
          ;; SITUATION_1: Empty Square
          (when (empty ?l3) 
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
          (when (and (at ?p ?l3) (emptyPit ?l3)) 
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1) 

                  (not (at ?o1 ?l2)) 
                  (not (emptyPit ?l3)) 

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and
                      (filledPit ?l3)
                      (empty ?l3)
                      (not (at ?p ?l3))
                      (not (at ?c ?l2))
                      (not (at ?o1 ?l3))
                    )
                  )

                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2)
                    (and
                      (at ?o1 ?l3)
                      (halfPit ?l3)
                    )
                  )  
              )
          )
          
          ;; SITUATION_3: HalfPit
          (when (and (at ?p ?l3) (halfPit ?l3)) 
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1) 

                  (not (at ?o1 ?l2)) 
                  (not (halfPit ?l3))

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and 
                        (at ?o1 ?l3)
                        (blocked ?l3) 
                    )
                  )
                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2) 
                      (and 
                          (filledPit ?l3) 
                          (not (at ?h ?l3)) 
                          (not (at ?o1 ?l3)) 
                          (not (at ?p ?l3))
                          (empty ?l3)
                      )
                  ) 
              )
          )

          ;; Possible Error
          ;; SITUATION_4: Pickable 
          (when (at ?o2 ?l3)  
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1)

                  (at ?o1 ?l3) 
                  (not (at ?o1 ?l2)) 
                  (not (empty ?l3))

                  ;; CASE1 : Arrow at l3
                  (when (at ?a ?l3)
                    (and
                      (hasArrows ?s ?a)
                      (not (at ?a ?l3))                     
                    )
                  )
                  ;; CASE2 : fireworks at l3
                  (when (at ?f ?l3)
                    (and
                      (hasFireworks ?s ?f)
                      (not (at ?f ?l3))   
                    )
                  )
              )
          )
      )
  ) 

  ;; ((((((((((((((    SOUTH    ))))))))))))))
(:action pushCrateSouth
      :parameters (?s - agent ?o1 - pushable ?o2 - pickable ?f - fireworks ?a - arrow ?c - crate ?l1 - location ?l2 - location ?l3 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (adjacent_south ?l1 ?l2)
          (at ?o1 ?l2)
          (not (at ?p ?l2))
          (adjacent_south ?l2 ?l3)
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (and (at ?p ?l3) (not (blockedByWall ?l3))) (empty ?l3))
      )
      :effect (and
          ;; SITUATION_1: Empty Square
          (when (empty ?l3) 
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
          (when (and (at ?p ?l3) (emptyPit ?l3)) 
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1) 

                  (not (at ?o1 ?l2)) 
                  (not (emptyPit ?l3)) 

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and
                      (filledPit ?l3)
                      (empty ?l3)
                      (not (at ?p ?l3))
                      (not (at ?c ?l2))
                      (not (at ?o1 ?l3))
                    )
                  )

                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2)
                    (and
                      (at ?o1 ?l3)
                      (halfPit ?l3)
                    )
                  )  
              )
          )
          
          ;; SITUATION_3: HalfPit
          (when (and (at ?p ?l3) (halfPit ?l3)) 
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1) 

                  (not (at ?o1 ?l2)) 
                  (not (halfPit ?l3))

                  ;; CASE1: object on l2 was crate
                  (when (at ?c ?l2)
                    (and 
                        (at ?o1 ?l3)
                        (blocked ?l3) 
                    )
                  )
                  ;; CASE2: object on l2 was halfcrate
                  (when (at ?h ?l2) 
                      (and 
                          (filledPit ?l3) 
                          (not (at ?h ?l3)) 
                          (not (at ?o1 ?l3)) 
                          (not (at ?p ?l3))
                          (empty ?l3)
                      )
                  ) 
              )
          )

          ;; Possible Error
          ;; SITUATION_4: Pickable 
          (when (at ?o2 ?l3)  
              (and 
                  (at ?s ?l2) 
                  (not (at ?s ?l1)) 
                  (empty ?l1)

                  (at ?o1 ?l3) 
                  (not (at ?o1 ?l2)) 
                  (not (empty ?l3))

                  ;; CASE1 : Arrow at l3
                  (when (at ?a ?l3)
                    (and
                      (hasArrows ?s ?a)
                      (not (at ?a ?l3))                     
                    )
                  )
                  ;; CASE2 : fireworks at l3
                  (when (at ?f ?l3)
                    (and
                      (hasFireworks ?s ?f)
                      (not (at ?f ?l3))   
                    )
                  )
              )
          )
      )
  ) 
  
  ; _____________________________PushHalfCrate_________________________________________
  ;; ((((((((((((((    EAST    ))))))))))))))
  (:action pushHalfCrateEast
      :parameters (?s - agent ?h1 - halfCrate ?h2 - halfCrate ?l1 - location ?l2 - location ?l3 - location ?l4 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (adjacent_east ?l1 ?l2)
          (at ?h1 ?l2)
          (not (at ?p ?l2))
          (adjacent_east ?l2 ?l3)
          (at ?h2 ?l3)
          (not (at ?p ?l3))
          (adjacent_east ?l3 ?l4)
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (and (at ?p ?l4) (not (blockedByWall ?l4))) (empty ?l4))
      )
       :effect (and
          ;; Empty Square
          (when (empty ?l4) 
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
          (when (and (at ?p ?l3) (emptyPit ?l3)) 
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))
                (at ?h2 ?l4)
                (not (at ?h2 ?l3))
                (not (emptyPit ?l4))
                (halfPit ?l4) 
              )
          )
      
          ;; HalfPit
          (when (and (at ?p ?l3) (halfPit ?l3)) 
              (and 
                (at ?s ?l2) 
                (not (at ?s ?l1)) 
                (empty ?l1)

                (at ?h1 ?l3) 
                (not (at ?h1 ?l2)) 
                (at ?h2 ?l4) 
                (not (at ?h2 ?l3)) 
                
                (not (halfPit ?l4)) 
                (filledPit ?l4) 
                (empty ?l4)
              )
          )
      )
  ) 

  ;; ((((((((((((((    WEST    ))))))))))))))
  (:action pushHalfCrateWest
      :parameters (?s - agent ?h1 - halfCrate ?h2 - halfCrate ?l1 - location ?l2 - location ?l3 - location ?l4 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (adjacent_west ?l1 ?l2)
          (at ?h1 ?l2)
          (not (at ?p ?l2))
          (adjacent_west ?l2 ?l3)
          (at ?h2 ?l3)
          (not (at ?p ?l3))
          (adjacent_west ?l3 ?l4)
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (and (at ?p ?l4) (not (blockedByWall ?l4))) (empty ?l4))
      )
       :effect (and
          ;; Empty Square
          (when (empty ?l4) 
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
          (when (and (at ?p ?l3) (emptyPit ?l3)) 
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))
                (at ?h2 ?l4)
                (not (at ?h2 ?l3))
                (not (emptyPit ?l4))
                (halfPit ?l4) 
              )
          )
      
          ;; HalfPit
          (when (and (at ?p ?l3) (halfPit ?l3)) 
              (and 
                (at ?s ?l2) 
                (not (at ?s ?l1)) 
                (empty ?l1)

                (at ?h1 ?l3) 
                (not (at ?h1 ?l2)) 
                (at ?h2 ?l4) 
                (not (at ?h2 ?l3)) 
                
                (not (halfPit ?l4)) 
                (filledPit ?l4) 
                (empty ?l4)
              )
          )
      )
  )

  ;; ((((((((((((((    NORTH    ))))))))))))))
  (:action pushHalfCrateNorth
      :parameters (?s - agent ?h1 - halfCrate ?h2 - halfCrate ?l1 - location ?l2 - location ?l3 - location ?l4 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (adjacent_north ?l1 ?l2)
          (at ?h1 ?l2)
          (not (at ?p ?l2))
          (adjacent_north ?l2 ?l3)
          (at ?h2 ?l3)
          (not (at ?p ?l3))
          (adjacent_north ?l3 ?l4)
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (and (at ?p ?l4) (not (blockedByWall ?l4))) (empty ?l4))
      )
       :effect (and
          ;; Empty Square
          (when (empty ?l4) 
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
          (when (and (at ?p ?l3) (emptyPit ?l3)) 
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))
                (at ?h2 ?l4)
                (not (at ?h2 ?l3))
                (not (emptyPit ?l4))
                (halfPit ?l4) 
              )
          )
      
          ;; HalfPit
          (when (and (at ?p ?l3) (halfPit ?l3)) 
              (and 
                (at ?s ?l2) 
                (not (at ?s ?l1)) 
                (empty ?l1)

                (at ?h1 ?l3) 
                (not (at ?h1 ?l2)) 
                (at ?h2 ?l4) 
                (not (at ?h2 ?l3)) 
                
                (not (halfPit ?l4)) 
                (filledPit ?l4) 
                (empty ?l4)
              )
          )
      )
  )

  ;; ((((((((((((((    SOUTH    ))))))))))))))
  (:action pushHalfCrateSouth
      :parameters (?s - agent ?h1 - halfCrate ?h2 - halfCrate ?l1 - location ?l2 - location ?l3 - location ?l4 - location ?p - pit)
      :precondition (and 
          (at ?s ?l1)
          (adjacent_south ?l1 ?l2)
          (at ?h1 ?l2)
          (not (at ?p ?l2))
          (adjacent_south ?l2 ?l3)
          (at ?h2 ?l3)
          (not (at ?p ?l3))
          (adjacent_south ?l3 ?l4)
          ;; Check if location ?l3 is either empty or contains a pit and is not blocked by a wall
          (or (and (at ?p ?l4) (not (blockedByWall ?l4))) (empty ?l4))
      )
       :effect (and
          ;; Empty Square
          (when (empty ?l4) 
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
          (when (and (at ?p ?l3) (emptyPit ?l3)) 
              (and 
                (at ?s ?l2)
                (not (at ?s ?l1))
                (empty ?l1)

                (at ?h1 ?l3)
                (not (at ?h1 ?l2))
                (at ?h2 ?l4)
                (not (at ?h2 ?l3))
                (not (emptyPit ?l4))
                (halfPit ?l4) 
              )
          )
      
          ;; HalfPit
          (when (and (at ?p ?l3) (halfPit ?l3)) 
              (and 
                (at ?s ?l2) 
                (not (at ?s ?l1)) 
                (empty ?l1)

                (at ?h1 ?l3) 
                (not (at ?h1 ?l2)) 
                (at ?h2 ?l4) 
                (not (at ?h2 ?l3)) 
                
                (not (halfPit ?l4)) 
                (filledPit ?l4) 
                (empty ?l4)
              )
          )
      )
  )

  ; _____________________________ExitMap_________________________________________  
  (:action exit_map
    :parameters (?s - agent ?l - location)
    :precondition (and 
    (at ?s ?l) 
    (exit_points ?l)    
    )
    :effect (and 
    (exit_map)
    )
  )
)