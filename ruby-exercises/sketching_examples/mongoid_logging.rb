require_relative './sketches_init'

title 'Mongoid Logging'

log = Telemetry::MongoidLog

log.clear!

log.! do
  Mongoid.logger.debug 'A mongoid log message'
  log.output!
end
