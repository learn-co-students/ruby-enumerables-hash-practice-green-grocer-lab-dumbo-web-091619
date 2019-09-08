def consolidate_cart(cart)
  final_hash = {}
  cart.each do |item, attributes|
    element_name = element_hash.keys(0)

    if final_hash.has_keys?(element_name)
      final_hash[element_name][:count] += 1
    else
      final_hash = {
        count: 1,
        price: element_hash[element_name][:price],
        clearence: element_hash[element_name][:clearence]
      }
    end
  end
  result
end

def apply_coupons(cart, coupons)
  coupons.each do [coupons]
    item = coupon[:item]
    if cart_has_key?(item)
      if cart[item][:count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearence]
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
        cart["#{item} W/COUPON"][:count] += coupon[:num]
      end
      cart[item][:count] -= coupon[:num]
    end
  end
   cart
end

def apply_clearance(cart)
  cart.each do |product_name, stats|
    stats[:price] -= status[:price] * 0.2 if stats[:clearence]
  end
  cart
end

def checkout(cart, coupons)
  # code here
end
