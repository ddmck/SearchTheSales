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

sub_categories = [["trainers", "shoes"], ["pumps", "shoes"], ["shorts", "shorts"], ["suits", "suits"], ["courts", "shoes"], ["blazers", "jackets"], ["underwear", "underwear"], ["pants", "underwear"], ["shirts", "shirts"], ["sweats", "sweats"], ["shoes", "shoes"], ["tees", "tees"], ["accessories", "accessories"], ["jackets", "jackets"], ["sandals", "shoes"], ["heels", "shoes"], ["dresses", "dresses"], ["loafers", "shoes"], ["bags", "bags"], ["skirts", "skirts"], ["espadrilles", "shoes"], ["knitwear", "knitwear"], ["bottoms", "trousers"], ["tops", "tops"], ["jeans", "jeans"], ["briefs", "underwear"], ["jeggings", "trousers"], ["wedges", "shoes"], ["t-shirts", "tees"], ["chinos", "trousers"], ["lingerie", "lingerie"], ["trousers", "trousers"], ["leggings", "trousers"], ["joggers", "trousers"], ["slippers", "shoes"], ["blouses", "blouses"], ["cufflinks", "accessories"], ["socks", "underwear"], ["handbags", "bags"], ["rucksacks", "bags"], ["playsuits", "playsuits"], ["flops", "shoes"], ["vests", "tees"], ["sneakers", "shoes"], ["gloves", "accessories"], ["gilets", "jackets"], ["belts", "accessories"], ["wallets", "accessories"], ["sweatshirts", "sweats"], ["bracelets", "accessories"], ["necklaces", "accessories"], ["parkas", "jackets"], ["cases", "accessories"], ["jumpsuits", "playsuits"], ["tunics", "tops"], ["scarves", "accessories"], ["overshirts", "jackets"], ["watches", "accessories"], ["hobos", "bags"], ["backpacks", "bags"], ["tracks", "trousers"], ["satchels", "bags"], ["totes", "bags"], ["clutches", "bags"], ["snoods", "accessories"], ["brogues", "shoes"], ["tights", "lingerie"], ["knits", "knitwear"], ["polos", "polos"], ["platforms", "shoes"], ["plimsolls", "shoes"], ["hoodies", "hoodies"], ["sunglasses", "accessories"], ["purses", "bags"], ["boxers", "underwear"], ["stocking", "lingerie"], ["stockings", "lingerie"], ["boardshorts", "swimwear"], ["bras", "lingerie"], ["swimwear", "swimwear"], ["trunks", "swimwear"], ["knickers", "lingerie"], ["cardigans", "knitwear"], ["jumpers", "knitwear"], ["sweaters", "sweats"], ["ties", "accessories"], ["slipons", "shoes"], ["caps", "accessories"], ["glasses", "accessories"], ["rings", "accessories"], ["pyjamas", "accessories"], ["chains", "accessories"], ["bombers", "jackets"], ["hats", "accessories"], ["pouches", "bags"], ["snapbacks", "accessories"], ["bikinis", "swimwear"], ["bangles", "accessories"], ["trilbies", "accessories"], ["snopants", "trousers"], ["lanyards", "accessories"], ["keyrings", "accessories"], ["corsets", "lingerie"], ["gowns", "dresses"], ["outerwear", "jackets"], ["coats", "jackets"], ["overcoats", "jackets"], ["peacoats", "jackets"], ["capes", "jackets"], ["macs", "jackets"], ["duffels", "jackets"], ["trenchcoats", "jackets"], ["boots", "shoes"], ["bodycons", "dresses"]]

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

stores = ["spartoo", "yooxMensOuterwear", "yooxWomensFootwear", "harveyNicksMens", "yooxWomensOuterwear", "farfetch", "infinities", "stylebop", "yooxMensFootwear", "theHut", "nike", "farfetchshoes", "farfetchbags", "yooxWomensDresses", "sportsDirectMens", "harveyNicks", "diffusion", "tucci", "danielfootwear", "atterleyroad", "footasylum", "allsoleWomensFootwear", "sportsDirectWomens", "tessuti", "Trilogy", "Repertoire", "AllSole", "OKI-NI", "Menlook", "Cloggs", "Joules", "L.K. Bennett", "Aphrodite", "Psyche", "The Dressing Room", "LN-CC", "Kurt Geiger", "Shoeaholics", "Urban Industry", "Mybag", "Ted Baker", "All Saints", "Armani", "Saks Fifth Avenue", "Hobbs", "Toast", "Lulu Guinness", "Muubaa", "Uniqlo", "Whistles", "Harrods", "Luisaviaroma", "Anya Hindmarch", "Belstaff", "Mr Porter", "Net-A-Porter", "Selfridges", "7 For All Mankind", "Acne Studios", "Alexander McQueen", "Avenue 32", "Browns", "Guess", "Hunter", "Joseph", "John Smedley", "River Island", "Stanwells", "End", "CrnFrd", "Jules B", "Mango", "Sunspel", "Forever 21", "Liberty London", "Rubbersole", "coggles", "ASOS", "schuh", "Topshop", "zalando", "office", "House of Fraser", "Flannels", "Sarenza", "Woodhouse", "Reiss", "Brown Bag Clothing", "Jigsaw", "French Connection", "John Lewis", "MATCHESFASHION", "Dune", "Urban Outfitters", "TheOutnet", "TrainerStation", "Size?", "Van Mildert", "Topman"]

stores.each do |s|
  Store.create(name: s)
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