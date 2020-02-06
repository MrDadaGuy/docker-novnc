# docker-novnc
a framework for a docker image with support for novnc, jupyter, tensorflow2, python3, lightweight UI

---

1.  To get this working, [install latest docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) from docker web site.  Don't use the version from your APT repository.

2.  Make sure you have proprietary nvidia driver installed on linux host machine.

3.  run:  `sudo apt-get install nvidia-container-toolkit`

4.  You'll want to change the **"veggiebenz/pyimagesearch:v1"** in **build.sh** and **run.sh** to something meaningful for you.  See [docker documentation](https://docs.docker.com/engine/reference/commandline/build/#tag-an-image--t) for details.

