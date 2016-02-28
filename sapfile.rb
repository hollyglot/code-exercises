require 'net/sftp'

class SAPFile
  :attr_reader :s3, :host, :user, :password, :bucket, :sftp_path, :sftp_delete_path, :filename_prefix

  def self.transfer
    s3 = Aws::S3::Resource.new
    host = ENV['SAP_SFTP_HOST']
    user = ENV['SAP_SFTP_USER']
    password = ENV['SAP_SFTP_PASSWORD']
    sap_bucket = ENV['SAP_FILE_BUCKET']
    bucket = s3.bucket(sap_bucket || 'sap_pricing_files')
    sftp_path = ENV['SAP_SFTP_PATH'] || 'outgoing/pickup/'
    sftp_delete_path = ENV['SAP_SFTP_DELETE_PATH'] || 'outgoing/pickupd/'
    filename_prefix  = ENV['SAP_FILENAME_PREFIX'] || 'price_file_CVP'

    instance = new s3, host, user, password, bucket, sftp_path, sftp_delete_path, filename_prefix 
    instance.transfer
  end

  def initialize(s3, host, user, password, bucket, sftp_path, sftp_delete_path, filename_prefix)
    @s3 = s3
    @host = host
    @user = user
    @password = password
    @bucket = bucket
    @sftp_path = sftp_path
    @sftp_delete_path = sftp_delete_path
    @filename_prefix = filename_prefix
  end

  def transfer
    log "Transferring SAP Pricing Data files from their SFTP location to S3"
        
    create_bucket unless bucket.exists?

    upload_files
  end

  def upload_files
    file_count = 0
    if (host.present? && user.present? && password.present?)
      log_info "Logging onto SFTP..."
      begin
        Net::SFTP.start(host, user, password: password) do |sftp|
          log_info "Get a list of files that aren't in S3 yet..."

          sftp.dir.glob(sftp_path, "#{filename_prefix}*") do |entry|
            sap_filename = entry.name
            if bucket.objects.none? { |o| o.key == sap_filename }
              log_info "Copying #{sap_filename} from SFTP to S3..."
              sftp.file.open("#{sftp_path}#{sap_filename}", "r") do |file|
                obj = bucket.object(sap_filename)
                obj.put(body: file.read)
                file_count += 1
              end
            end

            log_info "Moving #{sap_filename} to the SFTP delete folder..."
            sftp.rename("#{sftp_path}#{sap_filename}", "#{sftp_delete_path}#{sap_filename}")
          end
        end
      rescue => e
        log_error e.message
      end
    else
      log_errors_for_missing_values
    end

    log_info "Done. #{file_count} files uploaded to S3."
  end

  def create_bucket
    log "Creating SAP S3 bucket: #{bucket.name}..."
    bucket.create
  end

  def log_errors_for_missing_values
    log_error 'ENV is missing SAP_SFTP_HOST value' if host.blank?
    log_error 'ENV is missing SAP_SFTP_USER value' if user.blank?
    log_error 'ENV is missing SAP_SFTP_PASSWORD value' if password.blank?
  end

  def log_info(message)
    Rails.logger.info message
  end

  def log_error(message)
    Rails.logger.error message
  end
end
