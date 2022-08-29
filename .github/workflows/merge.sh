yq '.jobs.create-release' build.yml>tmp-build-2.txt
if [ diff tmp-build-2.txt tmp-build1.txt =""]; 
    then
    echo "nothing to change"
    else
    cp build.yml build-2.yml
    cp tmp-build-2.txt tmp-build1.txt  #比较前后是否有变化
    myenv=$(cat tmp-build.txt) yq -i '.jobs.create-release=env(myenv)' build-2.yml
    yq -i '.name="Nas-tools Build-2"' build-2.yml
    cat build-2.yml
    git add .
    git commit -m "recreate build-2.yml"
    fi
