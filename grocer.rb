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
        cart[item_name][:count] -= i[:num]
      elsif i[:num] <= cart[item_name][:count] && cart.has_key?("#{item_name} W/COUPON")
        cart["#{item_name} W/COUPON"][:count] += i[:num]
        cart[item_name][:count] -= i[:num]
      end
    end
  }
  cart
end


def apply_clearance(cart)
  # code here
  cart.each_pair{|key,value|
    if value[:clearance] == true
      value[:price] -= (value[:price] * 0.2).round(2)
    end
  }
  cart
end


def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupons_applied)
  total = 0
  clearance_cart.each_pair{|key,value|
    total += value[:price] * value[:count]
  }
  if total > 100
    total -= (total * 0.1).round(2)
  end
  total
end