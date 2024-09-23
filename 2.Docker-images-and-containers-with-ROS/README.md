# Docker-images-and-containers-with-ROS


## Committing a ROS Container as a Docker Image

Once you've made changes or added configurations to a running ROS container, you can save the container’s state as a new Docker image using the `docker commit` command. This allows you to preserve your setup and share it or use it later without reconfiguring from scratch.

#### Steps to Commit a ROS Container as a Docker Image:

### 1. **Run the ROS Container**
If you haven't already started a container, run your ROS container:
```bash
docker run -it ros:noetic-ros-core
```
Make any changes or configurations inside the container that you want to preserve.

### 2. **Get the Container ID**
In another terminal window, list all running containers to get the Container ID or name of your running ROS container:
```bash
docker ps
```
You will see output similar to this:
```
CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS     NAMES
abc123xyz456   ros:noetic-ros-core  "/bin/bash"              5 minutes ago   Up 5 minutes             gallant_knuth
```
In this case, the Container ID is `abc123xyz456` and the name is `gallant_knuth`.

### 3. **Commit the Container to an Image**
Use the `docker commit` command to save the current state of the container as a new image:
```bash
docker commit <container_id_or_name> my_ros_image
```
For example:
```bash
docker commit abc123xyz456 my_ros_image
```
This command creates a new image named `my_ros_image` based on the current state of the container.

### 4. **Verify the New Image**
List all Docker images to verify that the new image has been created:
```bash
docker images
```
You should see an output similar to this:
```
REPOSITORY      TAG           IMAGE ID       CREATED          SIZE
my_ros_image    latest        d1234abc5678   1 minute ago     500MB
ros             noetic-ros-core  e3456def7890   2 hours ago     450MB
```

### 5. **Run the New Image**
Now you can run a new container from the committed image with:
```bash
docker run -it my_ros_image
```
This container will start with all the changes and configurations that were present when you committed the image.

### 6. **Tag the Image (Optional)**
To organize your Docker images or prepare them for sharing, you can tag your new image:
```bash
docker tag my_ros_image my_dockerhub_username/my_ros_image:version1
```

### 7. **Push the Image to Docker Hub (Optional)**
If you want to share your ROS image with others, push it to Docker Hub:
```bash
docker login
docker push my_dockerhub_username/my_ros_image:version1
```

## How to Mirror a Directory to a Docker Container

To mirror or share a directory between your local system and a Docker container, you can use **Docker volumes** or **bind mounts**. This allows you to link a directory from your host machine to a path inside the container so that any changes made on either side are reflected in real time.

Below are the steps to bind a local directory to a Docker container, mirroring files between the host and the container.

### Steps to Mirror a Local Directory into a Docker Container:

#### 1. **Create or Choose a Local Directory**

Identify or create the directory you want to mirror to your container. For example, let's say you have a directory on your local system called `/home/user/my_ros_workspace` that you want to mirror.

#### 2. **Run the Docker Container with Bind Mount**
When running a Docker container, you can use the `-v` or `--mount` option to bind the local directory to a container directory.

- **Bind Mount using `-v` flag**:
    ```bash
    docker run -it -v /home/user/my_ros_workspace:/root/ros_workspace ros:noetic-ros-core
    ```

- **Bind Mount using `--mount` flag** (recommended for better readability and flexibility):
    ```bash
    docker run -it --mount type=bind,source=/home/user/my_ros_workspace,target=/root/ros_workspace ros:noetic-ros-core
    ```

In this example:
- `/home/user/my_ros_workspace`: The local directory on your host machine.
- `/root/ros_workspace`: The directory inside the Docker container where the files will be mirrored.

This command starts the container and binds the local directory to the container's `/root/ros_workspace` directory. Changes to either directory will be reflected on both the host and container side in real time.

#### 3. **Access the Mirrored Directory Inside the Container**

Once inside the running container, navigate to the mirrored directory to see the files from your local system:
```bash
cd /root/ros_workspace
ls
```

You will see the same files that are in your local `/home/user/my_ros_workspace` directory. Any files created or modified inside this container directory will be reflected on your local machine, and vice versa.

#### 4. **Stop and Restart the Container**
You can stop the container and restart it, and the bind mount will persist as long as you specify the `-v` or `--mount` option again.

To stop the container:
```bash
exit
```

To restart with the same bind mount:
```bash
docker run -it --mount type=bind,source=/home/user/my_ros_workspace,target=/root/ros_workspace ros:noetic-ros-core
```

