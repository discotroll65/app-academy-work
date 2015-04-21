class XmlDocument
  attr_accessor :open_tag, :close_tag

  def initialize
    @open_tag = "<"
    @close_tag = "/>"
  end

  def hello(person = {:name => nil})
    text = yield
    "<hello>#{text}</hello>"
  rescue LocalJumpError

    name = person[:name] 
    hello_tag = "hello"
    name_tag = ""
    name_tag += " name=\'#{name}\'" if name
    result = tagify(hello_tag + name_tag)
  end

  def tagify(string)
    open_tag + string + close_tag
  end

  def send(tag_name)
    tagify(tag_name)
  end

  def goodbye
    send("goodbye")
  end

end
