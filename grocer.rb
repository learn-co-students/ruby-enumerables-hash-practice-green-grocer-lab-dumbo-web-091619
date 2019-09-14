def consolidate_cart(cart)
  # code here
  my_cart = {}
  cart.each do |item|
    item.each do |name, info|
      if my_cart[name]
        my_cart[name][:count] += 1
      else
        my_cart[name] = info
        my_cart[name][:count] = 1
      end
    end
  end
  my_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item]) #checks cart to see if there's a couponable item
      if cart[coupon[:item]][:count] >= coupon[:num] #checks to see no of couponable items is >= available coupons
        item_with_coupon = "#{coupon[:item]} W/COUPON" #adds a new key, value pair to the cart hash called 'ITEM NAME W/COUPON'
        if cart[item_with_coupon]
          cart[item_with_coupon][:count] += coupon[:num] #increase count of couponable items. Aslo accounts for when there are more items than coupon allows
          cart[coupon[:item]][:count] -= coupon[:num] #decrease available coupon count
        else #if the item is not in the cart, create an instance of it in the cart hash
          cart[item_with_coupon] = {} #creates the key value pair
          cart[item_with_coupon][:price] = (coupon[:cost] / coupon[:num]) #adds the coupon price to the property hash of couponed item
          cart[item_with_coupon][:clearance] = cart[coupon[:item]][:clearance] #adds clearance status pair to the value hash of the item
          cart[item_with_coupon][:count] = coupon[:num] #adds the count no to the property hash of couponed item
          cart[coupon[:item]][:count] -= coupon[:num] #removes the number of discounted items from the original item's count
        end
      end
    end
  end
  cart

end

def apply_clearance(cart)
  # code here
  item_after_couponizing = {}
  cart.each do |item, attributes|
    if attributes[:clearance] == true #ensures item is on clearance
      price = attributes[:price] - attributes[:price] * 0.2 #takes 20% off
      item_after_couponizing[item] = {price: price,
                                      clearance: attributes[:clearance], 
                                      count: attributes[:count]
                                    }
    else
      item_after_couponizing[item] = attributes
    end
  end
  item_after_couponizing
end

def checkout(cart, coupons)
  # code here
  total = 0
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)

  
  clearance_cart.each do |name, attribute|
    total += (attribute[:price] * attribute[:count])
  end

  total > 100 ? total -= total * 0.1 : nil

  total

  
end
