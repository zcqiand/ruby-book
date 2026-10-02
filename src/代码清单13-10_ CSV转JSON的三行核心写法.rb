require 'json'
require 'csv'

data = CSV.read('input.csv', headers: true).map { |row| row.to_hash }
File.write('output.json', JSON.pretty_generate(data))