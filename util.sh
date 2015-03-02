fileCount()
{
  fileName=$1
  fileCount=`wc -l $fileName | cut -d" " -f1`
}

freshFile()
{
  fileName=$1
  rm -rf $fileName
  touch $fileName
}

scpFiles()
{
  instance=$1
  baseDir=$2
  privateKey=$3
  declare -a files=("${!4}")
  echo "SCPing files to $instance"
  for file in "${files[@]}"
  do
    scpCmd="scp -i $privateKey $file $instance:$baseDir/"
    echo $scpCmd
    `$scpCmd`
  done  
}

runScreen()
{
  instance=$1
  privateKey=$2
  screenName=$3
  screenScript=$4
  cmd=$5
  echo "Running screen in $instance with screen name $screenName and command $cmd"
  `echo "$screenScript $screenName $cmd" | ssh -i $privateKey $instance /bin/sh`
}
