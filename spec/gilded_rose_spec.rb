require "spec_helper"
require "gilded_rose"

describe GildedRose do
  describe "#daily_item_update" do
    it "degrades item quality" do
      items = [Item.new("Milk", 5, 50)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 49
    end

    it "quality degrades twice as fast when days are less than 0" do
      items = [Item.new("Milk", 0, 50)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 48
    end

    it "reduces sell in days quantity" do
      items = [Item.new("Milk", 5, 50)]
      GildedRose.new(items).daily_item_update
      expect(items[0].sell_in).to eq 4
    end

    it "minimum quality is 0" do
      items = [Item.new("Milk", 0, 0)]
      GildedRose.new(items).daily_item_update
      expect(items[0].quality).to eq 0
    end

    it "max quality is 50" do
      items = [
        AgedBrie.new("Aged Brie", 30, 49), 
        BackstagePasses.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)
      ]
      GildedRose.new(items).daily_item_update()

      items.each do |item| 
        puts item.name
        expect(item.quality).to eq 50
      end
    end

    it "does not age Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].sell_in).to eq 5
    end

    it "does not degrade Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 80
    end

    it "increases quality for Aged Brie by 1" do
      items = [AgedBrie.new("Aged Brie", 30, 30)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 31
    end

    it "increases quality for Aged Brie by 2 when days are less than 0" do
      items = [AgedBrie.new("Aged Brie", 0, 30)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 32
    end
    
    it "increases quality for backstage passes by 1 for more than 10 days" do
      items = [BackstagePasses.new("Backstage passes to a TAFKAL80ETC concert", 30, 30)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 31
    end

    it "increases quality for backstage passes by 2 for days between 5 and 10" do
      items = [BackstagePasses.new("Backstage passes to a TAFKAL80ETC concert", 10, 30)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 32
    end
    
    it "increases quality for backstage passes by 3 for less than 5 days" do
      items = [BackstagePasses.new("Backstage passes to a TAFKAL80ETC concert", 5, 30)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 33
    end

    it "does not increase quality for backstage passes over 50" do
      items = [BackstagePasses.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 50
    end
    
    it "drops quality to 0 when days are 0 for backstage passes" do
      items = [BackstagePasses.new("Backstage passes to a TAFKAL80ETC concert", 0, 30)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq 0
    end

    it "degrades Conjured items quality twice as fast" do 
      items = [Conjured.new('Conjured', 20, 40)]
      GildedRose.new(items).daily_item_update()
      expect(items[0].quality).to eq(38)
    end
  end
end
