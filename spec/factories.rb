FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "foo#{n}" }
    password 'foobar'
    password_confirmation 'foobar'
    email { "#{username}@example.com" }
  end

  factory :store do
    sequence(:name) { |n| "store#{n}" }
    url 'http://megastore.com'
    image_url 'http://megastore.com/image.png'
  end

  factory :brand do
    sequence(:name) { |n| "brand#{n}" }
    feature_text "Live in Levi's"
    image_url 'http://levi.com/image.png'
  end

  factory :category do
    sequence(:name) { |n| "category#{n}" }

    trait :accessories do
      name "accessories"
    end

    trait :bags do
      name "bags"
    end

    trait :blouses do
      name "blouses"
    end

    trait :dresses do
      name "dresses"
    end

    trait :hoodies do
      name "hoodies"
    end

    trait :jackets do
      name "jackets"
    end

    trait :jeans do
      name "jeans"
    end

    trait :knitwear do
      name "knitwear"
    end

    trait :polos do
      name "polos"
    end

    trait :shirts do
      name "shirts"
    end

    trait :shoes do
      name "shoes"
    end

    trait :shorts do
      name "shorts"
    end

    trait :skirts do
      name "skirts"
    end

    trait :suits do
      name "suits"
    end

    trait :sweats do
      name "sweats"
    end

    trait :swimwear do
      name "swimwear"
    end

    trait :tees do
      name "tees"
    end

    trait :tops do
      name "tops"
    end

    trait :trousers do
      name "trousers"
    end

    trait :underwear do
      name "underwear"
    end

    trait :lingerie do
      name "lingerie"
      female_only true
    end

    trait :playsuits do
      name "playsuits"
      female_only true
    end
  end

  factory :product do
    sequence(:name) { |n| "product#{n}" }

    trait :short_boots do
      name "Classic Short Men's Mid Boots In Chestnut"
    end

    trait :shoes do
      name "shoes"
    end
  end

  # factory :product do
  #   sequence(:name) { |n| "product#{n}" }
  #   description 'You will look awesome!'
  #   sequence(:url, 9000) { |n| "http://www.url#{n}.com" }
  #   image_url 'http://jeans.com/image.png'
  #   gender
  #   store
  #   brand

  #   trait :with_sub_categories do
  #     after(:create) do |product|
  #       FactoryGirl.create_list(:sub_category, 1, product: product)
  #     end
  #   end
  # end

  factory :color do
    sequence(:name) { |n| "color#{n}" }
  end

  factory :sub_category do
    sequence(:name) { |n| "subcat#{n}" }
    category
      
      trait :boots do
        name "boots"
      end
  end

  factory :trend do
    sequence(:name) { |n| "trend#{n}" }
  end

  factory :gender do
    sequence(:name) { |_n| 'gender' }
  end

  factory :data_feed do
    feed_url 'http://datafeedurl.com/file.csv'
    store
  end

  factory :data_feed_xml do
    file 'file.xml'
    store
  end

  factory :feature do
    sequence(:title) { |n| "title#{n}"}
    copy 'The copy goes here'
    brand
    category
    sub_category
    search_string 'paul smith jeans'
    gender
    store
    image_url 'http://http://jeans.com/image.png'
  end

  factory :feature_link do
    name "shop mens"
    link_url "http://localhost:3000/?gender=male"
    feature
  end

  factory :style do
    name "tuxedo"
    category
  end

end
