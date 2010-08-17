module Shoppr
  class CategoryTreeResponse
    
    def initialize(options={})
      response = Shoppr::Client.get('/CategoryTree', :query => options)
      h = Hashie::Mash.new(response["CategoryTreeResponse"])     
      
      Shoppr.map_mash_attrs(self, h)

      @category = Category.new(self.category)
      
      if self.exceptions.exception.is_a?(Array)
        @exceptions = self.exceptions.exception.map {|exception| APIException.new(exception) } 
      else
        @exceptions = [APIException.new(self.exceptions.exception)]
      end
      
      @server_detail = ServerDetail.new(self.server_detail)  
      @client_tracking = ClientTracking.new(self.client_tracking)
      @browse_history = BrowseHistory.new(self.browse_history)
    end
            
  end
end