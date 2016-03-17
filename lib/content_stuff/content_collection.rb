require 'lib/content_stuff/content_piece'
require 'lib/content_stuff/content_piece_factory'
module ContentStuff
  class ContentCollection < ContentPiece
    attr_reader :lede
    def initialize(obj)
      super(obj)
      @lede = ContentPieceFactory(obj.lede)
      puts("Lede is a: #{@lede.class}")
    end
  end
end
