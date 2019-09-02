def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |x| 
    if cart_hash[x.keys[0]]
      cart_hash[x.keys[0]][:count]+=1 
    else
      cart_hash[x.keys[0]] = {
        :price => x.values[0][:price],
        :clearance => x.values[0][:clearance],
        :count => 1
      }
    end
end
cart_hash
end



def apply_coupons(cart, coupons)
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
  cart.keys.each do |x|
    if cart[x][:clearance]
      cart[x][:price] = (cart[x][:price]* 0.8).round(2)
    end
  end
  return cart
end


def checkout(cart, coupons)
  sortedCart = consolidate_cart(cart)
  couponCart = apply_coupons(sortedCart, coupons)
  clearedCart = apply_clearance(couponCart)
  total = 0 
  clearedCart.keys.each do |x|
    total = total + (clearedCart[x][:price] * clearedCart[x][:count])
  end
  if total >100
    return (total *0.9).round(2)
  end
  return total
end
