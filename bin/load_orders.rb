Order.transaction do
  (1..100).each do |i|
    Order.create(name: "Cutomer #{i}",
                 address: "#{i} Main Street",
                 email: "c#{i}@example.com",
                 pay_type: "現金")
  end
end
