  $image = Image::Magick->new;
  $image->Set(size=>'100x100');
  $image->ReadImage('canvas:white');
  $image->Set('pixel[49,49]'=>'red');