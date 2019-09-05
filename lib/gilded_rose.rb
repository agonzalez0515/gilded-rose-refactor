class GildedRose

  def initialize(items)
    @items = items
  end

  def regular_item(item)
    item.update
  end

  def backstage_passes(item)
    item.update
  end

  def conjured(item)
    item.update
  end

  def aged_brie(item)
    item.update
  end

  def modify_item_quality(item)
    case item.name
      when "Backstage passes to a TAFKAL80ETC concert"
        backstage_passes(item)
      when "Aged Brie"
        aged_brie(item)
      when "Conjured"
        conjured(item)
      else
        regular_item(item)
    end 
  end
  
  def daily_item_update()
    @items.each do |item|
      return if item.name == "Sulfuras, Hand of Ragnaros"
      modify_item_quality(item)
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
    return @quality  = 0 if @sell_in <= 0

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