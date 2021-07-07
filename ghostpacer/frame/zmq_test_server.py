import zmq
import time
import math
import numpy as np

import frame1_pb2 as Frame

avatar1_position = np.array([0, 0, 0])
avatar1_rotation = np.deg2rad(np.array([0, 180, 0]))
avatar1_toVec = np.array([0, 0, 1])
avatar1_upVec = np.array([0, 1, 0])

avatar2_position = np.array([0, 0, 5])
avatar2_rotation = np.deg2rad(np.array([0, 180, 0]))
avatar2_toVec = np.array([0, 0, 1])
avatar2_upVec = np.array([0, 1, 0])

avatar_cycles_per_second = 1

camera_position = np.array([0, 1.5, -5])
camera_forward = np.array([0, 0, 1])
camera_up = np.array([0, 1, 0])

context = zmq.Context()
socket = context.socket(zmq.PUB)
socket.bind("tcp://*:5555")
print("bound 5555")

phase = 0.0
time_prev = time.time()

if __name__ == "__main__":
    while True:
        time_now = time.time()
        if time_now > time_prev:
            delta_t = time_now - time_prev
            phase += delta_t * avatar_cycles_per_second

        time_prev = time_now
        if phase > 1.0:
            phase = phase % 1

        # AXES LISTING
        # LINEAR--   +X: LEFT    +Y: UP       +Z: FORWARD   (RIGHT HAND RULE +X CROSS +Y = +Z)
        # ANGULAR--  +X: UPWARD  +Y: CW @ -X  +Z: LEFTWARD  (LEFT HAND RULE FROM + AXES)

        frame = Frame.Frame(
            avatar1=Frame.Avatar(
                avatarPosition=Frame.Vec3(x=avatar1_position[0], y=avatar1_position[1], z=avatar1_position[2]),
                avatarToVec=Frame.Vec3(x=avatar1_toVec[0], y=avatar1_toVec[1], z=avatar1_toVec[2]),
                avatarUpVec=Frame.Vec3(x=avatar1_upVec[0], y=avatar1_upVec[1], z=avatar1_upVec[2]),

                animationPhase=phase,

                cameraPosition=Frame.Vec3(x=camera_position[0], y=camera_position[1], z=camera_position[2]),
                cameraToVec=Frame.Vec3(x=camera_forward[0], y=camera_forward[1], z=camera_forward[2]),
                cameraUpVec=Frame.Vec3(x=camera_up[0], y=camera_up[1], z=camera_up[2]),

                modelIndex=1
            ),
            avatar2=Frame.Avatar(
                avatarPosition=Frame.Vec3(x=avatar2_position[0], y=avatar2_position[1], z=avatar2_position[2]),
                avatarToVec=Frame.Vec3(x=avatar2_toVec[0], y=avatar2_toVec[1], z=avatar2_toVec[2]),
                avatarUpVec=Frame.Vec3(x=avatar2_upVec[0], y=avatar2_upVec[1], z=avatar2_upVec[2]),

                animationPhase=phase,

                cameraPosition=Frame.Vec3(x=camera_position[0], y=camera_position[1], z=camera_position[2]),
                cameraToVec=Frame.Vec3(x=camera_forward[0], y=camera_forward[1], z=camera_forward[2]),
                cameraUpVec=Frame.Vec3(x=camera_up[0], y=camera_up[1], z=camera_up[2]),

                modelIndex=1
            ),
            cameraPosition=Frame.Vec3(x=camera_position[0], y=camera_position[1], z=camera_position[2]),
            cameraToVec=Frame.Vec3(x=camera_forward[0], y=camera_forward[1], z=camera_forward[2]),
            cameraUpVec=Frame.Vec3(x=camera_up[0], y=camera_up[1], z=camera_up[2])
        )

        message = frame.SerializeToString()
        socket.send(message)

        time.sleep(1 / 90.0)
