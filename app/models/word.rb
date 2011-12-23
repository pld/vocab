class Word < ActiveRecord::Base
  validates_presence_of :word
  validates_numericality_of :known
  validates_presence_of :definition1
  
  has_one :language
  
  # has_finder :familiar_by, lambda { |known| { :conditions => ["known < #{known}"] } }
  
  def definition
    definition1
  end
  
  def definitions
    result = definition
    2.upto(4) do |i|
      string = eval("definition#{i}")
      result += "; #{string}" unless string.nil? || string.empty?
    end
    result
  end
  
  class << self
    def find_store(settings)
      self.find(:all, :order => build_order(settings), :conditions => ["language_id = ?", settings[:language]])
    end
    
    def familiar_prefixed_by(word, settings)
      conditions = "known < #{word[:known]}"
      conditions += " AND word LIKE '#{word[:word]}%'" if word[:word] != '-'
      self.find(:all, :conditions => conditions, :order => build_order(settings))
    end

    private
    def build_order(settings)
      (settings[:order] || 'word') + (settings[:dir] ? ' ASC' : ' DESC') + settings[:ext].to_s
    end
  end
end
