#! /bin/bash

IMAGE_DIR=$1
PAGE_DIR=$2
POST_DIR=$3

base_dir=`pwd`

for saison in `ls $IMAGE_DIR`
do 
  
  mkdir -p $POST_DIR/$saison
  
  saison_1=$(echo "$saison" | awk '{split($0,a,"-"); print a[1]}')
  saison_2=$(echo "$saison" | awk '{split($0,a,"-"); print a[2]}')

  cp template_index.md $POST_DIR/$saison/$saison_1-09-01-index_photo_${saison_1}_$saison_2.md

  cd $IMAGE_DIR/$saison
  galleries=""  

  for match in `ls .`
  do

    date=$(echo "$match" | awk '{split($0,a,"-"); print a[1]"-"a[2]"-"a[3]}')

    team_1=$(echo "$match" | awk '{split($0,a,"-"); print a[4]}')
    team_2=$(echo "$match" | awk '{split($0,a,"-"); print a[5]}')    

    team_title_1=$(echo "$team_1" | sed -e s/_/" "/g)
    team_title_2=$(echo "$team_2" | sed -e s/_/" "/g)

    cd $base_dir
      cp template_gallery.md $POST_DIR/$saison/${date}-${team_1}-${team_2}.md
    cd -

    cd $base_dir
     sed -i "s@%SAISON%@$saison@" $POST_DIR/$saison/$saison_1-09-01-index_photo_${saison_1}_$saison_2.md
     sed -i "s@%TEAM_1%@${team_title_1^}@" $POST_DIR/$saison/$saison_1-09-01-index_photo_${saison_1}_$saison_2.md
     sed -i "s@%TEAM_2%@${team_title_2^}@" $POST_DIR/$saison/$saison_1-09-01-index_photo_${saison_1}_$saison_2.md

     sed -i "s@%SAISON%@$saison@" $POST_DIR/$saison/${date}-${team_1}-${team_2}.md
     sed -i "s@%TEAM_1%@${team_title_1^}@" $POST_DIR/$saison/${date}-${team_1}-${team_2}.md
     sed -i "s@%TEAM_2%@${team_title_2^}@" $POST_DIR/$saison/${date}-${team_1}-${team_2}.md
    cd -
    
    images_url=""
    galleries=$galleries"  - gallery:\n"
 
    echo "MATCH $match"

    cd $match
    rm *-thumb.jpg    

    for i in `ls *.jpg`
    do
      images_url=$images_url"  - image_url: match/$saison/${date}-${team_1}-${team_2}/$i\n" 
      galleries=$galleries"    - image_url: match/$saison/${date}-${team_1}-${team_2}/$i\n" 
    done 
    
     galleries=$galleries"    title: ${team_title_1} vs ${team_title_2}\n    url: /beta/senior/photo/match/$saison/${team_1}-${team_2}/\n"
    
    for i in `ls *.jpg`
    do

      filename=$(basename "$i")
      extension="${filename##*.}"
      filename="${filename%.*}"

      echo "Processing image $i ..."
      /usr/bin/convert -thumbnail 200 $i "$filename-thumb.$extension"

    done
   
    cd $base_dir
     sed -i "s@%LIST_IMAGE%@$images_url@" $POST_DIR/$saison/${date}-${team_1}-${team_2}.md
    cd $IMAGE_DIR/$saison

  done

  cd $base_dir
  sed -i "s@%GALLERIES%@$galleries@" $POST_DIR/$saison/$saison_1-09-01-index_photo_${saison_1}_$saison_2.md
  
done
