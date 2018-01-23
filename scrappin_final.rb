require "rubygems"
require "open-uri"
require "nokogiri"
require "google_drive"
require "json"

def get_all_the_emails_of_isere
  url = []
  db = Hash.new
  doc = Nokogiri::HTML(open('http://www.annuaire-des-mairies.com/isere.html'))
  hrefs = doc.css('a.lientxt').map { |link| link['href'] }
  hrefs.each do |item|
    url = "http://annuaire-des-mairies.com/" + item[2..-1]

begin
  doc2 = Nokogiri::HTML(open(url))
    doc2.css('tr/td/p/font').each do |node|
      if /@/ =~ node.text
        db[(url)[35..-6]] = node.text[1..-1]
      end
    end
  rescue StandardError => error
    puts error.class
  end
  end
  return db
end

puts get_all_the_emails_of_isere

def spreadsheet()
session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1fEfrXkWXJ2E7sP3365ZX8HbeFqDVRP1OwVCo12B6nl4").worksheets[0]
    y = 2
    get_all_the_emails_of_isere.each do |city, mail|
        ws[y, 1] = city
        ws[y, 2] = mail
        y += 1
    end
ws.save
end

def perform()
  get_all_the_emails_of_isere
  spreadsheet
end

perform
