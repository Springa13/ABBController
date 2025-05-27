MODULE PoseStreamer
    ! Communication variables
    

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

    PROC StreamPose()
        VAR robtarget current_pose;
        VAR string pose_string;
        
        current_pose := CRobT(\Tool:=tool0 \WObj:=wobj0);
        pose_string := PoseToString(current_pose);
        
        IF connected THEN
            SocketSend client_socket \Str:=pose_string;
        ENDIF
        
        pose_count := pose_count + 1;
           
    ENDPROC
ENDMODULE