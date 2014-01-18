class Product < ActiveRecord::Base
	has_many :line_items 
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_items
	validates_presence_of :title, :description, :price
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
	
	private 
	def ensure_not_referenced_by_any_line_items
		if line_items.empty?
			return true 
		else 
			errors.add(:base, "Line items presents ")
			return false 
		end 
		
	end
	def self.latest_order
		Product.order(:updated_at).last
		
	end

end
