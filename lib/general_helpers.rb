require 'lib/general_helpers/metadata_helpers'
require 'lib/general_helpers/page_data_helpers'
require 'lib/general_helpers/site_config_helpers'
require 'lib/general_helpers/markup_helpers'


module GeneralHelpers
    include GeneralHelpers::MarkupHelpers
    include GeneralHelpers::MetadataHelpers
    include GeneralHelpers::PageDataHelpers
    include GeneralHelpers::SiteConfigHelpers
end
