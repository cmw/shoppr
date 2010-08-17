module Shoppr
  class BrowseHistory
    
    attr_accessor :category_selections
    
    def initialize(cat_mash)
      return nil unless cat_mash
      Shoppr.map_mash_attrs(self, cat_mash)
      
      if self.category_selections
        @category_selections = self.category_selection.map {|category_selections| CategorySelection.new(category_selections) } 
      else
        @category_selections = []
      end
    end
    
  end
end