permissionServer="jsb1111@192.168.26.90"
filName=$1

# 向远程地址传输文件
scp ${filName} ${permissionServer}:/home/jsb1111/workspace/tmpStaticFiles/
