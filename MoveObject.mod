MODULE MoveObject

    ! Tools
    PERS tooldata Suction_Gripper:=[TRUE,[[0,0,205],[1,0,0,0]],[1,[5.311,-5.76,184.806],[1,0,0,0],0,0,0]];
    
    ! Positions
    CONST robtarget Home:=[[50,0,800],[0.707106781,0,0.707106781,0],[0,0,0,4],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Move1:=[[450,-26.124,760.893],[0.707106781,0,0.707106781,0],[-1,-2,1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Move2:=[[525,-26.124,760.893],[0.707106781,0,0.707106781,0],[-1,-2,1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Move3:=[[575,-26.124,760.893],[0.707106781,0,0.707106781,0],[-1,-2,1,1],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR jointtarget Move4 := [[-90, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR jointtarget Move5 := [[-90, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR jointtarget Move5 := [[-90, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR jointtarget Move6 := [[-90, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR jointtarget Move7 := [[-90, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];

    VAR jointtarget Cal1 := [[-90, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];        
    VAR jointtarget Cal2 := [[-45, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   
    VAR jointtarget Cal3 := [[0, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    VAR jointtarget Cal4 := [[0, -90, 0, 0, 0, 90], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    VAR jointtarget Cal5 := [[45, -90, 0, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   
    VAR jointtarget Cal6 := [[0, -45, -45, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    VAR jointtarget Cal7 := [[0, -45, -45, 0, 0, 45], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]; 
    VAR jointtarget Cal8 := [[-90, -45, -45, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   
    VAR jointtarget Cal9 := [[-45, -45, -45, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];          
    VAR jointtarget Cal10 := [[45, -45, -45, 0, 0, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];    
    VAR jointtarget Cal11 := [[90, -90, 45, 0, -45, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   
    VAR jointtarget Cal12 := [[-90, -90, 45, 0, -45, 0], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];   
    VAR jointtarget Cal13 := [[-90, -90, 45, 0, -45, -45], [9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];  
    
    PROC MoveRobot()

        ! Example pick and place loop
        MoveJ Home,v100, fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        
        MoveL Move1, v100, z100, Suction_Gripper\WObj:=wobj0;
        MoveL Move2, v100, z100, Suction_Gripper\WObj:=wobj0;
        MoveL Move3, v100, fine, Suction_Gripper\WObj:=wobj0;
        WaitTime 2;
        MoveL Move4, v100, fine, Suction_Gripper\WObj:=wobj0;
        WaitTime 2;
        MoveL Move5, v100, fine, Suction_Gripper\WObj:=wobj0;
        WaitTime 2;
        MoveL Move6, v100, fine, Suction_Gripper\WObj:=wobj0;
        WaitTime 2;
        MoveL Move7, v100, fine, Suction_Gripper\WObj:=wobj0;
        WaitTime 2;
        MoveL Move1, v100, z100, Suction_Gripper\WObj:=wobj0;
        MoveL Move2, v100, z100, Suction_Gripper\WObj:=wobj0;
        MoveL Move3, v100, fine, Suction_Gripper\WObj:=wobj0;
        WaitTime 2;
        !SetDO Output1, 0;
            
    ENDPROC

    PROC CalibrateRobot()
        
        ConfJ \Off;
        MoveAbsJ Cal1,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal2,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal3,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal4,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal5,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal6,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal7,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal8,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal9,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 5;
        MoveAbsJ Cal10,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 4;
        MoveAbsJ Cal11,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 4;
        MoveAbsJ Cal12,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 4;
        MoveAbsJ Cal13,v100,fine,Suction_Gripper\WObj:=wobj0;
        WaitTime 4;
        ConfJ \On;

        


    ENDPROC

ENDMODULE
