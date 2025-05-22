import socket
import struct
import time
import numpy as np
import keyboard
import pickle

def quaternion_to_rotation_matrix(q):
    """Convert quaternion [q1, q2, q3, q4] to a 3x3 rotation matrix."""
    q1, q2, q3, q4 = q
    R = np.array([
        [1 - 2*(q3**2 + q4**2),     2*(q2*q3 - q1*q4),     2*(q2*q4 + q1*q3)],
        [2*(q2*q3 + q1*q4),     1 - 2*(q2**2 + q4**2),     2*(q3*q4 - q1*q2)],
        [2*(q2*q4 - q1*q3),     2*(q3*q4 + q1*q2),     1 - 2*(q2**2 + q3**2)]
    ])
    return R

def pose_to_transform_matrix(x, y, z, q):
    """Convert pose (XYZ + quaternion) to 4x4 transformation matrix."""
    # Normalize quaternion (ABB quaternions are typically already normalized)
    q = np.array(q)
    q /= np.linalg.norm(q)
    
    # Get rotation matrix
    R = quaternion_to_rotation_matrix(q)
    
    # Build 4x4 transform matrix
    T = np.eye(4)
    T[:3, :3] = R
    T[:3, 3] = [x, y, z]  # Translation in mm
    return T

def receive_poses():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(("0.0.0.0", 3000))  # Match RAPID port
        s.listen()
        conn, _ = s.accept()
        
        print("Connected to robot. Receiving 10Hz binary poses...")
        last_time = time.time()
        pose_array = []
        
        while True:
            try:
                # Receive exactly 56 bytes (7x float64)
                data = conn.recv(56)
                if len(data) != 56:
                    print(f"Error: Expected 56 bytes, got {len(data)}")
                    continue
                
                # Unpack binary data (X,Y,Z,Q1,Q2,Q3,Q4)
                x, y, z, q1, q2, q3, q4 = struct.unpack('!7d', data)
                
                # Calculate interval
                now = time.time()
                interval = now - last_time
                last_time = now
                
                print(
                    f"Pose: X={x:.1f}mm, Y={y:.1f}mm, Z={z:.1f}mm | "
                    f"Quat: [{q1:.3f}, {q2:.3f}, {q3:.3f}, {q4:.3f}] | "
                    f"Interval: {interval*1000:.1f}ms"
                )

                pose_array.append([x, y, z, [q1, q2, q3, q4]])

                if keyboard.is_pressed('esc') or keyboard.is_pressed('q'):
                    print("\nStopping...")
                    break


                
            except Exception as e:
                print(f"Error: {str(e)}")
                break
        
        return pose_array

def save_robot_poses():
    pose_array = receive_poses()
    T_obj_in_base = []
    for pose in pose_array:
        T_obj_in_base.append(pose_to_transform_matrix(pose))
    with open("robot_poses.pkl", "wb") as f:
        pickle.dump(T_obj_in_base, f)

def save_calibration_poses():
    calibration_poses = [
        [x, y, z, [q1, q2, q3, q4]],
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
        [x, y, z, [q1, q2, q3, q4]]
    ]

    calib_poses = []
    for pose in calibration_poses:
        calib_poses.append(pose_to_transform_matrix(pose))
    with open("calibration_poses.pkl", "wb") as f:
        pickle.dump(calib_poses, f)

    
if __name__ == "__main__":
    save_robot_poses()

    save_calibration_poses()

    

    

