MODULE PoseStreamer
    ! Communication variables
    VAR socketdev server_socket;
    VAR socketdev client_socket;
    VAR robtarget current_pose;
    VAR rawbytes pose_data;

    PROC stream_pose()

        ! Setup server
        SocketCreate server_socket;
        SocketBind server_socket, "0.0.0.0", 3000;
        SocketListen server_socket;
        SocketAccept server_socket, client_socket;

        WHILE TRUE DO            
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
            WaitTime 0.1;  ! 10Hz
        ENDWHILE
    ENDPROC

    PROC main()
        stream_pose;
    ENDPROC
ENDMODULE
