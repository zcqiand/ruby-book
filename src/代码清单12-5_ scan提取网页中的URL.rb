html = '<a href="https://example.com">Example</a> <a href="https://test.org">Test</a>'
urls = html.scan(/href="([^"]+)"/).flatten
# => ["https://example.com", "https://test.org"]