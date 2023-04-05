diff build-package.yml compare/build-package.yml.bak > /dev/null
if [  "$?" == "0" ]; then #"$?"是上一执行命令的返回值。
    echo "nothing to change"
    else
    sudo snap install yq
    cp build-package.yml build-package-2.yml #制作实时更新的带有修改记录的action文件
    cp build-package.yml compare/build-package.yml.bak #为下次比较否有变化做准备
    myenv=$(cat compare/tags-build) yq -i '.jobs.Create-release_Send-message=env(myenv)' build-package-2.yml  # 把生成修改记录的action放入build-2.yml
    yq -i '.name="NAStool Package-2"' build-package-2.yml
    cat build-package-2.yml
    git add .
    git commit -m "update build-package-2.yml"
    fi
