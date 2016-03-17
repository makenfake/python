require 'lib/content_stuff/content_piece'
module ContentStuff
  class Snippet < ContentPiece
    attr_reader :lang, :code, :stdout
    def initialize(obj)
      super(obj)
      @lang = obj.lang
      @code = obj.code
      @kind = :snippet #??
      @stdout = obj.stdout
    end
  end
end
