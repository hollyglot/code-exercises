require 'elasticsearch/model'

module Concerns
  module ProductSearch
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model

      index_name    "published_products"
      document_type "product"

      def as_indexed_json(options={})
        {
          title:                      self.title,
          sort_title:                 set_title_sort,
          state:                      self.state,
          publisher_name:             self.publisher_name,
          sort_publisher_name:        set_publisher_name_sort,
          sort_subject:               set_subjects_sort,
          subjects:                   set_subjects,
          material_format:            set_formats,
          filter_format:              set_formats_filter,
          material_type:              set_types,
          filter_type:                set_types_filter,
          grade:                      set_grades,
          ars_grade:                  set_ars_grades,
          sort_ars_titles:            set_ars_titles,
          compatibility:              set_compatibility,
          coverage:                   set_coverage,
          state_adopted:              set_state_adopted,
          filter_state_adopted:       set_state_adopted_filter,
          special_populations:        set_special_populations,
          filter_special_populations: set_special_populations_filter,
          date_reviewed:              set_submitted_at,
          description:                set_description,
          library_ids:                self.libraries.map(&:id),
          standard:                   set_standard,
          main_grade_index:           set_main_grade_index,
        }
      end

      settings do
        mapping dynamic: 'false' do
          indexes :id,                            index: :not_analyzed
          indexes :title,                         analyzer: 'snowball', type: :string, boost: 80

          indexes :sort_title,                    index: :not_analyzed
          indexes :state,                         index: :not_analyzed

          indexes :publisher_name,                analyzer: 'snowball', type: :string, boost: 10
          indexes :sort_publisher_name,           index: :not_analyzed
          indexes :sort_subject,                  index: :not_analyzed
          indexes :coverage,                      analyzer: 'standard', type: :long
          indexes :subjects,                      analyzer: 'keyword', type: :string, boost: 30
          indexes :material_format,               analyzer: 'keyword', type: :string
          indexes :filter_format,                 index: :not_analyzed
          indexes :material_type,                 analyzer: 'keyword', type: :string
          indexes :filter_type,                   index: :not_analyzed
          indexes :grade,                         analyzer: 'snowball', type: :string, boost: 70
          indexes :ars_grade,                     analyzer: 'keyword', type: :string, boost: 50
          indexes :sort_ars_titles,               index: :not_analyzed
          indexes :state_adopted,                 analyzer: 'snowball', type: :string, boost: 100
          indexes :filter_state_adopted,          index: :not_analyzed
          indexes :special_populations,           analyzer: 'keyword', type: :string
          indexes :filter_special_populations,    analyzer: 'keyword', type: :string
          indexes :library_ids,                   analyzer: 'keyword'
          indexes :standard,                      analyzer: 'keyword', type: :string
          indexes :main_grade_index,              analyzer: 'standard', type: :integer

          indexes :description,                   analyzer: 'snowball', type: :string

          indexes :date_reviewed, type: :date
        end
      end

      def set_description
        ActionView::Base.full_sanitizer.sanitize(self.description)
      end

      def set_ars_grades
        if self.alignment_reports.finalized.present?
          self.alignment_reports.finalized.map{ |ar| ar.grade.downcase }.uniq
        end
      end

      def set_ars_titles
        if self.alignment_reports.finalized.present?
          self.alignment_reports.finalized.map{ |ar| ar.title.to_snake_case }.uniq
        end
      end

      def set_grades
        if self.alignment_reports.finalized.present? || self.publish_without_alignment_report
          self.components.map do |component|
            if component.grade.downcase == 'pre-k'
              return 'prek'
            elsif component.grade.downcase == 'k'
              return 'k kindergarten'
            elsif component.grade.downcase == 'elementary'
              return 'k kindergarten 1 2 3 4 5 elementary'
            elsif component.grade.downcase == 'middle school'
              return '6 7 8 middle_school'
            elsif component.grade.downcase == 'high school'
              return 'high_school'
            else
              return component.grade.downcase
            end
          end
        end
      end

      def set_state_adopted_filter
        if self.state_verified_correlations.present? && !self.state_alignment?
          "yes"
        else
          "no"
        end
      end

      def set_state_adopted
        if self.state_verified_correlations.present? && !self.state_alignment?
          "state adopted"
        end
      end

      def set_special_populations
        self.components.map{|c| c.special_populations.map{ |sp| sp.downcase } unless c.special_populations.nil? }.uniq
      end

      def set_special_populations_filter
        self.components.map{|c| c.special_populations.map{ |sp| sp.to_snake_case } unless c.special_populations.nil? }.uniq
      end

      def set_title_sort
        self.title.gsub(/\W+/, ' ').to_snake_case
      end

      def set_publisher_name_sort
        self.publisher_name.gsub(/\W+/, ' ').to_snake_case
      end

      def set_compatibility
        if self.first_component.device_agnostic
          "device agnostic html5"
        else
          devices = self.first_component.compatible_devices
          ActionView::Base.full_sanitizer.sanitize(devices)
        end
      end

      def set_formats
        self.components.map{|c| c.material_format.map{ |mf| mf.downcase } unless c.material_format.nil? }.uniq
      end

      def set_formats_filter
        self.components.map{|c| c.material_format.map{ |mf| mf.to_snake_case } unless c.material_format.nil? }.uniq
      end

      def set_types
        self.components.map{|c| c.material_type.map{ |mt| mt.downcase } unless c.material_type.nil? }.uniq
      end

      def set_types_filter
        self.components.map{|c| c.material_type.map{ |mt| mt.to_snake_case } unless c.material_type.nil? }.uniq
      end

      def subjects
        self.components.map(&:subject_title)
      end

      def set_subjects
        subjects.map{|s| s.gsub(/\W+/, ' ').downcase }.uniq
      end

      def set_subjects_sort
        if subjects.any?
          subjects_sanitized = subjects.map{|s| s.gsub(/\W+/, ' ').to_snake_case }.uniq
          subjects_sanitized.first
        else
          []
        end
      end

      def set_submitted_at
        submitted  = self.status_changes.find { |status_change| status_change[:status] == "submitted" }
        if submitted
          submitted.created_at.to_time.iso8601
        else
          self.created_at.to_time.iso8601
        end
      end

      def set_coverage
        if self.alignment_reports.finalized.present?
          self.alignment_reports.finalized.desc(:coverage_percent).first.try(:coverage_percent) || 0
        end
      end

      def set_standard
        if self.publish_without_alignment_report
          'teks'
        else
          self.alignment_reports.finalized.map{ |ar| ar.alignment_template.standard.search_dropdown.to_snake_case }.uniq
        end
      end

      def set_main_grade_index
        if self.alignment_reports.finalized.present?
          fv = FormValue.all_of(:model_name => 'Component', :attribute_name => 'grade').first
          fv.values_list.index(components.first.grade) || 99
        end
      end

      def self.search(query, options={})
        __set_filters = lambda do |f|

          @search_params[:filter][:and] ||= []
          @search_params[:filter][:and]  |= [f]
        end


        __set_sort = lambda do |key, order|
          @search_params[:sort][key] ||= order
        end


        @search_params = {
          query: {},
          filter: {},
          sort: {}
        }

        unless query.blank?
          sanitized_q = query.gsub((/[^\w\s"?*\\]/), '').strip.downcase
          @search_params[:query] = {
            query_string: {
              fields: ['title^3', 'publisher_name', 'subjects^1', 'grade^1', 'components_kind', 'state_adopted^2', 'special_populations', 'ars_grade', 'standard', 'description'],
              query: sanitized_q,
              default_operator: "and",
              minimum_should_match: "90%",
              allow_leading_wildcard: true,
              use_dis_max: true
            }
          }
        else
          if options['sort'].blank? || options['sort'] == 'natural'
            # if query and sort aren't set, sort by subject, grade, publisher, 
            # alignment report titles and product titles
            __set_sort.("sort_subject", 'asc')
            __set_sort.("main_grade_index", 'asc')
            __set_sort.("sort_ars_titles", 'asc')
            __set_sort.("sort_publisher_name", 'asc')
            __set_sort.("sort_title", 'asc')
            @search_params[:track_scores] = true
          end

          @search_params[:query] = { match_all: {} }
        end

        f = { term: { state: "published" } }
        __set_filters.(f)

        if options['standard'].present? && options['standard'] != "all" && options['standard'] != "no_selection"
          published_federal_standards = ::Domain::Standard::Queries::PublishedAndFederalSearchDropdowns.!
          f = { terms: { standard: [*options['standard'], *published_federal_standards].uniq, execution: "or" } }
          __set_filters.(f)
        end

        if options['size'].present?
          @search_params[:size] = options['size']
        end
        if options['from'].present?
          @search_params[:from] = options['from']
        end

        if options['grade'].present? && options['grade'] != 'no_selection' && options['grade'] != "all_grade_levels"

          options['grade'] = options['grade'].to_snake_case
          if options['subscription_type'] && options['subscription_type'] == 'trial'
            options['grade'] = %w(4)
          else
            case options['grade']
            when 'pre_k'
              options['grade'] = %w(prek)
            when 'elementary'
              options['grade'] = %w(k kindergarten 1 2 3 4 5 elementary)
            when 'middle_school'
              options['grade'] = %w(6 7 8 middle_school)
            when 'high_school'
              options['grade'] = %w(9 10 11 12 high_school high school)
            end
          end

          f = { terms: { grade: [*options['grade']], execution: "or" } }
          __set_filters.(f)
        else 
          if options['subscription_type'] && options['subscription_type'] == 'trial'
            options['grade'] = %w(4)
            f = { terms: { grade: [*options['grade']], execution: "or" } }
            __set_filters.(f)
          end
        end

        if options['subject'].present? && options['subject'] != 'all_subjects' && options['subject'] != 'no_selection'

          f = { term: { sort_subject: options['subject'].to_snake_case } }
          __set_filters.(f)
        end

        if options['material_format'].present? && options['material_format'] != 'all_material_formats' && options['material_format'] != 'no_selection'
          if options['material_format'] == "print_and_or_online"
            options['material_format'] = %w(print online)
            f = { terms: { filter_format: [*options['material_format']], execution: "or" } }
            __set_filters.(f)

          elsif options['material_format'] == "other_digital_media_e_g_usb_or_cd_rom"
            f = { term: { filter_format: 'digital_e_g_usb_or_cd_rom' } }
            __set_filters.(f)
          else
            f = { term: { filter_format: options['material_format'].to_snake_case } }
            __set_filters.(f)
          end
        end

        if options['material_type'].present? && options['material_type'] != 'all_material_types' && options['material_type'] != 'no_selection'

          f = { term: { filter_type: options['material_type'].to_snake_case } }
          __set_filters.(f)
        end

        if options['state_adopted'].present? && options['state_adopted'] != 'no_selection'

          f = { term: { filter_state_adopted: options['state_adopted'].downcase } }
          __set_filters.(f)
        end


        if options['special_populations'].present? && options['special_populations'] != 'all_special_populations' && options['special_populations'] != 'no_selection'

          f = { term: { filter_special_populations: options['special_populations'].to_snake_case } }
          __set_filters.(f)
        end

        if options['publisher'].present? && options['publisher'] != 'all_publishers' && options['publisher'] != 'no_selection'

          f = { term: { sort_publisher_name: options['publisher'].to_snake_case } }
          __set_filters.(f)
        end

        if options['coverage'].present?
          f = { range: { coverage: { from:  options['coverage'].to_i } } }
          __set_filters.(f)
        end

        if options['library_id'].present?
          f = { term: { library_ids: options['library_id'] } }
          __set_filters.(f)
        end

        if options['sort'].present? && options['sort'] != 'natural'
          __set_sort.("coverage", 'desc')           if options['sort'] == 'coverage'
          __set_sort.(options['sort'], 'asc')       if options['sort'].present? && options['sort'] != 'coverage'
          __set_sort.("sort_subject", 'asc')
          __set_sort.("main_grade_index", 'asc')
          __set_sort.("sort_ars_titles", 'asc')
          __set_sort.("sort_publisher_name", 'asc')
          __set_sort.("sort_title", 'asc')
          @search_params[:track_scores] = true
        end

        __elasticsearch__.search(@search_params)
      end

    end
  end
end