#!/bin/sh
export LANG="en_US.UTF-8"
REJECT=0

while read oldrev newrev refname; do
    if [ "$oldrev" = "0000000000000000000000000000000000000000" ];then
        oldrev="${newrev}^"
    fi

    files=`git diff --name-only ${oldrev} ${newrev}  | grep -e "\.java$"`

    if [ -n "$files" ]; then
        TEMPDIR="tmp"
        for file in ${files}; do
            mkdir -p "${TEMPDIR}/`dirname ${file}`" >/dev/null
            git show $newrev:$file > ${TEMPDIR}/${file}
        done;

        files_to_check=`find $TEMPDIR -name '*.java'`
        
        
         /home/jdk1.8.0_212/bin/java -cp /home/p3c-pmd-1.3.6.jar net.sourceforge.pmd.PMD -d $TEMPDIR -R rulesets/java/ali-comment.xml,rulesets/java/ali-concurrent.xml,rulesets/java/ali-constant.xml,rulesets/java/ali-exception.xml,rulesets/java/ali-flowcontrol.xml,rulesets/java/ali-naming.xml,rulesets/java/ali-oop.xml,rulesets/java/ali-orm.xml,rulesets/java/ali-other.xml,rulesets/java/ali-set.xml -f text
       
         REJECT=$?
         
         
          if [[ $REJECT == 0 ]] ;then
            echo -e "\033[32m恭喜你代码通过质量检测！\033[0m"
             else echo -e "\033[31m\033[01m 请及时修改代码并再次尝试\033[0m" 
          fi
     
        rm -rf $TEMPDIR
    fi
done

exit $REJECT