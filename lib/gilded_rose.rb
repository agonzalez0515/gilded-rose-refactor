
class GildedRose
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert"
  CONJURED = "Conjured"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  SPECIAL_ITEMS = {
    AGED_BRIE => :AgedBrie,
    BACKSTAGE_PASSES => :BackstagePasses,
    CONJURED => :Conjured,
    SULFURAS => :Sulfuras
  }

  def initialize(items)
    @items = items
  end

  def convert_to_specific_item(item)
    special_item = SPECIAL_ITEMS[item.name]

      if special_item
        item_for_sale = Item.const_get(special_item)
        item_for_sale.new(item.name, item.sell_in, item.quality)
      else
        RegularItem.new(item.name, item.sell_in, item.quality)
      end
  end
  
  def update_item_daily
    @items.each do |item|
      specific_item = convert_to_specific_item(item)
      specific_item.update

      item.quality = specific_item.quality
      item.sell_in = specific_item.sell_in
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def update
  end
end

class RegularItem < Item
  def update
    @sell_in -= 1
    return if @quality == 0 
    @quality -= 1
    @quality -= 1 if @sell_in <= 0
  end
end

class AgedBrie < Item
  def update 
    @sell_in -= 1
    return if @quality >= 50
    @quality += 1
    @quality += 1 if @sell_in <= 0
  end
end

class BackstagePasses < Item
  def update 
    @sell_in -= 1
    return if @quality >= 50
    return @quality = 0 if @sell_in <= 0

    @quality += 1
    return if @quality >= 50
    
    @quality += 1 if @sell_in < 11
    return if @quality >= 50
    
    @quality += 1 if @sell_in < 6
  end
end

class Conjured < Item
  def update 
    @sell_in -= 1
    return if @quality <= 0
    @quality -= 2
  end
end

class Sulfuras < Item
  def update
    return
  end
end