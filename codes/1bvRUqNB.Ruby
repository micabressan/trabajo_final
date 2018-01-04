#!/usr/bin/ruby
require "pry"
fps=29.97
images_list=Dir["*.png"].select{|z| z=~/[0-9]{3}\.png/}.sort
dissolve_frames=4
timing=ARGV[0]
resize=ARGV[1]
resize_str=resize==nil ? "" : ".lanczos4resize(#{resize.split("x").join(",")})"
cutpoints=File.read(timing).split("\n").map{|z| t=z.split("\t");[(t[0].to_f*fps),(t[1].to_f*fps),t[2]]}
kezdetek=cutpoints.transpose[0].map{|z| z.round}
hosszak=[]
for i in 0..cutpoints.size-2 do
  hosszak[i]=kezdetek[i+1]-1-kezdetek[i]-2
end
hosszak[cutpoints.size-1]=(cutpoints[cutpoints.size-1][1]-cutpoints[cutpoints.size-1][0]).round


image_avs=""


for i in 0..cutpoints.size-1 do
 
 ex=0
 #image_avs+=%Q{image#{"%03d" % i}=ImageSource("#{"%03d" % i}.png", end = #{(hosszak[i]+(i==0  ? dissolve_frames/2+1 : dissolve_frames+1)).round},fps=#{fps.to_s})\n}
 image_avs+=%Q{image#{"%03d" % i}=ImageSource("#{images_list[i % images_list.size]}", end = #{(hosszak[i]+(i==0  ? dissolve_frames/2+1 : dissolve_frames+1)).round},fps=#{fps.to_s})\n}
 
end


 image_avs+=cutpoints.collect.with_index.map{|z,i| "image#{"%03d" % i}"}.join("++")+"\n"


cutpoints=cutpoints.map{|z| z[0..1]}.flatten




  i=0
  cp_avs=image_avs+"c#{i}=image#{"%03d" % i}.trim(0,image#{"%03d" % i}.framecount-#{dissolve_frames})\n"
  i=1
  while i<=(cutpoints.size)-4
     cp_avs+="c#{i}=dissolve(image#{"%03d" % ((i)/2)}.trim(image#{"%03d" % ((i)/2)}.framecount-#{dissolve_frames}+1,image#{"%03d" % ((i)/2)}.framecount-1),image#{"%03d" % (i/2+1)}.trim(0,#{dissolve_frames}-1),#{dissolve_frames})\n"
     cp_avs+="c#{i+1}=image#{"%03d" % (i/2+1)}.trim(#{dissolve_frames},image#{"%03d" % (i/2+1)}.framecount-#{dissolve_frames})\n"
     i+=2
  end
  cp_avs+="c#{cutpoints.size-3}=dissolve( image#{"%03d" % ((cutpoints.size-3)/2)}.trim( image#{"%03d" % ((cutpoints.size-3)/2)}.framecount-#{dissolve_frames}+1,image#{"%03d" % ((cutpoints.size-3)/2)}.framecount-1),image#{"%03d" % ((cutpoints.size-2)/2)}.trim(0,#{dissolve_frames}-1),#{dissolve_frames})\n"
  cp_avs+="c#{cutpoints.size-2}=image#{"%03d" % ((cutpoints.size-2)/2)}.trim(#{dissolve_frames},image#{"%03d" % ((cutpoints.size-2)/2)}.framecount-2)\n"
  cp_avs+="c#{cutpoints.size-1}=FadeOut2(loop(image#{"%03d" % ((cutpoints.size-2)/2)}.trim(image#{"%03d" % ((cutpoints.size-2)/2)}.framecount-1,image#{"%03d" % ((cutpoints.size-2)/2)}.framecount-2),61),60)\n" 
  cp_avs+=(0..cutpoints.size-2).map{|z| "c#{z}"}.join("++")
  cp_avs+="\nconverttoyv12().ylevels(gamma=1.25)"
  puts cp_avs+"\nylevels(gamma=1.4)"
  File.write "1.avs",cp_avs