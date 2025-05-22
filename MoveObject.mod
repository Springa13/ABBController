MODULE MainMotion
    ! Tools
    PERS tooldata Suction_Gripper:=[TRUE,[[0,0,205],[1,0,0,0]],[1,[5.311,-5.76,184.806],[1,0,0,0],0,0,0]];
    
    ! Positions
    CONST robtarget Home:=[[50,0,800],[0.707106781,0,0.707106781,0],[0,0,0,4],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget PickPos := [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget PickApproach := [[500,0,200],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Move1 := [[500,0,200],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Move2 := [[450,0,300],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Move3 := [[400,0,400],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Move4 := [[350,0,500],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Move5 := [[350,0,600],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget PlacePos := [[500,300,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget PlaceApproach := [[500,300,200],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    
    CONST robtarget Cal1 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal2 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal3 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal4 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal5 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal6 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal7 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal8 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal9 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal10 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal11 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal12 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal13 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal14 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget Cal15 = [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    
    PROC manip_obj()

        ! Example pick and place loop
        SetTool Suction_Gripper;
        MoveL Home, v500, fine;
        WaitTime 2;
        MoveL PickPos, v100, fine;
        SetDO Output1, 1;
        WaitTime 2;
        MoveL Move1, v100, fine;
        WaitTime 2;
        MoveL Move2, v100, fine;
        WaitTime 2;
        MoveL Move3, v100, fine;
        WaitTime 2;
        MoveL Move4, v100, fine;
        WaitTime 2;
        MoveL Move5, v100, fine;
        SetDO Output1, 0;
        WaitTime 2;
        MoveL Home, v500, fine; 
        
    ENDPROC

    PROC apriltag_calibration()
        SetTool Suction_Gripper;
        MoveL Cal1, v100, fine;
        MoveL Cal2, v100, fine;
        MoveL Cal3, v100, fine;
        MoveL Cal4, v100, fine;
        MoveL Cal5, v100, fine;
        MoveL Cal6, v100, fine;
        MoveL Cal7, v100, fine;
        MoveL Cal8, v100, fine;
        MoveL Cal9, v100, fine;
        MoveL Cal10, v100, fine;
        MoveL Cal11, v100, fine;
        MoveL Cal13, v100, fine;
        MoveL Cal14, v100, fine;
        MoveL Cal15, v100, fine;


    ENDPROC

    PROC main()
        manip_obj;
        !apriltag_calibration;
    ENDPROC
ENDMODULE