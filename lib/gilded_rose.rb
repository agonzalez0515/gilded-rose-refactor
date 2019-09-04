class GildedRose

  def initialize(items)
    @items = items
  end

  def decrease_item_quality(item)
    if item.quality > 0
      item.quality = item.quality - 1
      if item.sell_in < 0 
        item.quality = item.quality - 1
      end
    end
  end

  def increase_item_quality(item)
    if item.quality < 50
      item.quality = item.quality + 1
    end
  end

  def change_backstage_passes_quality(item)
    increase_item_quality(item)
    if item.sell_in < 11
      increase_item_quality(item)
    end
    if item.sell_in < 6
      increase_item_quality(item)
    end
    if item.sell_in < 0
      item.quality = 0
    end
  end

  def change_aged_brie_quality(item)
    increase_item_quality(item)
    if item.sell_in < 0
      increase_item_quality(item)
    end
  end

  def decrease_sell_in_days(item)
    item.sell_in = item.sell_in - 1
  end

  def modify_item_quality(item)
    case item.name
      when "Backstage passes to a TAFKAL80ETC concert"
        change_backstage_passes_quality(item)
      when "Aged Brie"
        change_aged_brie_quality(item)
      else
        decrease_item_quality(item)
    end 
  end
  
  def daily_item_update()
    @items.each do |item|
      return unless item.name != "Sulfuras, Hand of Ragnaros"
      decrease_sell_in_days(item)
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