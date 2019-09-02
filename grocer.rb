def consolidate_cart(cart)
  # Create new hash to fill
  new_cart = {}
  # Iterate over each element of cart array
  cart.each do |hash|
  hash.each do |item, descr|
  # Increment count by 1 if item already present in new_cart hash
  if new_cart[item]
    new_cart[item][:count] += 1 
    # If item not present in new_cart hash, set item as key, descr as value, & item count to 1
  else new_cart[item] = descr
    new_cart[item][:count] = 1
      end
    end
  end
new_cart
end

def apply_coupons(cart, coupons)
# If there are no coupons, break and return cart
  return cart if coupons == []
  # Create new_cart var, set it equal to cart, and make changes
  new_cart = cart
# Iterate over each element in array coupons
  coupons.each do |coupon|
    c_name = coupon[:item]
    c_num = coupon[:num]
    if cart.include?(c_name) && cart [c_name][:count] >= c_num
      new_cart[c_name][:count] -= c_num
      if new_cart.has_key?("#{c_name} W/COUPON")
        new_cart["#{c_name} W/COUPON"][:count] += coupon[:num]
      else
        new_cart["#{c_name} W/COUPON"] = {
          :price => (coupon[:cost] / coupon[:num]),
          :clearance => new_cart[c_name][:clearance],
          :count => coupon[:num]
        }
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  new_cart = cart
  cart.each do |item, hash|
    if hash[:clearance]
      new_cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    end
  end
  new_cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = 0 
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end
  if total >= 100
    total *= 0.9
  end
  total
end