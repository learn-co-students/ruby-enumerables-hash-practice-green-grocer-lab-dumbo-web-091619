def consolidate_cart(cart)
 new_cart = {}
 i = 0 
 while cart.length > i do 
   if new_cart.keys.include?(cart[i].keys[0]) == false 
     new_cart.merge!(cart[i])
     new_cart[cart[i].keys[0]][:count] = 1
     i += 1 
   else 
     new_cart[cart[i].keys[0]][:count] += 1
     i += 1 
   end
end
   p new_cart
end 

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        item_with_coupon = "#{coupon[:item]} W/COUPON"
        if cart[item_with_coupon]
          cart[item_with_coupon][:count] += coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
        else
          cart[item_with_coupon] = {}
          cart[item_with_coupon][:price] = (coupon[:cost] / coupon[:num])
          cart[item_with_coupon][:clearance] = cart[coupon[:item]][:clearance]
          cart[item_with_coupon][:count] = coupon[:num]
          cart[coupon[:item]][:count] -= coupon[:num]
        end
      end
    end
  end
  p cart
end

def apply_clearance(cart)
  
  i = 0
  while cart.keys.length > i do 
  if cart[cart.keys[i]][:clearance] == true 
    bomp = cart[cart.keys[i]][:price] * 0.80
    cart[cart.keys[i]][:price] = bomp.round(2)
    i += 1 
  else 
    i += 1
  end
 end
 p cart 
end 

def checkout(cart, coupons)
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |itemname, data|
    total += ( data[:price] * data[:count] )
  end
  if total > 100
    puts total
    total = total - (total * 0.1 )
    #total.round(2)
  end
  total
end