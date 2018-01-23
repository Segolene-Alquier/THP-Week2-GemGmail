require "gmail"
require "google_drive"
require "pry"

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

=begin
  email = gmail.compose do
    to "segolene.alquier@gmail.com"
    subject "Having fun in Puerto Rico!"
    body "Spent the day on the road..."
  end
email.deliver
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
