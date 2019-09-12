def consolidate_cart(cart)
  new_hash = {}
  cart.each do |grocery_item|
    grocery_item.each do |name, info|
     if new_hash[name]
       new_hash[name][:count] += 1
     else 
       new_hash[name] = info
       new_hash[name][:count] = 1
     end
    end
  end
  return new_hash
end

def apply_coupons(cart, coupons)
  new_hash = {}
  cart.each do |grocery_item, value|
    coupons.each do |n|
      if grocery_item == n[:item] && value[:count] >= n[:num]
        cart[grocery_item][:count] = cart[grocery_item][:count] - n[:num]

        if new_hash[grocery_item + " W/COUPON"]
          new_hash[grocery_item  + " W/COUPON"][:count] += n[:num] 
        else 
          new_hash[grocery_item + " W/COUPON"] = {:price => n[:cost]/n[:num], :clearance => cart[grocery_item][:clearance], :count => n[:num]}
        end
      end
    end
    new_hash[grocery_item] = value
  end
    return new_hash
end



def apply_clearance(cart)
  cart.each do |grocery_item, value|
    if value[:clearance] == true
      value[:price] = value[:price] - value[:price] * 0.20
    end
  end
  return cart 
end


def checkout(cart, coupons)
  puts cart 
  puts "********************"
  new_cart1 = consolidate_cart(cart)
  puts new_cart1
  puts"@@@@@@@@@@@@@@@@@@@@@@@@"
  new_cart2 = apply_coupons(new_cart1,coupons)
  puts new_cart2
  puts "$$$$$$$$$$$$$$$$$$$$$$$"
  new_cart3 = apply_clearance(new_cart2)
  puts new_cart3
  puts "^^^^^^^^^^^^^^^^^^^^^^^"
  new_hash = {}
  new_cart3.each do |grocery_item, value|
    value[:price] = value[:price] * value[:count] 
    puts value
    puts "&&&&&&&&&&&&&&&&&&&&&&&"
  end
  total_cost = 0
  new_cart3.each do |grocery_item, value|
    total_cost = total_cost + value[:price]
    puts total_cost
    puts "!!!!!!!!!!!!!!!!!!!"
    if total_cost >= 100.0 
      total_cost = total_cost - total_cost * 0.10
    end
  end
  return total_cost
end
