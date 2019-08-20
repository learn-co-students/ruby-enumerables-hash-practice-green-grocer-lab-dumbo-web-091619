def consolidate_cart(cart)
  # code here
  newhash = Hash.new
  cart.each do |value| 
    #newitem = text.scan(/"([^"]*)"/)
    if newhash[value.keys[0]]
      newhash[value.keys[0]][:count]+=1 
    else
      newhash[value.keys[0]] = {
        :price => value.values[0][:price],
        :clearance => value.values[0][:clearance],
        :count => 1
      }
    end
end
 return newhash
end


def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
  if cart.keys.include?(coupon[:item])
    if cart[coupon[:item]][:count] >= coupon[:num]
      withCoupon = "#{coupon[:item]} W/COUPON"
      if cart[withCoupon]
        cart[withCoupon][:count]+=coupon[:num]
      else 
        cart[withCoupon] = {
          :price => coupon[:cost]/coupon[:num],
          :clearance => cart[coupon[:item]][:clearance],
          :count => coupon[:num]
        }
      end
      cart[coupon[:item]][:count]-=coupon[:num]
      end
    end
  end
 return cart
end

def apply_clearance(cart)
  # code here
  cart.keys.each do |value|
    if cart[value][:clearance]
      cart[value][:price] = (cart[value][:price]* 0.8).round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  # code here
  sortedCart = consolidate_cart(cart)
  couponCart = apply_coupons(sortedCart, coupons)
  clearedCart = apply_clearance(couponCart)
  
  total = 0 
  clearedCart.keys.each do |value|
    total = total + (clearedCart[value][:price] * clearedCart[value][:count])
  end
  if total >100
    return (total *0.9).round(2)
  end
  return total
end
