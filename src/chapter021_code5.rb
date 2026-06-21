if ARGV[0] == "-n" || ARGV[0] == "--number"
  @options[:number] = true
  ARGV.shift
end