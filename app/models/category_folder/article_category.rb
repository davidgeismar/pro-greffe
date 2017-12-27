# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  small_image   :string
#  category_type :string
#  visible       :boolean
#  admin_check   :boolean
#  slug          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  type          :string
#

# Category for the Article of the blog
class ArticleCategory < Category
  has_many :articles, through: :categorizings, source: :categorizable, source_type: "Article"
  has_many :categorizables, through: :categorizings, source: :categorizable, source_type: "Article"

end
