require 'gmail'
require_relative 'scrap_scrap2.rb'
require "google_drive"

###########################
#get access to spreadsheet#
###########################

session = GoogleDrive::Session.from_config("config2.json")
w = session.spreadsheet_by_key("1fEfrXkWXJ2E7sP3365ZX8HbeFqDVRP1OwVCo12B6nl4").worksheets[0]

#######
#email#
#######

#authentification
puts "Gmail username (or email):"
login = gets.chomp
puts "Gmail password for '#{login}':"
pw = gets.chomp
gmail = Gmail.connect(login, pw)

#test if connection was successful?
puts "*Successfully logged in to Gmail servers!" if gmail.logged_in? == true

#compose + send email to each database email
y = 2
until (w[y, 1] == '' && w[y, 2] == '') #Tant que la case du spreadsheet est remplie
  gmail.deliver do
    to w[y, 2] #à 'email'
    subject "IMPORTANT - The HACKING Project"
    text_part do
      body "https://www.thehackingproject.org"
    end
  end
puts "Email sent to #{w[y, 2]}" #CLI feedback
y += 1
end

#disconnect
gmail.logout



=begin

def connect()
  gmail = Gmail.connect("the.hacking.roger@gmail.com", "hackingroger38")
    if gmail.logged_in?
      puts "yes"
    end
end

def send()
    email = gmail.compose do
      to "segolene.alquier@gmail.com"
      subject "AMAZING! This guy managed to enlarge his penis. *CLICK, NO SPAM*"
      body "Check this out, you won't be disappointed!"
    end
    email.deliver!
end

def perform()
  return connect()
  return send()
end

perform()


def connect()
  gmail = Gmail.connect("the.hacking.roger@gmail.com", "hackingroger38")
    if gmail.logged_in?
      puts "yes"
    end
end

def send()
  gmail.deliver do
      to "segolene.alquier@gmail.com"
      subject "AMAZING! This guy managed to enlarge his penis. *CLICK, NO SPAM*"
      text_part do
        body "Check this out, you won't be disappointed!"
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<p>Text of <em>html</em> message.</p>"
      end
  end
end

def perform()
  return connect()
  return send()
end

perform()
=end
