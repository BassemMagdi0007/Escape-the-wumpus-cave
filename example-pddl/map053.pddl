(define (problem map053)
  (:domain wumpus)
  
  ;; Define objects
  (:objects   
    
    s - agent
    w - wumpus
    p - pit
    c - crate
    h - halfcrate
    f - fireworks
    a - arrow

    cell0_0 cell0_1 cell0_2 cell0_3 cell0_4 cell0_5 cell0_6 cell0_7 cell0_8 cell0_9 cell0_10 cell0_11 - location
    cell1_0 cell1_1 cell1_2 cell1_3 cell1_4 cell1_5 cell1_6 cell1_7 cell1_8 cell1_9 cell1_10 cell1_11 - location
    cell2_0 cell2_1 cell2_2 cell2_3 cell2_4 cell2_5 cell2_6 cell2_7 cell2_8 cell2_9 cell2_10 cell2_11 - location
    cell3_0 cell3_1 cell3_2 cell3_3 cell3_4 cell3_5 cell3_6 cell3_7 cell3_8 cell3_9 cell3_10 cell3_11 - location
    cell4_0 cell4_1 cell4_2 cell4_3 cell4_4 cell4_5 cell4_6 cell4_7 cell4_8 cell4_9 cell4_10 cell4_11 - location
    cell5_0 cell5_1 cell5_2 cell5_3 cell5_4 cell5_5 cell5_6 cell5_7 cell5_8 cell5_9 cell5_10 cell5_11 - location
    cell6_0 cell6_1 cell6_2 cell6_3 cell6_4 cell6_5 cell6_6 cell6_7 cell6_8 cell6_9 cell6_10 cell6_11 - location
    cell7_0 cell7_1 cell7_2 cell7_3 cell7_4 cell7_5 cell7_6 cell7_7 cell7_8 cell7_9 cell7_10 cell7_11 - location

    
  )
  
  ;; Define initial state
  ;; Dynamically generate the init states for each map
  (:init
  ; _________________________________MAP CONTENT___________________________________________
		(empty cell0_0)
		(at h cell0_1)
		(empty cell0_2)
		(at c cell0_3)
		(at c cell0_4)
		(at h cell0_5)
		(empty cell0_6)
		(at h cell0_7)
		(at h cell0_8)
		(empty cell0_9)
		(empty cell0_10)
		(empty cell0_11)
		(at c cell1_0)
		(at h cell1_1)
		(at c cell1_2)
		(empty cell1_3)
		(at c cell1_4)
		(at h cell1_5)
		(at c cell1_6)
		(at c cell1_7)
		(at h cell1_8)
		(empty cell1_9)
		(at h cell1_10)
		(at c cell1_11)
		(at c cell2_0)
		(at h cell2_1)
		(empty cell2_2)
		(at h cell2_3)
		(empty cell2_4)
		(at c cell2_5)
		(at h cell2_6)
		(at c cell2_7)
		(at h cell2_8)
		(at h cell2_9)
		(empty cell2_10)
		(empty cell2_11)
		(at c cell3_0)
		(empty cell3_1)
		(at c cell3_2)
		(at h cell3_3)
		(at c cell3_4)
		(empty cell3_5)
		(at c cell3_6)
		(empty cell3_7)
		(empty cell3_8)
		(at c cell3_9)
		(at h cell3_10)
		(at h cell3_11)
		(empty cell4_0)
		(empty cell4_1)
		(at h cell4_2)
		(at c cell4_3)
		(empty cell4_4)
		(at h cell4_5)
		(at h cell4_6)
		(empty cell4_7)
		(at c cell4_8)
		(at s cell4_9)
		(at h cell4_10)
		(at h cell4_11)
		(at c cell5_0)
		(at h cell5_1)
		(at h cell5_2)
		(empty cell5_3)
		(at c cell5_4)
		(at h cell5_5)
		(empty cell5_6)
		(at h cell5_7)
		(at c cell5_8)
		(at h cell5_9)
		(at h cell5_10)
		(empty cell5_11)
		(empty cell6_0)
		(empty cell6_1)
		(at h cell6_2)
		(at h cell6_3)
		(empty cell6_4)
		(empty cell6_5)
		(empty cell6_6)
		(at c cell6_7)
		(at c cell6_8)
		(at c cell6_9)
		(at c cell6_10)
		(empty cell6_11)
		(at h cell7_0)
		(at h cell7_1)
		(empty cell7_2)
		(at h cell7_3)
		(at c cell7_4)
		(at h cell7_5)
		(at h cell7_6)
		(at h cell7_7)
		(at c cell7_8)
		(at c cell7_9)
		(empty cell7_10)
		(at c cell7_11)

    
  ; __________________________________EXIT CELLS____________________________________________
    (exit_points cell0_0) (exit_points cell0_1) (exit_points cell0_2) (exit_points cell0_3) (exit_points cell0_4) (exit_points cell0_5) (exit_points cell0_6) (exit_points cell0_7) (exit_points cell0_8) (exit_points cell0_9) (exit_points cell0_10) (exit_points cell0_11)
    (exit_points cell1_0) (exit_points cell2_0) (exit_points cell1_3) (exit_points cell1_4) (exit_points cell5_0) (exit_points cell6_0) (exit_points cell7_0)
    (exit_points cell1_11) (exit_points cell2_11) (exit_points cell3_11) (exit_points cell4_11) (exit_points cell5_11) (exit_points cell6_11) (exit_points cell7_11) 
    (exit_points cell7_0) (exit_points cell7_1) (exit_points cell7_2) (exit_points cell7_3) (exit_points cell7_4) (exit_points cell7_5) (exit_points cell7_6) (exit_points cell7_7) (exit_points cell7_8) (exit_points cell7_9) (exit_points cell7_10) (exit_points cell7_11) 

  ; ___________________________________ADJACENCIES__________________________________________
    ; For cell0_0:
    (adjacent_east cell0_0 cell0_1)
    (adjacent_south cell0_0 cell1_0)

    ; For cell0_1:
    (adjacent_east cell0_1 cell0_2)
    (adjacent_west cell0_1 cell0_0)
    (adjacent_south cell0_1 cell1_1)

    ; For cell0_2:
    (adjacent_east cell0_2 cell0_3)
    (adjacent_west cell0_2 cell0_1)
    (adjacent_south cell0_2 cell1_2)

    ; For cell0_3:
    (adjacent_east cell0_3 cell0_4)
    (adjacent_west cell0_3 cell0_2)
    (adjacent_south cell0_3 cell1_3)

    ; For cell0_4:
    (adjacent_east cell0_4 cell0_5)
    (adjacent_west cell0_4 cell0_3)
    (adjacent_south cell0_4 cell1_4)

    ; For cell0_5:
    (adjacent_east cell0_5 cell0_6)
    (adjacent_west cell0_5 cell0_4)
    (adjacent_south cell0_5 cell1_5)

    ; For cell0_6:
    (adjacent_east cell0_6 cell0_7)
    (adjacent_west cell0_6 cell0_5)
    (adjacent_south cell0_6 cell1_6)

    ; For cell0_7:
    (adjacent_east cell0_7 cell0_8)
    (adjacent_west cell0_7 cell0_6)
    (adjacent_south cell0_7 cell1_7)

    ; For cell0_8:
    (adjacent_east cell0_8 cell0_9)
    (adjacent_west cell0_8 cell0_7)
    (adjacent_south cell0_8 cell1_8)

    ; For cell0_9:
    (adjacent_east cell0_9 cell0_10)
    (adjacent_west cell0_9 cell0_8)
    (adjacent_south cell0_9 cell1_9)

    ; For cell0_10:
    (adjacent_east cell0_10 cell0_11)
    (adjacent_west cell0_10 cell0_9)
    (adjacent_south cell0_10 cell1_10)

    ; For cell0_11:
    (adjacent_west cell0_11 cell0_10)
    (adjacent_south cell0_11 cell1_11)

    ; For cell1_0:
    (adjacent_east cell1_0 cell1_1)
    (adjacent_north cell1_0 cell0_0)
    (adjacent_south cell1_0 cell2_0)

    ; For cell1_1:
    (adjacent_east cell1_1 cell1_2)
    (adjacent_west cell1_1 cell1_0)
    (adjacent_north cell1_1 cell0_1)
    (adjacent_south cell1_1 cell2_1)

    ; For cell1_2:
    (adjacent_east cell1_2 cell1_3)
    (adjacent_west cell1_2 cell1_1)
    (adjacent_north cell1_2 cell0_2)
    (adjacent_south cell1_2 cell2_2)

    ; For cell1_3:
    (adjacent_east cell1_3 cell1_4)
    (adjacent_west cell1_3 cell1_2)
    (adjacent_north cell1_3 cell0_3)
    (adjacent_south cell1_3 cell2_3)

    ; For cell1_4:
    (adjacent_east cell1_4 cell1_5)
    (adjacent_west cell1_4 cell1_3)
    (adjacent_north cell1_4 cell0_4)
    (adjacent_south cell1_4 cell2_4)

    ; For cell1_5:
    (adjacent_east cell1_5 cell1_6)
    (adjacent_west cell1_5 cell1_4)
    (adjacent_north cell1_5 cell0_5)
    (adjacent_south cell1_5 cell2_5)

    ; For cell1_6:
    (adjacent_east cell1_6 cell1_7)
    (adjacent_west cell1_6 cell1_5)
    (adjacent_north cell1_6 cell0_6)
    (adjacent_south cell1_6 cell2_6)

    ; For cell1_7:
    (adjacent_east cell1_7 cell1_8)
    (adjacent_west cell1_7 cell1_6)
    (adjacent_north cell1_7 cell0_7)
    (adjacent_south cell1_7 cell2_7)

    ; For cell1_8:
    (adjacent_east cell1_8 cell1_9)
    (adjacent_west cell1_8 cell1_7)
    (adjacent_north cell1_8 cell0_8)
    (adjacent_south cell1_8 cell2_8)

    ; For cell1_9:
    (adjacent_east cell1_9 cell1_10)
    (adjacent_west cell1_9 cell1_8)
    (adjacent_north cell1_9 cell0_9)
    (adjacent_south cell1_9 cell2_9)

    ; For cell1_10:
    (adjacent_east cell1_10 cell1_11)
    (adjacent_west cell1_10 cell1_9)
    (adjacent_north cell1_10 cell0_10)
    (adjacent_south cell1_10 cell2_10)

    ; For cell1_11:
    (adjacent_west cell1_11 cell1_10)
    (adjacent_north cell1_11 cell0_11)
    (adjacent_south cell1_11 cell2_11)

    ; For cell2_0:
    (adjacent_east cell2_0 cell2_1)
    (adjacent_north cell2_0 cell1_0)
    (adjacent_south cell2_0 cell3_0)

    ; For cell2_1:
    (adjacent_east cell2_1 cell2_2)
    (adjacent_west cell2_1 cell2_0)
    (adjacent_north cell2_1 cell1_1)
    (adjacent_south cell2_1 cell3_1)

    ; For cell2_2:
    (adjacent_east cell2_2 cell2_3)
    (adjacent_west cell2_2 cell2_1)
    (adjacent_north cell2_2 cell1_2)
    (adjacent_south cell2_2 cell3_2)

    ; For cell2_3:
    (adjacent_east cell2_3 cell2_4)
    (adjacent_west cell2_3 cell2_2)
    (adjacent_north cell2_3 cell1_3)
    (adjacent_south cell2_3 cell3_3)

    ; For cell2_4:
    (adjacent_east cell2_4 cell2_5)
    (adjacent_west cell2_4 cell2_3)
    (adjacent_north cell2_4 cell1_4)
    (adjacent_south cell2_4 cell3_4)

    ; For cell2_5:
    (adjacent_east cell2_5 cell2_6)
    (adjacent_west cell2_5 cell2_4)
    (adjacent_north cell2_5 cell1_5)
    (adjacent_south cell2_5 cell3_5)

    ; For cell2_6:
    (adjacent_east cell2_6 cell2_7)
    (adjacent_west cell2_6 cell2_5)
    (adjacent_north cell2_6 cell1_6)
    (adjacent_south cell2_6 cell3_6)

    ; For cell2_7:
    (adjacent_east cell2_7 cell2_8)
    (adjacent_west cell2_7 cell2_6)
    (adjacent_north cell2_7 cell1_7)
    (adjacent_south cell2_7 cell3_7)

    ; For cell2_8:
    (adjacent_east cell2_8 cell2_9)
    (adjacent_west cell2_8 cell2_7)
    (adjacent_north cell2_8 cell1_8)
    (adjacent_south cell2_8 cell3_8)

    ; For cell2_9:
    (adjacent_east cell2_9 cell2_10)
    (adjacent_west cell2_9 cell2_8)
    (adjacent_north cell2_9 cell1_9)
    (adjacent_south cell2_9 cell3_9)

    ; For cell2_10:
    (adjacent_east cell2_10 cell2_11)
    (adjacent_west cell2_10 cell2_9)
    (adjacent_north cell2_10 cell1_10)
    (adjacent_south cell2_10 cell3_10)

    ; For cell2_11:
    (adjacent_west cell2_11 cell2_10)
    (adjacent_north cell2_11 cell1_11)
    (adjacent_south cell2_11 cell3_11)

    ; For cell3_0:
    (adjacent_east cell3_0 cell3_1)
    (adjacent_west cell3_0 cell3_0)
    (adjacent_north cell3_0 cell2_0)
    (adjacent_south cell3_0 cell4_0)

    
    ; For cell3_1:
    (adjacent_east cell3_1 cell3_2)
    (adjacent_west cell3_1 cell3_0)
    (adjacent_north cell3_1 cell2_1)
    (adjacent_south cell3_1 cell4_1)

    ; For cell3_2:
    (adjacent_east cell3_2 cell3_3)
    (adjacent_west cell3_2 cell3_1)
    (adjacent_north cell3_2 cell2_2)
    (adjacent_south cell3_2 cell4_2)

    ; For cell3_3:
    (adjacent_east cell3_3 cell3_4)
    (adjacent_west cell3_3 cell3_2)
    (adjacent_north cell3_3 cell2_3)
    (adjacent_south cell3_3 cell4_3)

    ; For cell3_4:
    (adjacent_east cell3_4 cell3_5)
    (adjacent_west cell3_4 cell3_3)
    (adjacent_north cell3_4 cell2_4)
    (adjacent_south cell3_4 cell4_4)

    ; For cell3_5:
    (adjacent_east cell3_5 cell3_6)
    (adjacent_west cell3_5 cell3_4)
    (adjacent_north cell3_5 cell2_5)
    (adjacent_south cell3_5 cell4_5)

    ; For cell3_6:
    (adjacent_east cell3_6 cell3_7)
    (adjacent_west cell3_6 cell3_5)
    (adjacent_north cell3_6 cell2_6)
    (adjacent_south cell3_6 cell4_6)

    ; For cell3_7:
    (adjacent_east cell3_7 cell3_8)
    (adjacent_west cell3_7 cell3_6)
    (adjacent_north cell3_7 cell2_7)
    (adjacent_south cell3_7 cell4_7)

    ; For cell3_8:
    (adjacent_east cell3_8 cell3_9)
    (adjacent_west cell3_8 cell3_7)
    (adjacent_north cell3_8 cell2_8)
    (adjacent_south cell3_8 cell4_8)

    ; For cell3_9:
    (adjacent_east cell3_9 cell3_10)
    (adjacent_west cell3_9 cell3_8)
    (adjacent_north cell3_9 cell2_9)
    (adjacent_south cell3_9 cell4_9)

    ; For cell3_10:
    (adjacent_east cell3_10 cell3_11)
    (adjacent_west cell3_10 cell3_9)
    (adjacent_north cell3_10 cell2_10)
    (adjacent_south cell3_10 cell4_10)

    ; For cell3_11:
    (adjacent_west cell3_11 cell3_10)
    (adjacent_north cell3_11 cell2_11)
    (adjacent_south cell3_11 cell4_11)

    ; For cell4_0:
    (adjacent_east cell4_0 cell4_1)
    (adjacent_west cell4_0 cell4_0)
    (adjacent_north cell4_0 cell3_0)
    (adjacent_south cell4_0 cell5_0)

    ; For cell4_1:
    (adjacent_east cell4_1 cell4_2)
    (adjacent_west cell4_1 cell4_0)
    (adjacent_north cell4_1 cell3_1)
    (adjacent_south cell4_1 cell5_1)

    ; For cell4_2:
    (adjacent_east cell4_2 cell4_3)
    (adjacent_west cell4_2 cell4_1)
    (adjacent_north cell4_2 cell3_2)
    (adjacent_south cell4_2 cell5_2)

    ; For cell4_3:
    (adjacent_east cell4_3 cell4_4)
    (adjacent_west cell4_3 cell4_2)
    (adjacent_north cell4_3 cell3_3)
    (adjacent_south cell4_3 cell5_3)

    ; For cell4_4:
    (adjacent_east cell4_4 cell4_5)
    (adjacent_west cell4_4 cell4_3)
    (adjacent_north cell4_4 cell3_4)
    (adjacent_south cell4_4 cell5_4)

    ; For cell4_5:
    (adjacent_east cell4_5 cell4_6)
    (adjacent_west cell4_5 cell4_4)
    (adjacent_north cell4_5 cell3_5)
    (adjacent_south cell4_5 cell5_5)

    ; For cell4_6:
    (adjacent_east cell4_6 cell4_7)
    (adjacent_west cell4_6 cell4_5)
    (adjacent_north cell4_6 cell3_6)
    (adjacent_south cell4_6 cell5_6)

    ; For cell4_7:
    (adjacent_east cell4_7 cell4_8)
    (adjacent_west cell4_7 cell4_6)
    (adjacent_north cell4_7 cell3_7)
    (adjacent_south cell4_7 cell5_7)

    ; For cell4_8:
    (adjacent_east cell4_8 cell4_9)
    (adjacent_west cell4_8 cell4_7)
    (adjacent_north cell4_8 cell3_8)
    (adjacent_south cell4_8 cell5_8)

    ; For cell4_9:
    (adjacent_east cell4_9 cell4_10)
    (adjacent_west cell4_9 cell4_8)
    (adjacent_north cell4_9 cell3_9)
    (adjacent_south cell4_9 cell5_9)

    ; For cell4_10:
    (adjacent_east cell4_10 cell4_11)
    (adjacent_west cell4_10 cell4_9)
    (adjacent_north cell4_10 cell3_10)
    (adjacent_south cell4_10 cell5_10)

    ; For cell4_11:
    (adjacent_west cell4_11 cell4_10)
    (adjacent_north cell4_11 cell3_11)
    (adjacent_south cell4_11 cell5_11)

    ; For cell5_0:
    (adjacent_east cell5_0 cell5_1)
    (adjacent_west cell5_0 cell5_0)
    (adjacent_north cell5_0 cell4_0)
    (adjacent_south cell5_0 cell6_0)

    ; For cell5_1:
    (adjacent_east cell5_1 cell5_2)
    (adjacent_west cell5_1 cell5_0)
    (adjacent_north cell5_1 cell4_1)
    (adjacent_south cell5_1 cell6_1)

    ; For cell5_2:
    (adjacent_east cell5_2 cell5_3)
    (adjacent_west cell5_2 cell5_1)
    (adjacent_north cell5_2 cell4_2)
    (adjacent_south cell5_2 cell6_2)

    ; For cell5_3:
    (adjacent_east cell5_3 cell5_4)
    (adjacent_west cell5_3 cell5_2)
    (adjacent_north cell5_3 cell4_3)
    (adjacent_south cell5_3 cell6_3)

    ; For cell5_4:
    (adjacent_east cell5_4 cell5_5)
    (adjacent_west cell5_4 cell5_3)
    (adjacent_north cell5_4 cell4_4)
    (adjacent_south cell5_4 cell6_4)

    ; For cell5_5:
    (adjacent_east cell5_5 cell5_6)
    (adjacent_west cell5_5 cell5_4)
    (adjacent_north cell5_5 cell4_5)
    (adjacent_south cell5_5 cell6_5)

    ; For cell5_6:
    (adjacent_east cell5_6 cell5_7)
    (adjacent_west cell5_6 cell5_5)
    (adjacent_north cell5_6 cell4_6)
    (adjacent_south cell5_6 cell6_6)

    ; For cell5_7:
    (adjacent_east cell5_7 cell5_8)
    (adjacent_west cell5_7 cell5_6)
    (adjacent_north cell5_7 cell4_7)
    (adjacent_south cell5_7 cell6_7)

    ; For cell5_8:
    (adjacent_east cell5_8 cell5_9)
    (adjacent_west cell5_8 cell5_7)
    (adjacent_north cell5_8 cell4_8)
    (adjacent_south cell5_8 cell6_8)

    ; For cell5_9:
    (adjacent_east cell5_9 cell5_10)
    (adjacent_west cell5_9 cell5_8)
    (adjacent_north cell5_9 cell4_9)
    (adjacent_south cell5_9 cell6_9)

    ; For cell5_10:
    (adjacent_east cell5_10 cell5_11)
    (adjacent_west cell5_10 cell5_9)
    (adjacent_north cell5_10 cell4_10)
    (adjacent_south cell5_10 cell6_10)

    ; For cell5_11:
    (adjacent_west cell5_11 cell5_10)
    (adjacent_north cell5_11 cell4_11)
    (adjacent_south cell5_11 cell6_11)

    ; For cell6_0:
    (adjacent_east cell6_0 cell6_1)
    (adjacent_west cell6_0 cell6_0)
    (adjacent_north cell6_0 cell5_0)
    (adjacent_south cell6_0 cell7_0)

    ; For cell6_1:
    (adjacent_east cell6_1 cell6_2)
    (adjacent_west cell6_1 cell6_0)
    (adjacent_north cell6_1 cell5_1)
    (adjacent_south cell6_1 cell7_1)

    ; For cell6_2:
    (adjacent_east cell6_2 cell6_3)
    (adjacent_west cell6_2 cell6_1)
    (adjacent_north cell6_2 cell5_2)
    (adjacent_south cell6_2 cell7_2)

    ; For cell6_3:
    (adjacent_east cell6_3 cell6_4)
    (adjacent_west cell6_3 cell6_2)
    (adjacent_north cell6_3 cell5_3)
    (adjacent_south cell6_3 cell7_3)

    ; For cell6_4:
    (adjacent_east cell6_4 cell6_5)
    (adjacent_west cell6_4 cell6_3)
    (adjacent_north cell6_4 cell5_4)
    (adjacent_south cell6_4 cell7_4)

    ; For cell6_5:
    (adjacent_east cell6_5 cell6_6)
    (adjacent_west cell6_5 cell6_4)
    (adjacent_north cell6_5 cell5_5)
    (adjacent_south cell6_5 cell7_5)

    ; For cell6_6:
    (adjacent_east cell6_6 cell6_7)
    (adjacent_west cell6_6 cell6_5)
    (adjacent_north cell6_6 cell5_6)
    (adjacent_south cell6_6 cell7_6)

    ; For cell6_7:
    (adjacent_east cell6_7 cell6_8)
    (adjacent_west cell6_7 cell6_6)
    (adjacent_north cell6_7 cell5_7)
    (adjacent_south cell6_7 cell7_7)

    ; For cell6_8:
    (adjacent_east cell6_8 cell6_9)
    (adjacent_west cell6_8 cell6_7)
    (adjacent_north cell6_8 cell5_8)
    (adjacent_south cell6_8 cell7_8)

    ; For cell6_9:
    (adjacent_east cell6_9 cell6_10)
    (adjacent_west cell6_9 cell6_8)
    (adjacent_north cell6_9 cell5_9)
    (adjacent_south cell6_9 cell7_9)

    ; For cell6_10:
    (adjacent_east cell6_10 cell6_11)
    (adjacent_west cell6_10 cell6_9)
    (adjacent_north cell6_10 cell5_10)
    (adjacent_south cell6_10 cell7_10)

    ; For cell6_11:
    (adjacent_west cell6_11 cell6_10)
    (adjacent_north cell6_11 cell5_11)
    (adjacent_south cell6_11 cell7_11)

    ; For cell7_0:
    (adjacent_east cell7_0 cell7_1)
    (adjacent_west cell7_0 cell7_0)
    (adjacent_north cell7_0 cell6_0)
    (adjacent_south cell7_0 cell7_1)

    ; For cell7_1:
    (adjacent_east cell7_1 cell7_2)
    (adjacent_west cell7_1 cell7_0)
    (adjacent_north cell7_1 cell6_1)
    (adjacent_south cell7_1 cell7_2)

    ; For cell7_2:
    (adjacent_east cell7_2 cell7_3)
    (adjacent_west cell7_2 cell7_1)
    (adjacent_north cell7_2 cell6_2)
    (adjacent_south cell7_2 cell7_3)

    ; For cell7_3:
    (adjacent_east cell7_3 cell7_4)
    (adjacent_west cell7_3 cell7_2)
    (adjacent_north cell7_3 cell6_3)
    (adjacent_south cell7_3 cell7_4)

    ; For cell7_4:
    (adjacent_east cell7_4 cell7_5)
    (adjacent_west cell7_4 cell7_3)
    (adjacent_north cell7_4 cell6_4)
    (adjacent_south cell7_4 cell7_5)

    ; For cell7_5:
    (adjacent_east cell7_5 cell7_6)
    (adjacent_west cell7_5 cell7_4)
    (adjacent_north cell7_5 cell6_5)
    (adjacent_south cell7_5 cell7_6)

    ; For cell7_6:
    (adjacent_east cell7_6 cell7_7)
    (adjacent_west cell7_6 cell7_5)
    (adjacent_north cell7_6 cell6_6)
    (adjacent_south cell7_6 cell7_7)

    ; For cell7_7:
    (adjacent_east cell7_7 cell7_8)
    (adjacent_west cell7_7 cell7_6)
    (adjacent_north cell7_7 cell6_7)
    (adjacent_south cell7_7 cell7_8)

    ; For cell7_8:
    (adjacent_east cell7_8 cell7_9)
    (adjacent_west cell7_8 cell7_7)
    (adjacent_north cell7_8 cell6_8)
    (adjacent_south cell7_8 cell7_9)

    ; For cell7_9:
    (adjacent_east cell7_9 cell7_10)
    (adjacent_west cell7_9 cell7_8)
    (adjacent_north cell7_9 cell6_9)
    (adjacent_south cell7_9 cell7_10)

    ; For cell7_10:
    (adjacent_east cell7_10 cell7_11)
    (adjacent_west cell7_10 cell7_9)
    (adjacent_north cell7_10 cell6_10)
    (adjacent_south cell7_10 cell7_11)

    ; For cell7_11:
    (adjacent_west cell7_11 cell7_10)
    (adjacent_north cell7_11 cell6_11)
    (adjacent_south cell7_11 cell7_11)

    (not (exit_map))
  )
  ; _______________________________EXIT CONDITION_________________________________________
  ;; Define goal state
  (:goal 
    (and
      (exit_map)
    )
  )
)
