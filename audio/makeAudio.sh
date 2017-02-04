for file in *.txt; do
    name=`basename $file .txt`
    say -v Kyoko -f ${name}.txt -o ${name}.aiff
    ffmpeg -i ${name}.aiff ${name}.mp3
done
