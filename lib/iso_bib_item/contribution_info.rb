# frozen_string_literal: true

require 'iso_bib_item/person'

# Isobib module
module IsoBibItem
  # Contributor's role.
  class ContributorRole
    # @return [Array<IsoBibItem::FormattedString>]
    attr_reader :description

    # @return [ContributorRoleType]
    attr_reader :type

    # @param type [String] allowed types "author", "editor",
    #   "cartographer", "publisher"
    # @param description [Array<String>]
    def initialize(*args)
      @type = args.fetch 0
      @description = args.fetch(1, []).map { |d| FormattedString.new content: d, type: nil }
    end

    def to_xml(builder)
      builder.role(type: type) do
        description.each do |d|
          builder.description { |desc| d.to_xml(desc) }
        end
      end
    end
  end

  # Contribution info.
  class ContributionInfo
    # @return [Array<IsoBibItem::ContributorRole>]
    attr_reader :role

    # @return
    #   [IsoBibItem::Person, IsoBibItem::Organization,
    #    IsoBibItem::IsoProjectGroup]
    attr_reader :entity

    # @param entity [IsoBibItem::Person, IsoBibItem::Organization,
    #   IsoBibItem::IsoProjectGroup]
    # @param role [Array<String>]
    def initialize(entity:, role: ['publisher'])
      @entity = entity
      @role   = role.map { |r| ContributorRole.new(*r) }
    end

    def to_xml(builder)
      entity.to_xml builder
    end
  end
end
