module Domain
  module Product
    module Reports
      module Workflow
        class Index
          include Elasticsearch::Persistence::Repository

            # Configure the Elasticsearch client
            client Elasticsearch::Client.new url: ENV['ELASTICSEARCH_URL'], log: true

            # Set a custom index name
            index :product_workflow

            # Set a custom document type
            type  :product

            # Specify the class to inicialize when deserializing documents
            klass ::Domain::Product::Reports::Workflow::Record

            # Configure the settings and mappings for the Elasticsearch index
            settings number_of_shards: 1,
              analysis: { analyzer: { ngram_analyzer: {
                  type: "custom",
                  tokenizer: "standard",
                  filter: ["lowercase", "mynGram"]
                }
              },
              filter: {
                mynGram: {
                  type: "nGram",
                  min_gram: 3,
                  max_gram: 20
                }
              } } do
              mapping do
                indexes :product_title,                         analyzer: 'ngram_analyzer',
                  fields: { raw: { type: "string", index: "not_analyzed"} }
                indexes :product_title_sort,                    analyzer: 'keyword'
                indexes :product_submitted_at_sort,             type:     'date'
                indexes :product_submitted_at,                  analyzer: 'snowball'
                indexes :published_at_sort,                     type:     'date'
                indexes :published_at,                          analyzer: 'snowball'
                indexes :product_subject,                       analyzer: 'ngram_analyzer'
                indexes :product_subject_sort,                  analyzer: 'keyword'
                indexes :product_grade,                         analyzer: 'snowball'
                indexes :product_grade_sort,                    analyzer: 'keyword'
                indexes :product_material_format,               analyzer: 'ngram_analyzer'
                indexes :product_material_format_sort,          analyzer: 'keyword'
                indexes :product_status,                        analyzer: 'ngram_analyzer'
                indexes :product_status_sort,                   analyzer: 'keyword'
                indexes :product_standard,                      analyzer: 'snowball'
                indexes :product_standard_sort,                 analyzer: 'keyword'
                indexes :product_id,                            index:    'no'

                indexes :publisher_name,                        analyzer: 'ngram_analyzer'
                indexes :publisher_name_sort,                   analyzer: 'keyword'
                indexes :publisher_alignment_percentage,        analyzer: 'snowball'

                indexes :alignment_report_id,                   index:    'no'
                indexes :alignment_report_status,               analyzer: 'snowball'
                indexes :alignment_report_status_sort,          analyzer: 'keyword'

                indexes :first_sme_name,                        analyzer: 'ngram_analyzer'
                indexes :first_sme_name_sort,                   analyzer: 'keyword'
                indexes :first_sme_assigned_at_sort,            type:     'date'
                indexes :first_sme_assigned_at,                 analyzer: 'snowball'
                indexes :first_sme_submitted_at_sort,           type:     'date'
                indexes :first_sme_submitted_at,                analyzer: 'snowball'

                indexes :second_sme_name,                       analyzer: 'ngram_analyzer'
                indexes :second_sme_name_sort,                  analyzer: 'keyword'
                indexes :second_sme_assigned_at_sort,           type:     'date'
                indexes :second_sme_assigned_at,                analyzer: 'snowball'
                indexes :second_sme_submitted_at_sort,          type:     'date'
                indexes :second_sme_submitted_at,               analyzer: 'snowball'

                indexes :third_sme_name,                        analyzer: 'ngram_analyzer'
                indexes :third_sme_name_sort,                   analyzer: 'keyword'
                indexes :third_sme_assigned_at_sort,            type:     'date'
                indexes :third_sme_assigned_at,                 analyzer: 'snowball'
                indexes :third_sme_submitted_at_sort,           type:     'date'
                indexes :third_sme_submitted_at,                analyzer: 'snowball'

                indexes :editorial_reviewer_name,               analyzer: 'ngram_analyzer'
                indexes :editorial_reviewer_name_sort,          analyzer: 'keyword'
                indexes :editorial_reviewer_assigned_at_sort,   type:     'date'
                indexes :editorial_reviewer_assigned_at,        analyzer: 'snowball'
                indexes :editorial_reviewer_submitted_at_sort,  type:     'date'
                indexes :editorial_reviewer_submitted_at,       analyzer: 'snowball'
                indexes :editorial_review_status,               analyzer: 'snowball'
                indexes :editorial_review_status_sort,          analyzer: 'keyword'

                indexes :publisher_preview_started_at_sort,     type:     'date'
                indexes :publisher_preview_started_at,          analyzer: 'snowball'
                indexes :publisher_preview_finished_at_sort,    type:     'date'
                indexes :publisher_preview_finished_at,         analyzer: 'snowball'

                indexes :ll_alignment_percentage,               analyzer: 'keyword'
              end
            end

            def serialize(document)
              Hash[document.to_hash]
            end

            def deserialize(document)
              hash = ActiveSupport::HashWithIndifferentAccess.new(document['_source']).deep_symbolize_keys
              klass.new hash
            end

        end
      end
    end
  end
end