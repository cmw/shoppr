module Shoppr
  class Product    
    attr_accessor :review_count, :rating, :rating_image, :review_url, :overall_rating, :feature_rating, :rating_image, :product_offers
    
    def initialize(cat_mash)   
      Shoppr.map_mash_attrs(self, cat_mash)
      
      @product_offers = if self.offers
        if self.offers.offer.is_a?(Array)
          self.offers.offer.map {|offer| Offer.new(offer) }
        else
          [Offer.new(self.offers)]
        end
      else
        []
      end
      
      @overall_rating = self.reviews.averageRating.overallRating rescue nil
      
      @reviews = self.reviews.consumerReview ? [self.reviews.consumerReview].flatten.map {|rev| ConsumerReview.new(rev)} : [] rescue []
      
      @review_count = self.rating.reviewCount
      @review_url = self.rating.reviewURL
      
      @rating_image = Image.new(self.rating.ratingImage) rescue nil
      
      @rating = self.rating.rating     
      
      @images = if self.images.image.is_a?(Array)
        self.images.image.map {|image| Image.new(image)}
      else
        [Image.new(self.images.image)]
      end
      
      @specifications = self.specifications.featureGroup.map {|spec| FeatureGroup.new(spec)} rescue []
    end
    
  end
end