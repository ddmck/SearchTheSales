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
cats = [["shoes", nil], ["accessories", nil], ["jackets", nil], ["shorts", nil], ["suits", nil], ["underwear", nil], ["sweats", nil], ["knitwear", nil], ["shirts", nil], ["tops", nil], ["tees", nil], ["bags", nil], ["jeans", nil], ["trousers", nil], ["polos", nil], ["hoodies", nil], ["swimwear", nil], ["dresses", true], ["blouses", true], ["skirts", true], ["playsuits", true], ["lingerie", true]]

cats.each do |c, f|
  p = Category.new(name: c, female_only: f)
  p.save!
end

genders = ["male", "female", "unisex"]

genders.each do |g|
  p = Gender.new(name: g)
  p.save!
end

styles = [["backpacks", "bags"], ["totes", "bags"], ["clutches", "bags"],
["handbags", "bags"], ["hobos", "bags"], ["pouches", "bags"], ["purses",
"bags"], ["rucksacks", "bags"], ["satchels", "bags"], ["shoulder bags", "bags"],
["bootcut", "jeans"], ["dungarees", "jeans"], ["skinny", "jeans"], ["loose",
"jeans"], ["flare", "jeans"], ["slim", "jeans"], ["straight", "jeans"],
["distressed", "jeans"], ["acid wash", "jeans"], ["midwash", "jeans"],
["lightwash", "jeans"], ["darkwash", "jeans"], ["ripped", "jeans"],
["cardigans", "knitwear"], ["pullovers", "knitwear"], ["crewneck", "knitwear"],
["pattern", "knitwear"], ["chunky", "knitwear"], ["plain", "knitwear"],
["cableknit", "knitwear"], ["v neck", "knitwear"], ["funnel neck", "knitwear"],
["turtle neck", "knitwear"], ["roll neck", "knitwear"], ["shawl", "knitwear"],
["checked", "polos"], ["jersey", "polos"], ["print", "polos"], ["striped",
"polos"], ["pocket", "polos"], ["long sleeve", "polos"], ["check", "shirts"],
["oxford", "shirts"], ["short sleeve", "shirts"], ["dress", "shirts"],
["printed", "shirts"], ["stripe", "shirts"], ["boat", "shoes"], ["chukka",
"shoes"], ["desert", "shoes"], ["flip flop", "shoes"], ["brogues", "shoes"],
["boots", "shoes"], ["chelsea boots", "shoes"], ["loafers", "shoes"],
["plimsolls", "shoes"], ["sandals", "shoes"], ["trainers", "shoes"],
["slippers", "shoes"], ["chino", "shorts"], ["denim", "shorts"], ["sweat",
"shorts"], ["cargo", "shorts"], ["tailored", "shorts"], ["pinstripe", "suits"],
["tuxedo", "suits"], ["waist coat", "suits"], ["boxers", "underwear"],
["trunks", "underwear"], ["oversized", "tees"], ["longsleeve", "tees"], ["dye",
"tees"], ["round", "tees"], ["longlined", "tees"], ["relaxed", "tees"], ["going
out", "tops"], ["crop", "tops"], ["cami", "tops"], ["wrap", "tops"], ["kimonos",
"tops"], ["floral", "blouses"], ["formal", "blouses"], ["bodycon", "dresses"],
["festival", "dresses"], ["maxi", "dresses"], ["mini", "dresses"], ["midi",
"dresses"], ["bridesmaid", "dresses"], ["day", "dresses"], ["wedding",
"dresses"], ["party", "dresses"], ["prom", "dresses"], ["skater", "dresses"],
["cocktail", "dresses"], ["kimono", "dresses"], ["pencil", "dresses"], ["strip",
"dresses"], ["embroidered", "dresses"], ["crotchet", "dresses"], ["bras",
"lingerie"], ["briefs", "lingerie"], ["thongs", "lingerie"], ["nightwear",
"lingerie"], ["sexy", "lingerie"], ["camisoles", "lingerie"], ["corsets",
"lingerie"], ["maternity", "lingerie"], ["suspenders", "lingerie"], ["blazers",
"jackets"], ["casual", "jackets"], ["bomber", "jackets"], ["trench", "jackets"],
["capes", "jackets"], ["coats", "jackets"], ["duffels", "jackets"], ["gilets",
"jackets"], ["macs", "jackets"], ["overcoats", "jackets"], ["parkas",
"jackets"], ["pea coats", "jackets"], ["formal", "jackets"]]

styles.each do |s, c|
  p = Category.find_by_name(c).styles.build(name: s)
  p.save
end

sub_categories = [["backpacks", "bags"], ["totes", "bags"], ["clutches", "bags"], ["handbags", "bags"], ["hobos", "bags"], ["pouches", "bags"], ["purses", "bags"], ["rucksacks", "bags"], ["satchels", "bags"], ["shoulder bags", "bags"], ["dungarees", "jeans"], ["cardigans", "knitwear"], ["pullover", "knitwear"], ["crewneck", "knitwear"], ["v neck", "knitwear"], ["turtle neck", "knitwear"], ["shawl", "knitwear"], ["jersey", "polos"], ["chukka", "shoes"], ["flip flop", "shoes"], ["brogues", "shoes"], ["boots", "shoes"], ["chelsea boots", "shoes"], ["loafers", "shoes"], ["plimsolls", "shoes"], ["sandals", "shoes"], ["trainers", "shoes"], ["slippers", "shoes"], ["chino", "shorts"], ["sweat", "shorts"], ["tuxedo", "suits"], ["waist coat", "suits"], ["boxers", "underwear"], ["trunks", "underwear"], ["cami", "tops"], ["kimonos", "tops"], ["bodycon", "dresses"], ["kimono", "tops"], ["bras", "lingerie"], ["thongs", "lingerie"], ["camisoles", "lingerie"], ["corsets", "lingerie"], ["suspenders", "lingerie"], ["blazers", "jackets"], ["coats", "jackets"], ["gilets", "jackets"], ["macs", "jackets"], ["overcoats", "jackets"], ["parkas", "jackets"], ["pea coats", "jackets"], ["pumps", "shoes"], ["shorts", "shorts"], ["suits", "suits"], ["courts", "shoes"], ["underwear", "underwear"], ["pants", "underwear"], ["shirt", "shirts"], ["sweats", "sweats"], ["shoe", "shoes"], ["tee", "tees"], ["accessory", "accessories"], ["jacket", "jackets"], ["heels", "shoes"], ["dresses", "dresses"], ["bag", "bags"], ["skirts", "skirts"], ["espadrilles", "shoes"], ["knitwear", "knitwear"], ["bottoms", "trousers"], ["top", "tops"], ["jeans", "jeans"], ["briefs", "underwear"], ["jeggings", "trousers"], ["wedges", "shoes"], ["t-shirts", "tees"], ["t-shirt", "tees"], ["chinos", "trousers"], ["lingerie", "lingerie"], ["trousers", "trousers"], ["leggings", "trousers"], ["joggers", "trousers"], ["blouses", "blouses"], ["cufflinks", "accessories"], ["socks", "underwear"], ["playsuits", "playsuits"], ["flops", "shoes"], ["vests", "tees"], ["sneakers", "shoes"], ["gloves", "accessories"], ["belts", "accessories"], ["wallets", "accessories"], ["sweatshirts", "sweats"], ["bracelets", "accessories"], ["necklaces", "accessories"], ["cases", "accessories"], ["case", "accessories"], ["jumpsuits", "playsuits"], ["tunics", "tops"], ["scarves", "accessories"], ["scarf", "accessories"], ["overshirts", "jackets"], ["watches", "accessories"], ["tracks", "trousers"], ["snoods", "accessories"], ["tights", "lingerie"], ["knits", "knitwear"], ["polos", "polos"], ["platforms", "shoes"], ["hoodies", "hoodies"], ["sunglasses", "accessories"], ["stocking", "lingerie"], ["boardshorts", "swimwear"], ["swimwear", "swimwear"], ["knickers", "lingerie"], ["jumpers", "knitwear"], ["sweaters", "sweats"], ["ties", "accessories"], ["slipons", "shoes"], ["caps", "accessories"], ["glasses", "accessories"], ["rings", "accessories"], ["pyjamas", "accessories"], ["chains", "accessories"], ["bombers", "jackets"], ["hats", "accessories"], ["snapbacks", "accessories"], ["bikinis", "swimwear"], ["bangles", "accessories"], ["trilbies", "accessories"], ["snopants", "trousers"], ["lanyards", "accessories"], ["keyrings", "accessories"], ["gowns", "dresses"], ["outerwear", "jackets"], ["peacoats", "jackets"], ["trenchcoats", "jackets"], ["bodycons", "dresses"], ["sliders", "shoes"], ["slides", "shoes"], ["spray", "accessories"], ["repellent", "accessories"], ["tan", "accessories"], ["hat", "accessories"], ["footwear", "shoes"], ["culottes", "skirts"], ["sweatshirt", "sweats"], ["crop", "tops"],
["jumper", "knitwear"], ["hoodie", "hoodies"], ["tank", "tops"], ["parka", "jackets"], ["blazer", "suits"], ["skirt", "skirts"], ["gilet", "jackets"]]                  

sub_categories.each do |s, c|
  p = SubCategory.new(name: s, category: Category.find_by_name(c))
  p.save!
end

colors = [["rose", nil], ["navy", nil], ["pearl", nil], ["tea", nil], ["fern", nil], ["raspberry", nil], ["sand", nil], ["chocolate", nil], ["champagne", nil], ["cream", nil], ["buff", nil], ["taupe", nil], ["indigo", nil], ["tan", nil], ["violet", nil], ["cobalt", nil], ["wine", nil], ["burgundy", nil], ["sapphire", nil], ["ivy", nil], ["khaki", nil], ["maroon", nil], ["orchid", nil], ["chestnut", nil], ["bronze", nil], ["peach", nil], ["coral", nil], ["gold", nil], ["fire", nil], ["fuchsia", nil], ["cardinal", nil], ["mauve", nil], ["marine", nil], ["klein blue", nil], ["tangerine", nil], ["vanilla", nil], ["ivory", nil], ["papaya", nil], ["lion", nil], ["ecru", nil], ["teal", nil], ["copper", nil], ["turquoise", nil], ["pine", nil], ["sun", nil], ["apple", nil], ["ochre", nil], ["iris", nil], ["dark red", nil], ["lime", nil], ["lavender", nil], ["amber", nil], ["snow", nil], ["sky blue", nil], ["scarlet", nil], ["ruby", nil], ["azure", nil], ["plum", nil], ["blond", nil], ["magenta", nil], ["celeste", nil], ["maya", nil], ["egyptian blue", nil], ["amethyst", nil], ["mahogany", nil], ["emerald", nil], ["byzantium", nil], ["forest", nil], ["fawn", nil], ["sienna", nil], ["electric blue", nil], ["olive", nil], ["jade", nil], ["sunset", nil], ["prussian blue", nil], ["crimson", nil], ["mint", nil], ["brick", nil], ["rust", nil], ["cerise", nil], ["mustard", nil], ["sepia", nil], ["cordovan", nil], ["bole", nil], ["periwinkle", nil], ["tawny", nil], ["coffee", nil], ["folly", nil], ["apricot", nil], ["magnolia", nil], ["royal blue", nil], ["liver", nil], ["carnation", nil], ["pistachio", nil], ["tiffany", nil], ["ultramarine", nil], ["tuscan", nil], ["wenge", nil], ["salmon", nil], ["harlequin", nil], ["grass", nil], ["ghost", nil], ["flame", nil], ["pumpkin", nil], ["hunter green", nil], ["wheat", nil], ["asparagus", nil], ["wisteria", nil], ["redwood", nil], ["rosewood", nil], ["auburn", nil], ["cornflower blue", nil], ["umber", nil], ["eggplant", nil], ["shamrock", nil], ["baby blue", nil], ["carrot", nil], ["burnt umber", nil], ["lust", nil], ["bondi", nil], ["cyan", nil], ["bittersweet", nil], ["cerulean", nil], ["grey", true], ["brown", true], ["beige", true], ["yellow", true], ["silver", true], ["terracotta", nil], ["russet", nil], ["air force blue", nil], ["fire brick", nil], ["bistre", nil], ["jonquil", nil], ["persian blue", nil], ["fandango", nil], ["rusty", nil], ["beaver", nil], ["floral white", nil], ["burnt orange", nil], ["carmine", nil], ["fallow", nil], ["dark olive green", nil], ["bright green", nil], ["chartreuse", nil], ["dartmouth", nil], ["duke blue", nil], ["puce", nil], ["eggshell", nil], ["jungle green", nil], ["red", true], ["orange", true], ["green", true], ["blue", true], ["pink", true], ["purple", true], ["black", true], ["white", true]]

colors.each do |c, f|
  Color.create(name: c, featured: f)
end

materials = [["leather", true], ["velvet", true], ["tweed", true], ["denim", true], ["cashmere", true], ["cotton", true], ["wool", true], ["lambswool", true], ["satin", true], ["twill", true], ["linen", true], ["nylon", true], ["fur", true], ["silk", true], ["suede", true], ["merino wool", nil], ["faux fur", nil]]

materials.each do |m, f|
  Material.create(name: m, featured: f)
end

stores = [["spartoo", 0.0, 0.0, 0.0], ["yooxMensOuterwear", 0.0, 0.0, 0.0], ["yooxWomensFootwear", 0.0, 0.0, 0.0], ["harveyNicksMens", 0.0, 0.0, 0.0], ["yooxWomensOuterwear", 0.0, 0.0, 0.0], ["farfetch", 0.0, 0.0, 0.0], ["infinities", 0.0, 0.0, 0.0], ["stylebop", 0.0, 0.0, 0.0], ["yooxMensFootwear", 0.0, 0.0, 0.0], ["theHut", 0.0, 0.0, 0.0], ["nike", 0.0, 0.0, 0.0], ["farfetchshoes", 0.0, 0.0, 0.0], ["farfetchbags", 0.0, 0.0, 0.0], ["yooxWomensDresses", 0.0, 0.0, 0.0], ["sportsDirectMens", 0.0, 0.0, 0.0], ["harveyNicks", 0.0, 0.0, 0.0], ["diffusion", 0.0, 0.0, 0.0], ["tucci", 0.0, 0.0, 0.0], ["danielfootwear", 0.0, 0.0, 0.0], ["atterleyroad", 0.0, 0.0, 0.0], ["footasylum", 0.0, 0.0, 0.0], ["allsoleWomensFootwear", 0.0, 0.0, 0.0], ["sportsDirectWomens", 0.0, 0.0, 0.0], ["tessuti", 0.0, 0.0, 0.0], ["Trilogy", 0.0, 0.0, 0.0], ["Repertoire", 0.0, 0.0, 0.0], ["AllSole", 0.0, 0.0, 0.0], ["OKI-NI", 0.0, 0.0, 0.0], ["Menlook", 0.0, 0.0, 0.0], ["Cloggs", 0.0, 0.0, 0.0], ["Joules", 0.0, 0.0, 0.0], ["L.K. Bennett", 0.0, 0.0, 0.0], ["Aphrodite", 0.0, 0.0, 0.0], ["Psyche", 0.0, 0.0, 0.0], ["The Dressing Room", 0.0, 0.0, 0.0], ["LN-CC", 0.0, 0.0, 0.0], ["Kurt Geiger", 0.0, 0.0, 0.0], ["Shoeaholics", 0.0, 0.0, 0.0], ["Urban Industry", 0.0, 0.0, 0.0], ["Mybag", 0.0, 0.0, 0.0], ["Ted Baker", 0.0, 0.0, 0.0], ["All Saints", 0.0, 0.0, 0.0], ["Armani", 0.0, 0.0, 0.0], ["Saks Fifth Avenue", 0.0, 0.0, 0.0], ["Hobbs", 0.0, 0.0, 0.0], ["Toast", 0.0, 0.0, 0.0], ["Lulu Guinness", 0.0, 0.0, 0.0], ["Muubaa", 0.0, 0.0, 0.0], ["Uniqlo", 0.0, 0.0, 0.0], ["Whistles", 0.0, 0.0, 0.0], ["Harrods", 0.0, 0.0, 0.0], ["Luisaviaroma", 0.0, 0.0, 0.0], ["Anya Hindmarch", 0.0, 0.0, 0.0], ["Belstaff", 0.0, 0.0, 0.0], ["Mr Porter", 0.0, 0.0, 0.0], ["Net-A-Porter", 0.0, 0.0, 0.0], ["Selfridges", 0.0, 0.0, 0.0], ["7 For All Mankind", 0.0, 0.0, 0.0], ["Acne Studios", 0.0, 0.0, 0.0], ["Alexander McQueen", 0.0, 0.0, 0.0], ["Avenue 32", 0.0, 0.0, 0.0], ["Browns", 0.0, 0.0, 0.0], ["Guess", 0.0, 0.0, 0.0], ["Hunter", 0.0, 0.0, 0.0], ["Joseph", 0.0, 0.0, 0.0], ["John Smedley", 0.0, 0.0, 0.0], ["River Island", 0.0, 0.0, 0.0], ["Stanwells", 0.0, 0.0, 0.0], ["End", 0.0, 0.0, 0.0], ["CrnFrd", 0.0, 0.0, 0.0], ["Jules B", 0.0, 0.0, 0.0], ["Mango", 0.0, 0.0, 0.0], ["Sunspel", 0.0, 0.0, 0.0], ["Forever 21", 0.0, 0.0, 0.0], ["Liberty London", 0.0, 0.0, 0.0], ["Rubbersole", 0.0, 0.0, 0.0], ["coggles", 2.95, 3.95, 50.0], ["ASOS", 0.0, 5.95, 0.0], ["schuh", 0.0, 4.99, 0.0], ["Topshop", 4.0, 6.0, 50.0], ["zalando", 0.0, 4.95, 0.0], ["office", 0.0, 0.0, 0.0], ["House of Fraser", 3.0, 6.0, 50.0], ["Flannels", 6.0, 0.0, 0.0], ["Sarenza", 0.0, 0.0, 0.0], ["Woodhouse", 4.95, 4.95, 0.0], ["Reiss", 3.95, 7.0, 0.0], ["Brown Bag Clothing", 4.95, 0.0, 0.0], ["Jigsaw", 4.5, 8.0, 100.0], ["French Connection", 3.95, 7.0, 0.0], ["John Lewis", 3.0, 6.95, 50.0], ["MATCHESFASHION", 5.0, 8.0, 0.0], ["Dune", 3.5, 6.5, 0.0], ["Urban Outfitters", 3.99, 5.99, 60.0], ["TheOutnet", 5.0, 8.0, 0.0], ["TrainerStation", 4.95, 4.95, 0.0], ["Size?", 2.99, 4.99, 100.0], ["Van Mildert", 6.0, 0.0, 0.0], ["Topman", 4.0, 6.0, 50.0]]

stores.each do |s, p, e, t|
  Store.create(name: s, standard_price: p, express_price: e, free_delivery_threshold: t)
end

DataFeed.create("feed_url"=>"http://datafeed.api.productserve.com/datafeed/download/apikey/5ceb2936022c9df973e19221f267ec28/cid/129,595,539,147,149,135,163,168,159,169,161,167,170,171,174,183,178,179,175,172,189,194,141,205,198,206,203,208,199,204,201/fid/5678/columns/aw_product_id,merchant_product_id,merchant_category,aw_deep_link,merchant_image_url,aw_image_url,search_price,description,product_name,rrp_price,display_price,brand_name,size,specifications,merchant_deep_link,colour/format/csv/delimiter/,/compression/zip/adultcontent/0/\r\n", 
  "store"=> Store.find_by_name("ASOS"), 
  "name_column"=>"product_name", 
  "description_column"=>"description", 
  "rrp_column"=>"rrp_price", 
  "sale_price_column"=>"display_price", 
  "link_column"=>"aw_deep_link", 
  "image_url_column"=>"merchant_image_url", 
  "brand_column"=>"brand_name", 
  "size_column"=>"size", 
  "color_column"=>"colour",
  "gender_column"=>"specifications", 
  "category_column"=>"", 
  "large_image_url_column"=>"merchant_image_url", 
  "active"=>nil, 
  "image_assets"=>"AsosImageImporter", 
  "deeplink_column"=>"merchant_deep_link")

DataFeed.create("feed_url"=>"http://datafeed.api.productserve.com/datafeed/download/apikey/5ceb2936022c9df973e19221f267ec28/cid/97,98,142,144,146,129,595,539,147,149,613,626,135,163,168,159,169,161,167,170,137,171,548,174,183,178,179,175,172,623,139,614,189,194,141,205,198,206,203,208,199,204,201/fid/2077/columns/aw_product_id,merchant_product_id,merchant_category,aw_deep_link,merchant_image_url,search_price,description,product_name,rrp_price,display_price,specifications,brand_name,size,colour/format/csv/delimiter/,/compression/zip/adultcontent/0/", 
  "store" => Store.find_by_name("Urban Outfitters"), 
  "name_column"=>"product_name", 
  "description_column"=>"description", 
  "rrp_column"=>"rrp_price", 
  "sale_price_column"=>"display_price", 
  "link_column"=>"aw_deep_link", 
  "image_url_column"=>"merchant_image_url", 
  "brand_column"=>"brand_name", 
  "size_column"=>"size", 
  "color_column"=>"colour", 
  "gender_column"=>"merchant_category", 
  "category_column"=>"merchant_category", 
  "large_image_url_column"=>"merchant_image_url", 
  "active"=>nil, 
  "image_assets"=>"UrbanOutfittersImageImporter", 
  "deeplink_column"=>nil)

