require_relative '../script_init'

main_title 'Update preview completed mail template'

mailer = MailTemplate.where(number: '#37').first
mailer.from = "Learning List <#{AppConfig['info_email']}>"
mailer.subject = 'Publisher {{ publisher_company_name }} has completed preview.'
mailer.template = '<p style="margin: 0; margin-bottom: 1em; padding: 0;">
  Publisher {{ publisher_company_name }}
  has completed preview period for
  <a href="{{ link_to_product }}">{{ product_title }}</a>.
  </p>'
mailer.save
puts mailer.inspect