MODULE Module1
    
    ! Socket communication variables
    VAR socketdev client_socket;
    VAR bool connected := FALSE;
    VAR string server_ip := "192.168.125.1";  ! Change to your PC's IP
    VAR num server_port := 3000;

    ! Timing variables
    VAR clock pose_timer;
    VAR num pose_count := 0;

    ! Timer interrupt for 10Hz pose streaming
    TRAP PoseStreaming
        SendPose;
        IDelete pose_int;
        CONNECT pose_int WITH PoseStreaming;
        ITimer 0.1, pose_int;  ! 0.1s = 10Hz
    ENDTRAP
    
    PROC main()
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