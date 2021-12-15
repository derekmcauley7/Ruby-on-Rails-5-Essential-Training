class Section < ApplicationRecord

  belongs_to :page
  has_many :section_edits
  has_many :admin_users, :through => :section_edits

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }

  CONTENT_TYPES = %w[text HTML]

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :content
  validates_inclusion_of :content_type, :in => CONTENT_TYPES,
                         :message => "must be one of #{CONTENT_TYPES.join(', ')}"


end
