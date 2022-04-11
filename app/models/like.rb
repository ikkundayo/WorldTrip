class Like < ApplicationRecord
  belongs_to :user
  #likeから他のモデルは必要ないのでbelongs_toは書かなくていい(書いたらNull制約でエラーになる)
  # belongs_to :memory
  # belongs_to :hint
end
