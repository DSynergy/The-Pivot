class Cart
  attr_accessor :content

  def initialize(content)
    @content = content || Hash.new
  end

  def items_with_quantity
    format_quantity
    items = {}
    content.each { |id, quantity| items[Item.find(id)] = quantity }
    items
  end

  def add_item(item_id)
    content[item_id] ||= 0
    content[item_id] += 1
  end

  def remove_item(item_id)
    if content[item_id] > 1
      content[item_id] -= 1
    else
      content.delete(item_id)
    end
  end

  private

  def format_quantity
    content.each { |item, quantity| content[item] = quantity.to_i }
  end

end
