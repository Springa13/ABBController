MODULE MainMotion
    ! Tools
    PERS tooldata Suction_Gripper:=[TRUE,[[0,0,205],[1,0,0,0]],[1,[5.311,-5.76,184.806],[1,0,0,0],0,0,0]];
    
    ! Positions
    CONST robtarget Home:=[[50,0,800],[0.707106781,0,0.707106781,0],[0,0,0,4],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget PickPos := [[500,0,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget PickApproach := [[500,0,200],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget PlacePos := [[700,300,100],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget PlaceApproach := [[700,300,200],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    
    PROC manip_obj()

        ! Example pick and place loop
        SetTool Suction_Gripper;
        MoveL Home, v500, fine;
        MoveL PickPos, v100, fine;
        SetDO Output1, 1;
        MoveL FirstMove, v100, fine
        WaitTime 1;
        MoveL SecondMove, v200, fine, 
        
    ENDPROC

    PROC apriltag_calibration()
        ! Setup server
        SocketCreate server_socket;
        SocketBind server_socket, "0.0.0.0", 3000;
        SocketListen server_socket;
        SocketAccept server_socket, client_socket;

        SetTool Suction_Gripper;
        MoveL Home, v500, fine;


        ! ---- Binary Pose Streaming ----
        current_pose := CRobT(\Tool:=tool0 \WObj:=wobj0);
        
        ! Pack XYZ + quaternions into 56 bytes (7x float64)
        pose_data := PackRawBytes(
            current_pose.trans.x \Float64, 
            current_pose.trans.y \Float64,
            current_pose.trans.z \Float64,
            current_pose.rot.q1 \Float64,
            current_pose.rot.q2 \Float64,
            current_pose.rot.q3 \Float64,
            current_pose.rot.q4 \Float64
        );
    
        SocketSend client_socket \Bin:=pose_data;

    ENDPROC

    PROC main()
        manip_obj;
        !apriltag_calibration;
    ENDPROC
ENDMODULE