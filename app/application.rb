class Application

  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/) then
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/) then
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/) then
      if @@cart == [] then
        resp.write "Your cart is empty"
      else
        resp.write @@cart.join("\n")
      end
    elsif req.path.match(/add/) then
      search_items = req.params["item"]
      if @@items.include? search_items then
        @@cart << search_items
        resp.write "added #{search_items}"
      else 
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
