require "pry"
class Application
  @@items = Array.new

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last

      product = @@items.find {|x| x.name == item_name}

      if product.nil?
        resp.write "Item not found"
        #binding.pry
        resp.status = 400
      else
        resp.write product.price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
