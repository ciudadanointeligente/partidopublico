require 'csv'
require 'awesome_print'
require 'facets/kernel/deep_copy'
require_relative '../../config/environment'
require 'utf8-cleaner'
require_relative 'common'

class NormalizingCsvSource
  def initialize(filename:, results:)
    @filename = filename
    @results = results
    #@csv = CSV.open(input_file, headers: true, header_converters: :symbol)
    @total = CSV.read(@filename, headers: true).length
    count
  end

  def count()
      @results[:input_rows] = @results[:input_rows].nil? ? @total : @results[:input_rows] + @total
  end

  def each
    csv = CSV.open(@filename, headers: true)
    csv.each do |row|
      row = row.to_hash
      group = row['Personas que lo integran'] || ''
      group.split("\n").each do |persona|
        row[:filename] = @filename
        yield(row.deep_copy.merge(persona: persona))
      end
    end
    csv.close
  end
end

class CSVSource
  @total = 0

  def initialize(filename:, results:)
    @filename = filename
    @results = results
    @total = CSV.read(@filename, headers: true).length
    count
  end

  def count()
      @results[:input_rows] = @results[:input_rows].nil? ? @total : @results[:input_rows] + @total
   end

  def each
    csv = CSV.open(@filename, headers: true)
    csv.each do |row|
      row[:filename] = @filename
      yield row.to_hash
    end
    csv.close
  end
end

class SymbolsCSVSource
  @total = 0

  def initialize(filename:, results:, print_headers:)
    # ver_encode = system("file -i #{input_path}")
    @filename = filename
    @results = results
    csv = CSV.read(@filename, headers: true, header_converters: :symbol, :quote_char => "|", :col_sep => ";")
    @total = csv.length
    count
    p csv.headers if print_headers
  end

  def count()
      @results[:input_rows] = @results[:input_rows].nil? ? @total : @results[:input_rows] + @total
  end

  def each
    # :row_sep => "\n", header_converters: :symbol,, encoding: "#{@encoding.upcase}:utf-8"
    csv = CSV.open(@filename, headers: true, :col_sep => ";", header_converters: :symbol, :quote_char => "|")
    # csv = CSV.open(@filename, headers: true, header_converters: :symbol, :col_sep => ";",:row_sep => "\n")
    # p "each SymbolsCSVSource :" + @filename
    csv.each do |row|
      yield row.to_hash
    end
    csv.close
  end
end
