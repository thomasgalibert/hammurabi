module Ordering
  extend ActiveSupport::Concern

  def initialize_row_order(items, order: :desc)
    items.order(created_at: order).each_with_index do |item, index|
      item.update(row_order: index+1) if item.row_order.nil?
    end
  end

  def reorder_items(items, item, new_position)
    # Initialiser row_order si nécessaire
    initialize_row_order(items)

    item_to_move = item
    old_position = item_to_move.row_order

    # Mise à jour de l'ordre
    if old_position < new_position
      # Déplacer vers le bas dans la liste
      items.where(row_order: (old_position + 1)..new_position).each do |item|
        item.update(row_order: item.row_order - 1)
      end
    elsif old_position > new_position
      # Déplacer vers le haut dans la liste
      items.where(row_order: new_position..(old_position - 1)).each do |item|
        item.update(row_order: item.row_order + 1)
      end
    end

    # Mettre à jour la position de l'élément
    item_to_move.update(row_order: new_position)
  end

  # Supprimer un élément et réajuster l'ordre
  def delete_item(items, item)
    item_to_delete = item
    deleted_position = item_to_delete.row_order

    # Supprimer l'élément
    item_to_delete.destroy

    # Réajuster l'ordre des éléments restants
    items.where('row_order > ?', deleted_position).each do |item|
      item.update(row_order: item.row_order - 1)
    end
  end

  def delete_item_with_position(items, item)
    item_to_delete = item
    deleted_position = item_to_delete.position

    # Supprimer l'élément
    item_to_delete.destroy

    # Réajuster l'ordre des éléments restants
    items.where('position > ?', deleted_position).each do |item|
      item.update(position: item.position - 1)
    end
  end

  def add_item_to_list(items, item)
    if items.count == 1
      item.update(row_order: 1)
    else
      max_position = items.maximum(:row_order) || 0
      item.update(row_order: max_position + 1)
    end
  end

  def add_item_to_list_with_position(items, item)
    if items.count == 1
      item.update(position: 1)
    else  
      max_position = items.maximum(:position) || 0
      item.update(position: max_position + 1)
    end
  end

  def reorder_items_with_acts_as_list(items, item, new_position)
    item_to_move = item
    old_position = item_to_move.position

    # Mise à jour de l'ordre
    if old_position < new_position
      # Déplacer vers le bas dans la liste
      items.where(position: (old_position + 1)..new_position).each do |item|
        item.update(position: item.position - 1)
      end
    elsif old_position > new_position
      # Déplacer vers le haut dans la liste
      items.where(position: new_position..(old_position - 1)).each do |item|
        item.update(position: item.position + 1)
      end
    end

    # Mettre à jour la position de l'élément
    item_to_move.update(position: new_position)
  end
end
