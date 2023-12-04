# csv-rb-converter.rb
# CLI tool for quickly converting CSVs into Ruby hash arrays, saved in an .rb file.

# usage: ruby csv-rb-converter.rb <csv_file>
#   - csv_file: path to CSV file to convert
#   - output: <csv_file>.rb (default to same dir as csv_file)

# flags:
#   -h: no headers (default includes headers)
#   -a: append to existing file (default overwrites)

# ideally also want
# a flag to specify source CSV's dir
# maybe a flag to specify alternate output dir just for completeness
# also a flag to indicate headers false, but defaults to true
require 'csv'

class CsvToRbConverter
  def initialize(args)
    @args = args
    parse_flags
  end

  def write_csv_to_rb
    unless csv_filepath
      puts "Please provide a CSV filepath"
      return -1
    end

    File.open(rb_filepath, flags[:write_mode]) do |file|
      file.write("data = [\n")
      csv.each do |row|
        file.write("  #{row.to_hash},\n")
      end
      file.write("]\n")
    end

    puts "Successfully wrote #{csv.count} rows to #{rb_filepath}"

    return 0
  end

  private

  def flags
    @flags ||= {
      headers: true,
      write_mode: 'w'
    }
  end

  def parse_flags
    @args.each do |arg|
      if arg.start_with? '-'
        if arg.include? 'h'
          flags[:headers] = false
        end
        if arg.include? 'a'
          flags[:write_mode] = 'a'
        end
      end
    end
  end

  def csv_filepath
    @csv_filepath ||= begin
      @args.find do |arg|
        arg.end_with? '.csv'
      end
    end
  end

  def rb_filepath
    @rb_filepath ||= begin
      @csv_filepath.gsub('.csv', '.rb')
    end
  end

  def csv
    csv_text ||= File.read(csv_filepath)
    @csv ||= CSV.parse(csv_text, :headers => flags[:headers])
  end
end

CsvToRbConverter.new(ARGV).write_csv_to_rb
