helpers do
  def truncate(text, length:)
    text.length > length ? text[0...length] + '...' : text
  end
end