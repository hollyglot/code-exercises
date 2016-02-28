require_relative './sketches_init'

main_title 'Get Alignment Report Subtrees'

log = Telemetry::MongoidLog
log.clear!

t = Benchmark.measure do

  resource = Page.find('titles-and-content-of-each-of-the-sections-on-the-homepage')

  resource.seo_metadata.title
  resource.seo_metadata.description
  resource.seo_metadata.keywords

  @pages = resource.children.asc(:position)
  @ribbons = Page.find('homepage-ribbon').children.asc(:position)

end

log.output!

comment "Time #{t}"
