# frozen_string_literal: true

require 'iso_bib_item/localized_string'

module IsoBibItem
  # Formatted string
  class FormattedString < LocalizedString
    # @return [String]
    attr_reader :type

    # @param content [String]
    # @param language [String] language code Iso639
    # @param script [String] script code Iso15924
    # @param type [String] the format type, default "plain"
    #   available types "plain", "html", "dockbook", "tei", "asciidoc",
    #   "markdown", "isodoc"
    def initialize(content:, language: nil, script: nil, type: 'plain')
      super(content, language, script)
      @type = type
    end

    def to_xml(builder)
      builder.parent["format"] = type if type
      super
    end
  end
end
