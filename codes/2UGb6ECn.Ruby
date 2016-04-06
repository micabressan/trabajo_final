require 'mbuild/images/resize'
require 'mbuild/images/add_text'

task :prepare_icons do |t|
  # Описания размеров иконок для Android
  ICON_SIZES = [
    {width:  48, height:  48, name: :mdpi},
    {width:  72, height:  72, name: :hdpi},
    {width:  96, height:  96, name: :xhdpi},
    {width: 144, height: 144, name: :xxhdpi},
    {width: 192, height: 192, name: :xxxhdpi}
  ]

  # Выберем исходную картинку для ресайза
  resized = t.resize(["res/mipmap-xxhdpi/ic_launcher.png", "res/mipmap-xxhdpi/ic_launcher_debug.png"], sizes: ICON_SIZES)

  # Для каждого набора иконок подготовим соответсуюшую виртуальную папку
  mapped = ICON_SIZES.map do |sz|
    name = sz[:name].to_s
    desc = "%dx%d" % [sz[:width], sz[:height]]
    t.expand(resized => "#{desc}/**", resized => "#{name}:#{desc}:**")
  end

  # Если нужно, пометим иконку текстом с версией
  branch = `hg branch`
  version = c.version_name

  final = c.debug ? t.add_text(mapped, text: "#{branch}\n#{c.debug ? "(debug)" : ""}") : mapped
  t.backet_add(final)
end