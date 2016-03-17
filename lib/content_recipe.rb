require 'hashie'

def ContentPiece
  attr_reader :title, :description

end

def ContentCollection < ContentPiece

  def lede
  end

  def content
  end

end


def ContentRecipe
  include ContentCollection
  def initialize(obj)

  end

end


def SourceablePiece
  attr_reader :source_url, :source_name
end

def URLocatablePiece
  attr_reader :url
end



def ImagePiece < ContentPiece
  include SourceablePiece
  include URLocatablePiece
  attr_reader :url


  def caption; @description; end

end


def Embeddable < ContentPiece
  include URLocatablePiece
end

def Snippet < Slide
  attr_reader :code, :lang, :stdout
end

