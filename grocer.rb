CLEARANCE_PERCENT = 0.2
def consolidate_cart(cart)
  cart.reduce({}) do |memo, value| 
    value.each do|key, value|
      if !memo[key]
        value[:count] = 0
        memo[key] = value
      end
      memo[key][:count] += 1
    end
    memo
  end
end

def apply_coupons(cart, coupons)
  for coupon in coupons
    if cart[coupon[:item]]
      add_coupon_if_applicable(coupon, cart)
    end
  end
  cart
end

def add_coupon_if_applicable(coupon, cart)
  item_name = coupon[:item]
  number_of_times_to_apply = cart[item_name][:count] / coupon[:num]
  if number_of_times_to_apply > 0 
    cart["#{item_name} W/COUPON"] = {
      price: coupon[:cost] / coupon[:num],
      clearance: cart[item_name][:clearance],
      count: number_of_times_to_apply * coupon[:num]
    }
    cart[coupon[:item]][:count] -= cart["#{coupon[:item]} W/COUPON"][:count]
  end
end


def apply_clearance(cart)
  cart.each_value do |item_details|
    if_clearance_apply_discount(item_details)
  end
end

def if_clearance_apply_discount(item)
  if !!item[:clearance]
    item[:price] -= item[:price] * CLEARANCE_PERCENT
  end
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  apply_coupons(consolidated_cart, coupons)
  apply_clearance(consolidated_cart)
  
  total = consolidated_cart.reduce(0) do |memo, (key, value)|
    memo += value[:price] * value[:count]
    memo
  end
  
  total > 100 ? total -= total  * 0.1 : total
end
