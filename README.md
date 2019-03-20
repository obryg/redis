# Redis Master, Slaves, Sentinels Statefulset Docker image

To be able to launch master, slave and sentinels in Kubernetes or OpenShift, we previously need to start a master, then slaves and sentinels, and to remove the master.

That image is able to startup in Statefulset mode.

The first redis server that starts is the Master. Others will be slaves. If master pod is down, so Sentinels elect an new Master.

See [](redis-cluster.yml) that is an example of making that image working as Statefulset.