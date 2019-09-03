require "spec_helper"
require "gilded_rose"

describe GildedRose do

  describe "#update_quality" do

    it "degrades item quality" do
      items = [Item.new("Milk", 5, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 49
    end

    it "quality degrades twice as fast when days are less than 0" do
      items = [Item.new("Milk", 0, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 48
    end

    it "reduces sell in days quantity" do
      items = [Item.new("Milk", 5, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 4
    end

    it "quality never becomes negative" do
      items = [Item.new("Milk", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it "does not age Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
    end

    it "does not degrade Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 80
    end

    it "increases quality for Aged Brie by 1" do
      items = [Item.new("Aged Brie", 30, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 31
    end

    it "increases quality for Aged Brie by 2 when days are less than 0" do
      items = [Item.new("Aged Brie", 0, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 32
    end
    
    it "max quality is 50" do
      items = [Item.new("Aged Brie", 30, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end
    
    it "increases quality for backstage passes by 1 for more than 10 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 30, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 31
    end

    it "increases quality for backstage passes by 2 for days between 5 and 10" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 32
    end
    
    it "increases quality for backstage passes by 3 for less than 5 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 33
    end
    
    it "drops quality to 0 when days are 0 for backstage passes" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
 
  end

end
