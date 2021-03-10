module ShipmentHelper
  def package_item_description_code(desc)
    desc = desc.downcase
    if ["сумки", "сумка", "bag"].any? { |w| desc.include?(w) }
      "4202210000"
    elsif ["перчатки", "gloves"].any? { |w| desc.include?(w) }
      "6116930000"
    elsif ["clothes", "clothing", "parka", "costume", "jeans", "shirt", "jacket", "tee", "t-shirt", "pants", "skirt", "hoodie", "одежда", "одежды", "парка", "джинсы", "штаны", "рубашк", "куртка", "футболка", "толстовка", "юбка"].any? { |w| desc.include?(w) }
      "6114"
    elsif ["shoes", "obuv", "boots", "sneakers", "loafers", "botinki", "sapogi", "обувь", "ботинки", "кроссовки", "туфли", "сапоги"].any? { |w| desc.include?(w) }
      "6404110000"
    elsif ["book", "книга", "книги"].any? { |w| desc.include?(w) }
      "4901"
    elsif ["toy", "toys", "игрушка", "игрушки"].any? { |w| desc.include?(w) }
      "950300"
    elsif ["лыжи", "snowboard"].any? { |w| desc.include?(w) }
      "9506"
    elsif ["hat", "beanie", "шляпа", "шапка"].any? { |w| desc.include?(w) }
      "650500"
    elsif ["watch", "chasy", "часы"].any? { |w| desc.include?(w) }
      "9101"
    elsif ["cosmetics", "clinique", "mask", "gel", "beauty", "cream", "face", "hidrogel", "hydrogel", "маска", "гель", "патчи для глаз", "косметика", "тушь", "помада", "тени"].any? { |w| desc.include?(w) }
      "3304"
    elsif ["earphones", "earbuds", "наушники"].any? { |w| desc.include?(w) }
      "8518309500"
    elsif ["shampoo", "шампунь"].any? { |w| desc.include?(w) }
      "3305"
    elsif ["зубная щетка"].any? { |w| desc.include?(w) }
      "3306"
    elsif ["coffee", "cofee", "кофе"].any? { |w| desc.include?(w) }
      "0901"
    elsif ["guitar", "piano", "гитара"].any? { |w| desc.include?(w) }
      "9202"
    elsif ["phone", "телефон"].any? { |w| desc.include?(w) }
      "8517120000"
    elsif ["laptop", "notebook", "macbook", "lenovo", "ноутбук"].any? { |w| desc.include?(w) }
      "8471300000"
    elsif ["auto-parts", "autoparts", "auto parts", "parts", "car", "авто", "запчасти"].any? { |w| desc.include?(w) }
      "8708999709"
    elsif ["ковер", "ковёр"].any? { |w| desc.include?(w) }
      "5702100000"
    elsif ["glasses", "sunglasses", "очки"].any? { |w| desc.include?(w) }
      "9004109100"
    elsif ["socks", "носки"].any? { |w| desc.include?(w) }
      "6115950000"
    elsif ["bra", "panties", "lingerie", "бюстгальтер"].any? { |w| desc.include?(w) }
      "6108910000"
    elsif ["chair", "table", "стол", "стул", "полка", "тумбочка"].any? { |w| desc.include?(w) }
      "9403601009"
    elsif ["vitamin", "vitamins", "bady", "бады", "витамины", "now foods"].any? { |w| desc.include?(w) }
      "300450000"
    elsif ["кабель", "ram", "hdd", "ssd", "intel", "motherboard", "ethernet", "память", "mikrotik", "процессор"].any? { |w| desc.include?(w) }
      "8473302008"
    elsif ["screen", "защитное стекло", "case"].any? { |w| desc.include?(w) }
      "3926909709"
    elsif ["pencil", "pen", "penal", "paper", "stapler", "карандаш"].any? { |w| desc.include?(w) }
      "8305900000"
    elsif ["accessories", "accesories", "acsesuar", "stickers", "аксессуары"].any? { |w| desc.include?(w) }
      "96"
    end
  end
end
