import socket
import time

def start_server():
    host = '192.168.125.1'  # Your PC's IP
    port = 5000
    
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((host, port))
        s.listen()
        print(f"Waiting for ABB robot connection on {host}:{port}")
        
        conn, addr = s.accept()
        with conn:
            print(f"Connected by {addr}")
            start_time = time.time()
            pose_count = 0
            
            try:
                while True:
                    data = conn.recv(1024)
                    if not data:
                        break
                    
                    pose_str = data.decode('utf-8')
                    pose_count += 1
                    
                    # Process pose data (example: print every 10 poses)
                    if pose_count % 10 == 0:
                        print(f"Pose {pose_count}: {pose_str}")
                        
                    # Add your custom processing here
                    # e.g., save to file, visualize, etc.
                    
            except KeyboardInterrupt:
                print("\nServer shutting down")
            
            runtime = time.time() - start_time
            print(f"\nSummary:")
            print(f"Total poses received: {pose_count}")
            print(f"Average rate: {pose_count/runtime:.2f} Hz")
            print(f"Total runtime: {runtime:.2f} seconds")

if __name__ == "__main__":
    start_server()