# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
# u = User.new(
#     username: 'admin',
#     email: 'admin@example.com',
#     password: '1234',
#     password_confirmation: '1234',
#     admin: true
# )
# u.skip_confirmation!
# u.save!

# # Test user accounts
# (1..50).each do |i|
#   u = User.new(
#       username: "user#{i}",
#       email: "user#{i}@example.com",
#       password: '1234',
#       password_confirmation: '1234'
#   )
#   u.skip_confirmation!
#   u.save!

#   puts "#{i} test users created..." if (i % 5 == 0)
# end

cats = ["accessories","bags","blouses",
        "shoes","dresses","hoodies",
        "jackets","jeans","knitwear",
        "polos","shirts","shorts",
        "skirts","suits","sweats",
        "swimwear","tees","tops",
        "trousers","underwear","lingerie",
        "playsuits"]

cats.each do |c|
  p = Category.new(name: c)
  p.save!
end


sub_shoes = ["trainers","heels","loafers",
             "espadrilles","wedges","flops",
             "sneakers","brogues","platforms",
             "plimsolls","slipons","boots",
             "courts","sandals","slippers"]

sub_shoes.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("shoes"))
  p.save!
end


sub_accessories = ["cufflinks","gloves","belts",
                   "necklaces","bracelets","cases",
                   "watches","snoods","sunglasses",
                   "ties","rings","caps","pyjamas",
                   "hats","bangles","lanyards",
                   "snapbacks","trilbies","keyrings",
                   "wallets"]

sub_accessories.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("accessories"))
  p.save!
end


sub_dresses = ["gowns","bodycon"]

sub_dresses.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("dresses"))
  p.save!
end


sub_jackets = ["blazers","gilets","parkas",
               "overshirts","bombers","outerwear",
               "peacoats","duffles","overcoats",
               "macs","coats","capes","trenchcoats"]

sub_jackets.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("jackets"))
  p.save!
end


sub_underwear = ["pants","briefs","socks","boxers"]

sub_underwear.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("underwear"))
  p.save!
end


sub_sweats = ["sweatshirts","sweaters"]

sub_sweats.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("sweats"))
  p.save!
end


sub_knitwear = ["knits","cardigans","jumpers"]

sub_knitwear.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("knitwear"))
  p.save!
end


sub_tops = ["tunics"]

sub_tops.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("tops"))
  p.save!
end


sub_tees = ["t-shirts","vests"]

sub_tees.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("tees"))
  p.save!
end


sub_bags = ["rucksacks","handbags","hobos",
            "backpacks","satchels","clutches",
            "totes","purses","pouches"]

sub_bags.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("bags"))
  p.save!
end


sub_trousers = ["bottoms","jeggings","joggers",
                "leggings","chinos","tracks","snopants"]

sub_trousers.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("trousers"))
  p.save!
end


sub_playsuits = ["jumpsuits"]

sub_playsuits.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("playsuits"))
  p.save!
end


sub_lingerie = ["tights","stockings","bra",
                "knickers","corsets"]

sub_lingerie.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("lingerie"))
  p.save!
end


sub_swimwear = ["broadshorts","trunks","bikinis"]

sub_swimwear.each do |c|
  p = SubCategory.new(name: c, category: Category.find_by_name("swimwear"))
  p.save!
end
