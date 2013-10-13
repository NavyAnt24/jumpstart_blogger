class Article < ActiveRecord::Base
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings

	def tag_list
		self.tags.collect do |tag|
			tag.name
		end.join(", ")
	end

	def tag_list=(tags_string)
		input_tags = tags_string.split(",").map { |tag| tag.strip.downcase }.uniq
		new_or_found_tags = input_tags.map { |tag_name| Tag.find_or_create_by(name: tag_name) }
		self.tags = new_or_found_tags
	end

end
