class Response

  def hello(counter)
    "HELLO WORLD(#{counter})"
  end

  def datetime
    t = Time.new
    t.strftime("%l:%M%p on %A, %B %e, %Y")
  end

  def shutdown(counter)
    "Total Requests: #{counter}"
  end

  def word_search(request)
    word = request[0].split(" ")[1].split("word")[2].delete("=")
    if File.read("/usr/share/dict/words").include?("#{word}")
      "#{word.capitalize} is a known word."
    else
      "#{word.capitalize} is not a known word."
    end
  end

end
