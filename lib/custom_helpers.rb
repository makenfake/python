require 'lib/custom_helpers/metadata_helpers'
require 'lib/custom_helpers/page_data_helpers'
require 'lib/custom_helpers/site_config_helpers'
require 'lib/custom_helpers/markup_helpers'


module CustomHelpers
  include CustomHelpers::MetadataHelpers
  include CustomHelpers::PageDataHelpers
  include CustomHelpers::SiteConfigHelpers
  include CustomHelpers::MarkupHelpers
end
