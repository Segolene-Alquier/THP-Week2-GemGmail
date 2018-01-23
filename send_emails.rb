require "rubygems"
require "gmail"
require "google_drive"

def send_emails()
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1fEfrXkWXJ2E7sP3365ZX8HbeFqDVRP1OwVCo12B6nl4").worksheets[0]

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
    until (ws[y, 1] == '' && ws[y, 2] == '') #Tant que la case du spreadsheet est remplie
      gmail.deliver do
        to ws[y, 2] #à 'email'
        subject "IMPORTANT - The HACKING Project"
        text_part do
          body "Bonjour, Je m'appelle Ségolène, je suis élève à une formation de code gratuite,
          ouverte à tous, sans restriction géographique, ni restriction de niveau.
          La formation s'appelle The Hacking Project (http://thehackingproject.org/).
          Nous apprenons l'informatique via la méthode du peer-learning :
          nous faisons des projets concrets qui nous sont assignés tous les jours,
          sur lesquels nous planchons en petites équipes autonomes. Le projet du jour
          est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire
          de The Hacking Project un nouveau format d'éducation gratuite.
          Nous vous contactons pour vous parler du projet, et vous dire que
          vous pouvez ouvrir une cellule à {city}, où vous pouvez
          former gratuitement 6 personnes (ou plus), qu'elles soient débutantes,
          ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas
          de limite en terme de nombre de moussaillons (c'est comme cela que
          l'on appelle les élèves), donc nous serions ravis de travailler avec {city} !
          Charles, co-fondateur de The Hacking Project pourra répondre à toutes
          vos questions : 06.95.46.60.80"
        end
      end
  p "Email sent to #{ws[y, 2]}" #CLI feedback
  y += 1
  end

  gmail.logout #disconnect
end

send_emails
