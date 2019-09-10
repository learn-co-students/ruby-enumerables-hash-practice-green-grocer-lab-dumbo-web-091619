items =
	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}},
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"AVOCADO" => {:price => 3.00, :clearance => true}}
	]


coupons =
	[
		{:item => "AVOCADO", :num => 4, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
		# {:item => "AVOCADO", :num => 4, :cost => 5.00}
	]

def consolidate_cart(cart)
  new_hash = {}
  cart.each{|i|
    i.each_pair{|key,value|
      if new_hash[key]
        new_hash[key][:count] += 1
      else
        new_hash[key] = value
        new_hash[key][:count] = 1
      end
    }
  }
 new_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each{|i|
    item_name = i[:item]
    if cart.has_key?(item_name)
      if i[:num] <= cart[item_name][:count] && !cart.has_key?("#{item_name} W/COUPON")
        cart["#{item_name} W/COUPON"] = {:price => i[:cost] / i[:num], :clearance => cart[item_name][:clearance], :count => i[:num]}
      elsif i[:num] <= cart[item_name][:count] && cart.has_key?("#{item_name} W/COUPON")
        cart["#{item_name} W/COUPON"][:count] += i[:num]
      end
      cart[item_name][:count] -= i[:num]
    end
  }
  puts cart
end

new_cart = consolidate_cart(items)
apply_coupons(new_cart,coupons)