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
      while x<coupons.length
        if check == coupons[x][:item]
          cart["#{check} W/COUPON"] = {:price => coupons[x][:cost]/coupons[x][:num],  :clearance =>
            cart[check][:clearance], :count => coupons[x][:num]
          }
          cart[check][:count] = cart[check][:count] - coupons[x][:num]
        end
        x+=1
      end  
    end
    cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
