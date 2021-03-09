#!/bin/bash
# 基础路径
BASE_PATH=$1
# 上传jar包路径
SOURCE_PATH=$BASE_PATH/build
# 应用名称
APP_NAME=$2
# 环境
PROFILES_ACTIVE=$3

DATE=$(date +%Y%m%d%H%M)

# heapError 存放路径
HEAP_ERROR_PATH=$BASE_PATH/heapError
# JVM 参数
JAVA_OPS="-Xms1024m -Xmx1024m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$HEAP_ERROR_PATH"
# JavaAgent 参数。可用于配置 SkyWalking 等链路追踪
JAVA_AGENT=

# 备份代码
function backup() {
    # 如果不存在，则不备份
    if [ ! -f "$BASE_PATH/$APP_NAME.jar" ]; then
        echo "[backup] $BASE_PATH/$APP_NAME.jar 不存在，跳过备份"
    else
        echo "[backup] 开始备份 $APP_NAME ..."
        cp $BASE_PATH/$APP_NAME.jar $BASE_PATH/backup/$APP_NAME-$DATE.jar
    echo "[backup] 备份 $APP_NAME 完成"
    fi
}

# 更新代码
function transfer() {
    echo "[transfer] 开始转移 $APP_NAME.jar"

    # 删除原 jar 包
    if [ ! -f "$BASE_PATH/$APP_NAME.jar" ]; then
        echo "[transfer] $BASE_PATH/$APP_NAME.jar 不存在，跳过删除"
    else
        echo "[transfer] 移除 $BASE_PATH/$APP_NAME.jar 完成"
        rm $BASE_PATH/$APP_NAME.jar
    fi  

    # 复制新 jar 包
    echo "[transfer] 从 $SOURCE_PATH 中获取 $APP_NAME.jar 并迁移至 $BASE_PATH ...."
        cp $SOURCE_PATH/$APP_NAME.jar $BASE_PATH

    echo "[transfer] 转移 $APP_NAME.jar 完成"
}

# 停止
function stop() {
    echo "[stop] 开始停止 $BASE_PATH/$APP_NAME"
    PID=$(ps -ef | grep $BASE_PATH/$APP_NAME | grep -v "grep" | awk '{print $2}')
    # 如果 Java 服务启动中，则进行关闭
    if [ -n "$PID" ]; then
        # 正常关闭
        echo "[stop] $BASE_PATH/$APP_NAME 运行中，开始 kill [$PID]"
        kill -15 $PID
        # 等待最大 60 秒，直到关闭完成。
        for ((i = 0; i < 60; i++))
            do  
                sleep 1
                PID=$(ps -ef | grep $BASE_PATH/$APP_NAME | grep -v "grep" | awk '{print $2}')
                if [ -n "$PID" ]; then
                    echo -e ".\c"
                else
                    echo '[stop] 停止 $BASE_PATH/$APP_NAME 成功'
                    break
                fi
		    done
        
        # 如果正常关闭失败，那么进行强制 kill -9 进行关闭
        if [ -n "$PID" ]; then
            echo "[stop] $BASE_PATH/$APP_NAME 失败，强制 kill -9 $PID"
            kill -9 $PID
        fi
    # 如果 Java 服务未启动，则无需关闭
    else
        echo "[stop] $BASE_PATH/$APP_NAME 未启动，无需停止"
    fi
}

function start() {
    # 开启启动前，打印启动参数
    echo "[start] 开始启动 $BASE_PATH/$APP_NAME"
    echo "[start] JAVA_OPS: $JAVA_OPS"
    echo "[start] PROFILES: $PROFILES_ACTIVE"
    
    # 开始启动
    BUILD_ID=dontKillMe nohup java -server $JAVA_OPS -jar $BASE_PATH/$APP_NAME.jar --spring.profiles.active=$PROFILES_ACTIVE > $BASE_PATH/start.log & 
    echo "[start] 启动 $BASE_PATH/$APP_NAME 完成"
}

# 部署
function deploy() {
    cd $BASE_PATH
    # 备份原 jar
    backup
    # 停止 Java 服务
    stop
    # 部署新 jar
    transfer
    # 启动 Java 服务
    start
}

deploy
