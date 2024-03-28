module MainCategoryHelper
  def set_main_category
    @main_categories = Category.where(parent_id: Category.find_by(name: 'Товар').category_id, status: true)
  end
end