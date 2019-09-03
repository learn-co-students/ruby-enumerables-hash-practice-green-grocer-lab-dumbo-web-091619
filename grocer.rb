def consolidate_cart(cart)
my_hash = {}
cart.each do|element_hash|
element_name = element_hash.keys[0]

if  my_hash.has_key?(element_name)
  my_hash[element_name][:count]+=1
else
    my_hash[element_name] = {
         count: 1,
         price: element_hash[element_name][:price],
         clearance: element_hash[element_name][:clearance]
    }
    end
  end
  my_hash
end

def apply_coupons(cart, coupons)
return cart if coupons == []
applied_cart = cart
coupons.each do |coupon|
    itemwc = coupon[:item]
   coupnum = coupon[:num]
   if cart.include?(itemwc) && cart[itemwc][:count] >= coupnum
applied_cart[itemwc][:count] -= coupnum
if applied_cart.has_key?("#{itemwc} W/COUPON")
       applied_cart["#{itemwc} W/COUPON"][:count] += coupon[:num]
     else
       applied_cart["#{itemwc} W/COUPON"] = {
         :price => (coupon[:cost] / coupon[:num]),
         :clearance => applied_cart[itemwc][:clearance],
         :count => coupon[:num]
       }
      end
    end
 end
   applied_cart
end

 def apply_clearance(cart)
cart.keys.each do|name|
  if cart[name][:clearance]
    cart[name][:price] = (cart[name][:price]*0.80).round(2)
  end
 end
 cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart,coupons)
  apply_clearance(new_cart)
  total = 0
  new_cart.each do |name,hash|
    total += (hash[:price]*hash[:count])
 end
 if total >= 100
   total *= 0.9
 end
 total
 end
