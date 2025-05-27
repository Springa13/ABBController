MODULE MainModule
    ! Socket communication variables
    VAR socketdev client_socket;
    VAR bool connected := FALSE;
    VAR string server_ip := "192.168.125.1";  ! Change to your PC's IP
    VAR num server_port := 3000;
    
    ! Timing variables
    VAR clock pose_timer;
    VAR num pose_count := 0;
    
    ! Three target positions
    CONST robtarget p1 := [[400, 0, 600], [1, 0, 0, 0], [0, 0, 0, 0], [9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget p2 := [[400, 300, 300], [0.7071, 0, 0.7071, 0], [0, 0, 0, 0], [9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget p3 := [[0, 300, 600], [0.5, 0.5, 0.5, 0.5], [0, 0, 0, 0], [9E9,9E9,9E9,9E9,9E9,9E9]];
    
    ! Routine to format pose as string
    FUNC string PoseToString(robtarget pose)
        RETURN NumToStr(pose.trans.x, 2) + "," +
               NumToStr(pose.trans.y, 2) + "," +
               NumToStr(pose.trans.z, 2) + "," +
               NumToStr(pose.rot.q1, 4) + "," +
               NumToStr(pose.rot.q2, 4) + "," +
               NumToStr(pose.rot.q3, 4) + "," +
               NumToStr(pose.rot.q4, 4);
    ENDFUNC
    
    ! Routine to send current pose
    PROC SendPose()
        VAR robtarget current_pose;
        VAR string pose_string;
        
        current_pose := CRobT(\Tool:=tool0 \WObj:=wobj0);
        pose_string := PoseToString(current_pose);
        
        IF connected THEN
            SocketSend client_socket \Str:=pose_string;
        ENDIF
        
        pose_count := pose_count + 1;
    ENDPROC
    
    ! Timer interrupt for 10Hz pose streaming
    TRAP PoseStreaming
        SendPose;
        IDelete pose_int;
        CONNECT pose_int WITH PoseStreaming;
        ITimer 0.1, pose_int;  ! 0.1s = 10Hz
    ENDTRAP
    
    ! Simplified movement procedure with just 3 MoveJ commands
    PROC MoveRobot()
        ! First move
        MoveJ p1, v500, z50, tool0;
        
        ! Second move
        MoveJ p2, v400, z30, tool0;
        
        ! Third move
        MoveJ p3, v300, fine, tool0;
    ENDPROC
    
    ! Main procedure
    PROC Main()
        ! Initialize socket connection
        SocketCreate client_socket;
        TPWrite "Connecting to " + server_ip + ":" + ValToStr(server_port);
        
        TEST ERRNO
        CASE ERR_OK:
            SocketConnect client_socket, server_ip, server_port \Time:=5;
            connected := TRUE;
            TPWrite "Connected to Python server";
        DEFAULT:
            TPWrite "Connection failed";
            connected := FALSE;
        ENDTEST
        
        ! Start pose streaming at 10Hz
        ClkReset pose_timer;
        ClkStart pose_timer;
        CONNECT pose_int WITH PoseStreaming;
        ITimer 0.1, pose_int;
        
        ! Execute movement
        MoveRobot;
        
        ! Clean up
        IDelete pose_int;
        IF connected THEN
            SocketClose client_socket;
            TPWrite "Disconnected from Python server";
        ENDIF
        TPWrite "Total poses sent: " + ValToStr(pose_count);
    ENDPROC
ENDMODULE