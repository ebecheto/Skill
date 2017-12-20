list=(0.5 0.6 0.7 0.8 0.9); echo ${list[@]}; echo ${list[2]}

list=(1053 1051 1047 1041 1039 1033 1029 1027 1021 1019 1015 1009 1007 1001 997 995 991 985 981 979 973 971 967 961 959 953 949 947 941 939 935 929 925 923 919 913 911 905 901 899 895 889 885 883 877 875 871 865 861 859 855 849 847 841 837 835 829 827 823 817 815 809 805 803)

for i in {0..3}; do
    eval "declare -a a$i=( $(for j in {0..4}; do echo 0; done) )"
done

for file in *.il;do if grep -q ";; copyleft ebecheto" $file ; then echo "git add $file";fi;donefor file in *.rtf;do mv $file ${file%.rtf}.html;done


rm sum.txt
for file in *.il;do if grep -q ";; copyleft ebecheto" $file ; then cat $file |sed '/^;/d;/^$/d' |wc -l>>sum.txt;fi;done
sum sum.txt #==> 20529

