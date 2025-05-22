import math
import numpy as np
import os

def split_matrix(T):
    R = T[:3, :3] 
    t = T[:3, 3].reshape(3, 1) 
    return R, t

def stability_rotation(R1, R2):
    rotation_trace = np.trace(R2 @ R1.T)
    cos_theta = np.clip((rotation_trace - 1) / 2, -1.0, 1.0)
    angle = np.arccos(cos_theta)

    return np.degrees(angle) 

def stability_translation(t1, t2):
    return np.linalg.norm(np.array(t2) - np.array(t1))
    
def stability():
    dts = []
    theta_Rs = []
    total_stabilities = []
    frame_number_list = []

    # IN LOOP
    files = [f for f in os.listdir('run1') if f.endswith('.npy')]

    stationary = [1, 40, 80, 120]
    for i in range(len(files)):
        if (i > stationary[0] and i < stationary[1]) or (i > stationary[2] and i < stationary[3]):
            frame_number_list.append(i)
    
    for i in frame_number_list:
        transformation_matrix_1 = np.load('run1/' + files[i-1])
        transformation_matrix_2 = np.load('run1/' + files[i])

        R1, t1 = split_matrix(transformation_matrix_1)
        R2, t2 = split_matrix(transformation_matrix_2)

        dt = stability_translation(t1, t2)
        theta_R = stability_rotation(R1, R2)
        total_stability = dt + theta_R
        dts.append(dt)
        theta_Rs.append(theta_R)
        total_stabilities.append(total_stability)
    # OUT LOOP

    dt_mean = np.mean(dts)
    theta_R_mean = np.mean(theta_Rs)
    total_stability_mean = np.mean(total_stabilities)
    return dt_mean, theta_R_mean, total_stability_mean

def reproducibility_rotation(R1, R2):
    rotation_trace = np.trace(R1 @ R2.T)
    rotation_diff = np.arccos(np.clip((rotation_trace - 1) / 2, -1, 1))  # Clipping to avoid numerical errors
    return rotation_diff

def reproducibility_translations(t1, t2):
    translation_diff = np.linalg.norm(t1 - t2)
    return translation_diff

def reproducibility():
    rotation_diffs = []
    translation_diffs = []

    # IN LOOP
    run1_files = [f for f in os.listdir('run1') if f.endswith('.npy')]
    run2_files = [f for f in os.listdir('run2') if f.endswith('.npy')]

    for i in range(len(run1_files)):
        run1_matrix = np.load('run1/' + run1_files[i])
        run2_matrix = np.load('run2/' + run2_files[i])

        R1, t1 = split_matrix(run1_matrix)
        R2, t2 = split_matrix(run2_matrix)

        rotation_diff = reproducibility_rotation(R1, R2)
        translation_diff = reproducibility_translations(t1, t2)
        rotation_diffs.append(rotation_diff)
        translation_diffs.append(translation_diff)
    # OUT LOOP

    rotation_mean = np.mean(rotation_diffs)
    rotation_sd = np.std(rotation_diffs)
    translation_mean = np.mean(translation_diffs)
    translation_sd = np.std(translation_diffs)
    return rotation_mean, rotation_sd, translation_mean, translation_sd

def performance():
    times = []
    file = open('timing.txt', 'r')
    lines = file.readlines()

    # IN LOOP
    for line in lines:
        times.append(float(line.strip()))
    # OUT LOOP
    
    frame_registration_time = times[0]
    frame_tracking_time_mean = np.mean(times[1:])
    return frame_registration_time, frame_tracking_time_mean

import numpy as np
from scipy.spatial import cKDTree

def transform_points(pts, R, t):
    return (R @ pts.T).T + t.T

def compute_add(model_pts, pred_R, pred_t, gt_R, gt_t):
    pred_pts = transform_points(model_pts, pred_R, pred_t)
    gt_pts = transform_points(model_pts, gt_R, gt_t)
    diff = np.linalg.norm(pred_pts - gt_pts, axis=1)
    return np.mean(diff)

def compute_add_s(model_pts, pred_R, pred_t, gt_R, gt_t):
    pred_pts = transform_points(model_pts, pred_R, pred_t)
    gt_pts = transform_points(model_pts, gt_R, gt_t)
    tree = cKDTree(gt_pts)
    distances, _ = tree.query(pred_pts)
    return np.mean(distances)

def is_correct(pred_error, threshold):
    return pred_error < threshold

def main():
    print("------------------------")
    print("Stability")
    print("------------------------")
    dtm, thetaRm, tsm = stability()
    print("Mean Rotation Stability:", thetaRm)
    print("Mean Translation Stability:", dtm)
    print("Mean Total Stability:", tsm)


    print("------------------------")
    print("Reproducibility")
    print("------------------------")
    rm, rsd, tm, tsd = reproducibility()
    print("Mean Rotation Difference:", rm)
    print("Standard Deviation Rotation Difference:", rsd)
    print("Mean Translation Difference:", tm)
    print("Standard Deviation Translation Difference:", tsd)

    print("------------------------")
    print("Performance")
    print("------------------------")
    frt, fttm = performance()
    print("Frame Registration Time:", frt)
    print("Frame Tracking Time Mean:", fttm)
    print()


if __name__ == "__main__": 
    main()
