require_relative '../script_init'

main_title 'Migrate from Podio to Zoho'

log = Telemetry::MongoidLog
log.clear!

def create_notes(district, crm_account)    
  comments = Podio::Comment.find_all_for( "item", district["item_id"] )
  name = district["fields"].select {|field| field["label"] == "District / Name" }
  account_name = name[0]["values"][0]["value"] if name.present? && name[0]["values"][0]["value"]
  
  if comments.present?
    comments.each do |comment|
      unless comment["value"].empty?
        puts "Posting note..."
        posted_date = comment["created_on"].to_time.strftime("%m/%d/%Y %I:%M%P")
        title = "Posted on: #{posted_date}"
        content = Nokogiri::HTML(comment["value"]).text.gsub(/\n/, ' ').gsub(/\'/, ' ').gsub(/\&/, 'and').gsub(/\"/, ' ')
        
        note = Domain::CRM::Notes::Note.new
        note.entity_id = crm_account.accountid
        note.note_title = title
        note.note_content = content

        Domain::CRM::Notes::Commands::Post.! note, options = { :action => "insert"}

        puts "\n-------------------------------------------------------\n\n"
      end
    end
  end
  puts "\n=========================\n\n"
end

def create_pipeline(district, crm_account)
  name = district["fields"].select {|field| field["label"] == "District / Name" }
  potential_name = name[0]["values"][0]["value"] if name.present? && name[0]["values"][0]["value"]

  pipeline_stage = district["fields"].select {|field| field["label"] == "Pipeline Stage" }
  stage = pipeline_stage[0]["values"][0]["value"]["text"] if pipeline_stage.present? && pipeline_stage[0]["values"][0]["value"]["text"]

  source = district["fields"].select {|field| field["label"] == "Source" }
  lead_source = source[0]["values"][0]["value"]["text"] if source.present? && source[0]["values"][0]["value"]["text"]

  enrollment_num = district["fields"].select {|field| field["label"] == "Enrollment" }
  if enrollment_num.present? && enrollment_num[0]["values"][0]["value"].present?
    enrollment = enrollment_num[0]["values"][0]["value"].to_i
  else
    enrollment = 1
  end

  if enrollment == 0
    enrollment = 1
  end

  unless enrollment > 2000000
    subscription_price = ::Domain::SubscriptionPrice::Queries::ByEnrollmentAndSubscriptionType.! enrollment, "organizational_account"

    enrollment_decimal = BigDecimal.new(enrollment, 10)
    min_enrollment = BigDecimal.new(subscription_price.min_enrollment, 10)
    max_enrollment = BigDecimal.new(subscription_price.max_enrollment, 10)
    min_price = BigDecimal.new(subscription_price.min_price, 10)
    max_price = BigDecimal.new(subscription_price.max_price, 10)

    annual_cost = (min_price + (((enrollment_decimal - min_enrollment) / (max_enrollment - min_enrollment)) * (max_price - min_price)))
  else
    price = district["fields"].select {|field| field["label"] == "Subscription Price" }
    annual_revenue = price[0]["values"][0]["value"] if price.present? && price[0]["values"][0]["value"]
    annual_cost = annual_revenue
  end



  crm_potential = Domain::CRM::Potentials::Potential.new
  crm_potential.potential_name = potential_name ? potential_name : "Name not specified"
  crm_potential.account_name = crm_account.account_name
  crm_potential.accountid = crm_account.accountid
  crm_potential.enrollment = enrollment
  crm_potential.stage = stage ? stage : "Prospect"
  crm_potential.amount = annual_cost
  crm_potential.lead_source = lead_source

  Domain::CRM::Potentials::Commands::Post.! crm_potential, options = { :action => "insert"}
end

def create_contact(district, contact_label, crm_account)
  contacts = district["fields"].select { |field| field["label"] == contact_label }

  if contacts.present? && contacts[0]["values"].count > 1

    contacts[0]["values"].each do |contact|
      if contact["label"] == "Ambassador Contact"
        ambassador = contact["value"]
        ambassador_sanitized = Nokogiri::HTML(ambassador).text
        name_ary = ambassador_sanitized.split(" ")

        if name_ary && name_ary.count > 2
          first_name = "#{name_ary[0]} #{name_ary[1]}"
          last_name = name_ary[2]
        elsif name_ary && name_ary.count > 0
          first_name = name_ary[0]
          last_name = name_ary[1]
        end
      else

        phone = contact["value"]["phone"][0] if contact.present? && contact["value"]["phone"]
      
        title = contact["value"]["title"][0] if contact.present? && contact["value"]["title"]

        email = contact["value"]["mail"][0] if contact.present? && contact["value"]["mail"]

        city = contact["value"]["city"] if contact.present? && contact["value"]["city"]

        street = contact["value"]["address"][0] if contact.present? && contact["value"]["address"]
        
        state = contact["value"]["state"] if contact.present? && contact["value"]["state"]

        zip = contact["value"]["zip"] if contact.present? && contact["value"]["zip"]
        
        name_ary = contact["value"]["name"].split(" ") if contact.present? && contact["value"]["name"]

        if name_ary && name_ary.count > 2
          first_name = "#{name_ary[0]} #{name_ary[1]}"
          last_name = name_ary[2]
        elsif name_ary && name_ary.count > 0
          first_name = name_ary[0]
          last_name = name_ary[1]
        end
      end

      source = district["fields"].select {|field| field["label"] == "Source" }
      lead_source = source[0]["values"][0]["value"]["text"] if source.present? && source[0]["values"][0]["value"]["text"]

      crm_contact = Domain::CRM::Contacts::Contact.new
      crm_contact.first_name = first_name ? first_name : ""
      crm_contact.last_name = last_name ? last_name : email
      crm_contact.title = title ? title : ""
      crm_contact.account_name = crm_account.account_name
      crm_contact.accountid = crm_account.accountid
      crm_contact.email = email ? email : ""
      crm_contact.phone = phone ? phone : ""
      crm_contact.mailing_street = street ? street : ""
      crm_contact.mailing_city = city ? city : ""
      crm_contact.mailing_state = state ? state : ""
      crm_contact.mailing_zip = zip ? zip : ""
      crm_contact.lead_source = lead_source ? lead_source : ""

      Domain::CRM::Contacts::Commands::Post.! crm_contact, options = { :action => "insert"}
    end

  elsif contacts.present? && contacts[0]["values"].count > 0

    if contacts[0]["label"] == "Ambassador Contact"
      ambassador = contacts[0]["values"][0]["value"]
      ambassador_sanitized = Nokogiri::HTML(ambassador).text
      name_ary = ambassador_sanitized.split(" ")

      if name_ary && name_ary.count > 2
        first_name = "#{name_ary[0]} #{name_ary[1]}"
        last_name = name_ary[2]
      elsif name_ary && name_ary.count > 0
        first_name = name_ary[0]
        last_name = name_ary[1]
      end
    else
      phone = contacts[0]["values"][0]["value"]["phone"][0] if contacts.present?.present? && contacts[0]["values"][0]["value"]["phone"]
      
      title = contacts[0]["values"][0]["value"]["title"][0] if contacts.present?.present? && contacts[0]["values"][0]["value"]["title"]

      email = contacts[0]["values"][0]["value"]["mail"][0] if contacts.present?.present? && contacts[0]["values"][0]["value"]["mail"]

      city = contacts[0]["values"][0]["value"]["city"] if contacts.present?.present? && contacts[0]["values"][0]["value"]["city"]

      street = contacts[0]["values"][0]["value"]["address"][0] if contacts.present?.present? && contacts[0]["values"][0]["value"]["address"]
      
      zip = contacts[0]["values"][0]["value"]["zip"] if contacts.present?.present? && contacts[0]["values"][0]["value"]["zip"]
      
      state = contacts[0]["values"][0]["value"]["state"] if contacts.present?.present? && contacts[0]["values"][0]["value"]["state"]

      name_ary = contacts[0]["values"][0]["value"]["name"].split(" ") if contacts.present?.present? && contacts[0]["values"][0]["value"]["name"]

      if name_ary && name_ary.count > 2
        first_name = "#{name_ary[0]} #{name_ary[1]}"
        last_name = name_ary[2]
      elsif name_ary && name_ary.count > 0
        first_name = name_ary[0]
        last_name = name_ary[1]
      end
    end

    source = district["fields"].select {|field| field["label"] == "Source" }
    lead_source = source[0]["values"][0]["value"]["text"] if source.present? && source[0]["values"][0]["value"]["text"]

    crm_contact = Domain::CRM::Contacts::Contact.new
    crm_contact.first_name = first_name ? first_name : ""
    crm_contact.last_name = last_name ? last_name : email
    crm_contact.title = title ? title : ""
    crm_contact.account_name = crm_account.account_name
    crm_contact.accountid = crm_account.accountid
    crm_contact.email = email ? email : ""
    crm_contact.phone = phone ? phone : ""
    crm_contact.mailing_street = street ? street : ""
    crm_contact.mailing_city = city ? city : ""
    crm_contact.mailing_state = state ? state : ""
    crm_contact.mailing_zip = zip ? zip : ""
    crm_contact.lead_source = lead_source ? lead_source : ""

    Domain::CRM::Contacts::Commands::Post.! crm_contact, options = { :action => "insert"}
  end
end

def create_account(district)
  puts "Podio Item:"
  puts district["item_id"] 

  name = district["fields"].select {|field| field["label"] == "District / Name" }
  account_name = name[0]["values"][0]["value"] if name.present? && name[0]["values"][0]["value"]

  puts account_name ? account_name : "Not specified"

  lead = district["fields"].select {|field| field["label"] == "Lead Owner"}
  lead_owner = lead[0]["values"][0]["value"]["name"] if lead.present? && lead[0]["values"][0]["value"]["name"]
  
  type = district["fields"].select {|field| field["label"] == "Account Type" }
  account_type = type[0]["values"][0]["value"]["text"] if type.present? && type[0]["values"][0]["value"]["text"]
  
  link = district["fields"].select {|field| field["label"] == "Website Link" }
  website = link[0]["values"][0]["embed"]["resolved_url"] if link.present? && link[0]["values"][0]["embed"]["resolved_url"]
  
  service_center = district["fields"].select {|field| field["label"] == "Education Service Center" }
  education_service_center = service_center[0]["values"][0]["value"] if service_center.present? && service_center[0]["values"][0]["value"]
  service_center_sanitized = Nokogiri::HTML(education_service_center).text if education_service_center

  last_contact = district["fields"].select {|field| field["label"] == "Last Contacted" }
  last_contacted = last_contact[0]["values"][0]["start_date"] if last_contact.present? && last_contact[0]["values"][0]["start_date"]

  touch = district["fields"].select {|field| field["label"] == "Touch Points" }
  touch_points = touch[0]["values"][0]["value"]["text"] if touch.present? && touch[0]["values"][0]["value"]["text"]

  subscription_date = district["fields"].select {|field| field["label"] == "Subscription Date" }
  subscription_start_date = subscription_date[0]["values"][0]["start_date"].to_date.strftime("%m%d%Y") if subscription_date.present? && subscription_date[0]["values"][0]["start_date"]
  subscription_end_date = subscription_date[0]["values"][0]["end_date"].to_date.strftime("%m%d%Y") if subscription_date.present? && subscription_date[0]["values"][0]["end_date"]

  price = district["fields"].select {|field| field["label"] == "Subscription Price" }
  annual_revenue = price[0]["values"][0]["value"] if price.present? && price[0]["values"][0]["value"]

  enrollment_num = district["fields"].select {|field| field["label"] == "Enrollment" }
  enrollment = enrollment_num[0]["values"][0]["value"].to_i if enrollment_num.present? && enrollment_num[0]["values"][0]["value"]

  old_price = district["fields"].select {|field| field["label"] == "Old Pricing" }
  old_pricing = old_price[0]["values"][0]["value"] if old_price.present? && old_price[0]["values"][0]["value"]

  city = district["fields"].select {|field| field["label"] == "City" }
  billing_city = city[0]["values"][0]["value"] if city.present? && city[0]["values"][0]["value"]

  state = district["fields"].select {|field| field["label"] == "State" }
  billing_state = state[0]["values"][0]["value"]["text"] if state.present? && state[0]["values"][0]["value"]["text"]

  payment_received = district["fields"].select {|field| field["label"] == "Payment Received Date" }
  payment_received_date = payment_received[0]["values"][0]["start_date"].to_date.strftime("%m/%d/%Y") if payment_received.present? && payment_received[0]["values"][0]["start_date"]

  crm_account = Domain::CRM::Accounts::Account.new
  crm_account.account_name = account_name.present? ? account_name : "Name not specified"
  crm_account.account_number = Time.now().to_i
  crm_account.lead_owner = lead_owner.present? ? lead_owner : "Ed Valdez"
  crm_account.account_type = account_type.present? ? account_type : ""
  crm_account.website = website.present? ? website : ""
  crm_account.education_service_center = service_center_sanitized.present? ? service_center_sanitized : ""
  crm_account.last_contacted = last_contacted.present? ? last_contacted : ""
  crm_account.touch_points = touch_points.present? ? touch_points : ""
  crm_account.subscription_start_date = subscription_start_date.present? ? subscription_start_date : ""
  crm_account.subscription_end_date = subscription_end_date.present? ? subscription_end_date : ""
  crm_account.annual_revenue = annual_revenue.present? ? annual_revenue : ""
  crm_account.enrollment = enrollment.present? ? enrollment : 0
  crm_account.old_pricing = old_pricing.present? ? old_pricing : ""
  crm_account.billing_city = billing_city.present? ? billing_city : ""
  crm_account.billing_state = billing_state.present? ? billing_state : ""
  crm_account.payment_received_date = payment_received_date.present? ? payment_received_date : ""

  saved_account = Domain::CRM::Accounts::Commands::Post.! crm_account, options = { :action => "insert"}
  account = Domain::CRM::Accounts::Commands::GetRecordById.! saved_account.id
  # Create contact records
  ["Primary Contact", "Secondary Contact", "Ambassador Contact"].each do |contact_label|
    create_contact(district, contact_label, account)
  end
  
  # Create pipeline record
  create_pipeline(district, account)

  # Create notes on account
  create_notes(district, account)
end

def migrate_district(district)
  create_account(district)
end

# ------------------------------------------------------------------------------

puts "Connecting to Podio..."
Podio.setup(:api_key => 'learning-list-704nb3', :api_secret => 'pH58WucjHZiXzoakdInuTrfSAAYF5d8r5y6n8Ht52GL3xB75tVyoIxB3bGoeNpwM')
puts "\n-------------------------------------------------------\n\n"



puts "Authenticating..."
puts "\n-------------------------------------------------------\n\n"
Podio.client.authenticate_with_credentials('hollyg@learninglist.com', 'Panda5Orchid6Tea3Walle5Red3Stapler7')

puts "Getting districts..."

i = 0
item_num = 3801
item_offset = 38
offset = 100
limit = 100
times = 2

# i = 0
# item_num = 3520
# item_offset = 176
# offset = 20
# limit = 20
# times = 1

begin
  puts "i: #{i}"
  query_districts = Podio::Item.find_all(7251750, :limit => limit, :offset => (offset * item_offset), :sort_by => 'created_on')
  count = query_districts.count

  puts "\n-------------------------------------------------------\n\n"
  puts "Total Podio Districts: #{count}"
  puts "Migrating batch ##{i + 1} of #{times}"
  puts "\n-------------------------------------------------------\n\n"

  districts = query_districts.all

  districts.each do |district|
    puts "Migrating Item:\n"
    puts "#{item_num}"
    migrate_district(district)
    item_num +=1
  end

  item_offset +=1
  i +=1
end until i == times


puts "\n-------------------------------------------------------\n\n"
puts "Finished migrating districts."
puts "\n-------------------------------------------------------\n\n"
