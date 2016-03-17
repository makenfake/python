require "lib/content_stuff/snippet"

module ContentStuff
  def ContentPieceFactory(obj)
    if (k = obj[:kind])
      k = k.to_sym
      if k == :snippet
        Snippet.new(obj)
      else
        ContentPiece.new(obj)
      end
    else
      ContentPiece.new(obj)
    end
  end
end
