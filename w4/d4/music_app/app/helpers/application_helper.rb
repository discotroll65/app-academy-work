module ApplicationHelper
  def csrf_tag
    html = <<-HTML
      <input
        type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}"
      >
      HTML
    html.html_safe
  end

  def ugly_lyrics(lyrics)

    lyrics_array = lyrics.split("\r\n")
    ugly_lyrics_array = lyrics_array.map{|line| "&#9835;" + " " + h(line)  }
    ugly_lyrics_string = ugly_lyrics_array.join("\r\n").html_safe
  end
end
