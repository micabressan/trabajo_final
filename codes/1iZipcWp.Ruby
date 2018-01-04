#!/usr/bin/ruby
require "pry"
require "json"
if File.exists?("szinek.json") then
  colors=JSON.load(File.read("szinek.json")).map{|k,v| [k,v.scan(/[0-9]+/).flatten.map{|q| q.to_i.to_s(16).rjust(2,"0").upcase}.join.prepend("$")]}.to_h
  
else
  colors={}
  colors.default="$000000"
end
fps=29.97

gh=720
gw=1280

images_list=Dir["*.png","*.jpg"].sort.shuffle
dims=images_list.map{|z| 
   ret=%x{identify '#{z}'};
   md=/([0-9]+)x([0-9]+)/.match(ret)
   w=md[1].to_i
   h=md[2].to_i
   if w.fdiv(h) > gw.fdiv(gh) then
     nw=gw
     nh=(nw*h.fdiv(w)).round
     pad_left=0
     pad_top=((gh-nh).fdiv(2)).round
     pad_right=0
     pad_bottom=gh-nh-pad_top
   else
     nh=gh
     nw=(nh*w.fdiv(h)).round
     
     pad_left=((gw-nw).fdiv(2)).round
     pad_top=0
     pad_right=gw-nw-pad_left
     pad_bottom=0
   end
   [z,[nw,nh,pad_left,pad_top,pad_right,pad_bottom,colors[z]]]
}.to_h

binding.pry
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



binding.pry
image_avs=""


for i in 0..cutpoints.size-1 do
 
 ex=0
 #image_avs+=%Q{image#{"%03d" % i}=ImageSource("#{"%03d" % i}.png", end = #{(hosszak[i]+(i==0  ? dissolve_frames/2+1 : dissolve_frames+1)).round},fps=#{fps.to_s})\n}
 data=dims[images_list[i % images_list.size]]
 image_avs+=%Q{image#{"%03d" % i}=ImageSource("#{images_list[i % images_list.size]}", end = #{(hosszak[i]+(i==0  ? dissolve_frames/2+1 : dissolve_frames+1)).round},fps=#{fps.to_s}).lanczos4resize(#{data[0]},#{data[1]}).addborders(#{data[2]},#{data[3]},#{data[4]},#{data[5]},color=#{data[6]})\n}
 
end


 image_avs+=cutpoints.collect.with_index.map{|z,i| "image#{"%03d" % i}"}.join("++")+"\n"


cutpoints=cutpoints.map{|z| z[0..1]}.flatten

binding.pry


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
  command=%Q{wine avs2yuv.exe 1.avs - | ffmpeg -y -f yuv4mpegpipe -i - -i 1.wav -map 0:v -map 1:a -c:v libx264 -preset medium -crf 8  -filter_complex " [1:0] apad, dynaudnorm "  -c:a libmp3lame -b:a 320k -shortest 1.mkv}
  puts command
  #system command