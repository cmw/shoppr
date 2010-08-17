module Shoppr
  class Category
    
    attr_accessor :attributes, :products, :subcategories
    
    def initialize(cat_mash)
      Shoppr.map_mash_attrs(self, cat_mash)
      
      
      if self.attributes
        if self.attributes.attribute
          @attributes = self.attributes.attribute.map {|attribute| Attribute.new(attribute) } 
        else
          @attributes = []
        end
      else
        @attributes = []
      end
    
      if self.respond_to? :items
        if self.items.product.is_a?(Array)
          @products = self.items.product.map {|product| Product.new(product) } 
        else
          @products = self.items.product ? [Product.new(self.items.product)] : []
        end
      else
        @products = []
      end
      
      if self.respond_to? :categories
        if self.categories.category.is_a?(Array)
          @subcategories = self.categories.category.map {|category| Category.new(category) } 
        else
          @subcategories = self.categories.category ? [Category.new(self.categories.category)] : []
        end
      else
        @subcategories = []
      end
      
    end
    
  end
end