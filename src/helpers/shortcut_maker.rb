module ShortcutMaker
  require_relative 'rendering'
  def header_mail(text)
    partial(:header_mail, :locals => {:header_text => "#{text}"}) if $layout == 'mail'
  end

  def footer_mail(comment = '')
    partial(:footer_mail, :locals => {:comment => "#{comment}"}) if $layout == 'mail'
  end

  def stub(text)
    placeholder("STUB: #{text}")
  end

  def placeholder(text)
    "<img src='https://dummyimage.com/950x250/1896E1/fff.png?text=#{text.upcase}'/>"
  end

  def img(url, alt = 'image', classes = '')
    partial(:image, :locals => {:image_url => url, :image_alt => alt, :class => classes})
  end

  def space(size)
    "<spacer size=#{size}></spacer>"
  end

  def start_temp
    "<spacer size='12'></spacer>
     <container>
     <spacer size='12'></spacer>"
  end

  def finish_temp
    "</container>
     <spacer size='30'></spacer>"
  end
end

include ShortcutMaker
