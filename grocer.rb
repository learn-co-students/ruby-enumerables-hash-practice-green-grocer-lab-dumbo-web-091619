def consolidate_cart(cart) 
  new_cart = {} 
  cart.each do |items_array| 
    items_array.each do |item, attribute_hash| 
      new_cart[item] ||= attribute_hash 
        new_cart[item][:count] ? new_cart[item][:count] += 1 :   
        new_cart[item][:count] = 1 
  end 
end 
new_cart 
end

def apply_coupons(cart, coupons)
  new_cart1 = {}
  cartcheck = cart.keys
  x=0
    cartcheck.each do |check|
      while x<coupons.length do
        if check == coupons[x][:item] && cart[check][:count]>=coupons[x][:num]
         if cart["#{check} W/COUPON"]
          cart["#{check} W/COUPON"][:count] += coupons[x][:num]
          cart[check][:count] -=  coupons[x][:num]
         else
          cart["#{check} W/COUPON"] = {:price => coupons[x][:cost]/coupons[x][:num],  :clearance =>
            cart[check][:clearance], :count => coupons[x][:num]
          }
          cart[check][:count] = cart[check][:count] - coupons[x][:num]
         end  
        end
        x+=1
      end
     x=0
    end
  cart
end

def apply_clearance(cart)
  check2 = cart.keys
    check2.each do |check|
      if cart[check][:clearance] == true
        cart[check][:price] = cart[check][:price]-(cart[check][:price]/100)*20
      end
    end
  cart
end

def checkout(cart, coupons)
  total=0
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  fully_new_cart = apply_clearance(coupons_applied)
  keyss = fully_new_cart.keys
  keyss.each do |som|
    total += fully_new_cart[som][:price]*fully_new_cart[som][:count]
  end
  if total > 100
  total = total-(total/100)*10
  total
else 
  total
end
end





























